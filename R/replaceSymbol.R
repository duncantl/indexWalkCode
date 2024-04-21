replaceSymbol =
function(fun, sym, with)    
{
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
    } else
        fun = code

    fun
}
