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


indexWalkCode =
    #
    # The entry point to walk the AST and return the list of IndexPaths
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
            walkCode2(formals(x), w, idx, "formals") 
            walkCode2(body(x), w, idx, "body")
        } else if(ty == "symbol") {
            if(pred(x, idx, type, ast))
                capture(idx, type, x)
        }

        NULL
    }

    capture = function(idx, type, x = NULL)  {
        ans[[ length(ans) + 1L]] <<-  mkIndexPath(idx, type)
        if(!is.null(x))
           names(ans)[ length(ans) ] <<-  paste(deparse(x), collapse = "")
    }

    call = function(x, w, idx, type) {
        if(pred(x, idx, type, ast))
            capture(idx, type, x)

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
         ans = function() 
                 ans
         )   
}




