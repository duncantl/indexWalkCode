replaceSymbol =
    # Also see insertByIndex.
function(fun, sym, with, rmSrcref = TRUE)    
{
    # Handle empty symbol which is the default value for a function parameter.
    if(is.symbol(fun) && as.character(fun) == "")
        return(fun)

    with = as.name(with)

    isFun = is.function(fun)

    if(isFun) {
        code = body(fun)
    } else
        code = fun
    
    z = indexWalkCode(code, function(x, ...) isSymbol(x, sym))
    for(i in z) 
        code [[ i ]] = with

    if(isFun) {
        body(fun) = code
        w = names(formals(fun)) == as.character(sym)
        if(any(w))
            names(formals(fun))[w] = as.character(with)

        formals(fun) = lapply(formals(fun), replaceSymbol, sym, with)
    } else
        fun = code

    if(rmSrcref)
        attr(fun, "srcref") = NULL    

    fun
}
