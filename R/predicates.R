mkIsCallTo =
    # Create a predicate function that checks if the AST object is
    # a call to the specified function.
    # This captures fun and returns a function which can be used as the predicate
    # function in walkCode or indexWalkCode.
function(fun)    
    function(x, ...)  # idx, type, ast)
        isCallTo(x, fun)


isSymbol =
    # Copied from CodeAnalysis. Need to rationalize.
function (x, varName = character()) 
   is.name(x) && ((length(varName) == 0) || as.character(x) %in% varName)



isCallTo =
function (code, funName) 
{
   (is.call(code) || inherits(code, "call")) && isSymbol(code[[1]], funName)
}

isAssignTo =
function (code, varName) 
{
   inherits(code, c("<-", "=")) && isSymbol(code[[2]], varName)
}
