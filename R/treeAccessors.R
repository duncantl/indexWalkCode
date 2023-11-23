getByIndex =
function( ast, idx, type = NA)
{
    p = getParent(ast, idx, type)
    p[[ idx[ length(idx) ] ]]
}

getParent =
function(ast, idx, type = NA)
{
    if(!inherits(idx, "IndexPath"))
        idx = mkIndexPath(idx, type)
    
    tmp = getIndexObj(ast, idx)

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
function(ast, idx, self = FALSE, type = NA)
{
    if(!inherits(idx, "IndexPath"))
        idx = mkIndexPath(idx, type)
    
    tmp = getIndexObj(ast, idx, dropSelf = !self)
    
    orig = obj = tmp$obj
#    idx = tmp$idx
    
    ans = vector("list", length(tmp$idx))
    for(i in seq(along.with = tmp$idx) )
        ans[[i]] = obj = obj[[ tmp$idx[i] ]]

    # add the body or parameter and then the ast itself.
    rev(c(ast, orig, ans))
}


getSiblings =
function(ast, idx, before = TRUE, type = NA)
{
    if(!inherits(idx, "IndexPath"))
        idx = mkIndexPath(idx, type)

    p = getParent(ast, idx)
    els = as.list(p)
    pos = idx[length(idx)]

    if(before)
        els[ seq_len(pos - 1L) ]
    else
        els[ pos + seq_len(length(els) - pos) ]        
}
