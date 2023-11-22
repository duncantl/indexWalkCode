#
# This is an experiment in creating a version of walkCode() from codetools
# that allows us to collect indices if elements in the AST that match some criteria.
# The intent is to be able to use these indices to
# a) move up the tree, e.g., to check the parent, ancestors and siblings of a node in the predicate
#    or after the traversal, and
# b) modify the AST after the travesal by inserting new/updated language objects at a specific location.
#
# Nick (Ulle) did this in rstatic::find_nodes().
#
# This comes from working on copyParameters.R (which I'll move here soon) and rewriting
# functions - formals and body - to add parameters to calls.  I used rstatic to be able to
# update the language objects. 
#

mkIsCallTo =
function(fun)    
    function(x, idx, type, ast) 
        is.call(x) && is.name(x[[1]]) && as.character(x[[1]]) %in% fun


indexWalkCode =
function(code, pred)
{
    w = mkIndexWalker(pred, code)
    walkCode2(code, w, idx = integer(), type = "")
    w$ans()
}

mkIndexWalker = 
function(pred, ast)
{
    ans = list()

    leaf = function(x, w, idx, type) {
        ty = typeof(x)
        if(ty == "pairlist" || ty == "list") {
            lapply(seq(along.with = x), function(i) walkCode2(x[[i]], w, c(idx, i), type))
            return(NULL)
        } else if(ty == "closure") {
            walkCode2(formals(x), w, idx, "formals") # lapply(formals(x), walkCode, w)
            walkCode2(body(x), w, idx, "body")
        } else if(ty == "symbol")
            pred(x, idx, type, ast)

        NULL
    }

    capture =
        function(idx, type) {
            #            browser()

            klass = switch(type,
                           "body" = "BodyIndex",
                           "formals" = "FormalsIndex",
                           "BasicIndex")
            
            idx = c(if(is.na(type) || type == "")
                       NA
                    else if(type == "body")
                        1L
                    else 0L,
                    idx)

            class(idx) = c(klass, "IndexPath")
            ans[[ length(ans) + 1L]] <<- idx
        }
    
    
    call = function(x, w, idx, type) {
        if(pred(x, idx, type, ast))
            capture(idx, type)

        tmp = as.list(x)
        for(i in seq(along.with = tmp)) {
            ee = tmp[[i]]
            if (!missing(ee))
                walkCode2(ee, w, c(idx, i), type)
        }
    }

    list(handler = function(...) NULL,
         call = call,
         leaf = leaf,
         ans = function() {
                 ans
             })    
}


getIndexObj = 
function(ast, idx, type = NA, dropSelf = TRUE)
{    
    obj = if(is.na(type)) {
              ty = idx[1]
              idx = idx[-1]
              if(is.na(ty))
                  ast
              else switch(as.character(ty),
                     "0" = formals(ast),
                     "1" = body(ast),
                     ast)
          } else               
              switch(type,
                     body = body(ast),
                     formals = formals(ast),
                     ast)

    if(dropSelf)
        idx = idx[ - length(idx)]

    list(obj = obj, idx = idx)
}

getComponent =
function(idx, type = NA)    
{
    if(is.na(type)) {
        ty = idx[1]
         switch(as.character(ty),
               "0" = "formals",
               "1" = "body",
                "")
    } else               
        switch(type,
               body = "body",
               formals = "formals",
               "")    
}

insertByIndex =
function(x, ast, idx, type = NA)
{
    tmp = getIndexObj(ast, idx, type)

    comp = getComponent(idx, type)
    comp = if(comp == "") "ast" else sprintf("%s(ast)", comp)
    txt = sprintf("%s%s <- x",
                  comp, 
                  paste(sprintf("[[ %d ]]", c(tmp$idx, idx[length(idx)])), collapse = "" ))
    e = parse(text = txt)

    val = eval(e, sys.frame(sys.nframe()))
    ast
}


getByIndex =
function( ast, idx, type = NA)
{
    p = getParent(ast, idx, type)
    p[[ idx[ length(idx) ] ]]
}

getParent =
function(ast, idx, type = NA)
{
    tmp = getIndexObj(ast, idx, type)

    obj = tmp$obj
    for(i in tmp$idx)
        obj = obj[[i]]

    obj
}

getAncestors =
    #
    # Need to enhance to handle when type is NA and the type is the first element
    # of idx. Same as getParent().
    #
function(ast, idx, type = NA)
{
    tmp = getIndexObj(ast, idx, type)
    
    orig = obj = tmp$obj
    idx = tmp$idx
    
    ans = vector("list", length(idx))
    for(i in seq(along.with = idx) )
        ans[[i]] = obj = obj[[i]]

    # add the body or parameter and then the ast itself.
    rev(c(ast, orig, ans))
}

