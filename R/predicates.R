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

