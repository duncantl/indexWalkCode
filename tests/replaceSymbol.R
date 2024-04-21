library(indexWalkCode)

f = function(x, y = length(x))
{
   x  + y
}

replaceSymbol(f, "x", "abc")
