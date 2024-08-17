getEnclosingFunction =
    #
    # Handle nested functions and allow getting the immediate one or the top-most.
    #
function(idx, ast, assignment = FALSE)
{
    anc = getAncestors(idx, ast)
    w = sapply(anc, isFunDef)
    if(!any(w))
        return(NULL)

    if(sum(w) > 1) 
       return( structure(anc[w], names = sapply(anc[which(w) - 1], getAssignName)  ) )

    i = max(which(w))

    if(assignment && i < length(anc))
        i = i + 1L 

    anc[[i]]
}

isFunDef =
function(x)
  is.function(x) || (is.call(x) && is.symbol(x[[1]]) && as.character(x[[1]]) == "function")        

getAssignName =
function(x)    
{
    ok = is.call(x) && is.symbol(x[[1]]) && as.character(x[[1]]) %in% c("=", "<-") && is.symbol(x[[2]])

    if(ok)
        as.character(x[[2]])
    else
        ""
}
