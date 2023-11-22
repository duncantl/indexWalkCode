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
