library(indexWalkCode)

f = function(x, y = length(x))
{
   x  + y
}

replaceSymbol(f, "x", "abc")


##########


k = parse("walk.R")
k2 = replaceSymbol(k, "pred", "predicate")

