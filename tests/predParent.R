# use the index walker to check the parent in a predicate function.
# Find the use of args in the call
#  o2 = do.call(order, args)
#
pred2 = function(x, idx, type, ast) {
    print(x)
    isSymbol(x, "args") &&
        isCallTo(p <- getParent(ast, idx, type = type), "do.call") &&
        isSymbo(p[[2]], "order" )
}

idx = indexWalkCode(body(eg3), pred2)

