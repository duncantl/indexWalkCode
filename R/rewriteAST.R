insertByIndex =
function(x, ast, idx, type = NA, rmSrcref = TRUE)
{
    if(!inherits(idx, "IndexPath"))
        idx = mkIndexPath(idx, type)
    
    tmp = getIndexObj(ast, idx)

    comp = getASTComponent(idx, type)
    comp = if(comp == "") "ast" else sprintf("%s(ast)", comp)
    txt = sprintf("%s%s <- x",
                  comp, 
                  paste(sprintf("[[ %d ]]", c(tmp$idx, idx[length(idx)])), collapse = "" ))
    e = parse(text = txt)

    val = eval(e, sys.frame(sys.nframe()))

    if(rmSrcref)
        attr(ast, "srcref") = NULL
    
    ast
}
