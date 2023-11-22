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

