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
    # Create a predicate function that checks if the AST object is
    # a call to the specified function.
    # This captures fun and returns a function which can be used as the predicate
    # function in walkCode or indexWalkCode.
function(fun)    
    function(x, ...)  # idx, type, ast) 
        is.call(x) && isSymbol(x[[1]], fun)

isSymbol =
    # Copied from CodeAnalysis. Need to rationalize.
function (x, sym) 
is.name(x) && as.character(x) %in% sym


indexWalkCode =
    #
    #
    #
    #
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




