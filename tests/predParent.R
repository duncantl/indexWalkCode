library(indexWalkCode)

# use the index walker to check the parent in a predicate function.
# Find the use of args in the call
#  o2 = do.call(order, args)
#
pred2 = function(x, idx, ast, type) {
#    print(x)
    isSymbol(x, "args") &&
        isCallTo(p <- getParent(idx, ast, type), "do.call") &&
        isSymbol(p[[2]], "order" )
}

ff = system.file("sampleCode/eg.R", package = "indexWalkCode")
source(ff)

idx = indexWalkCode(body(eg3), pred2)

getByIndex(idx[[1]], body(eg3))
getParent(idx[[1]], body(eg3))


# [Fixed] The following doesn't work.
# Error in obj[[i]] : object of type 'closure' is not subsettable
# In the predicate, we are calling getParent() but the value of idx is a simple
# vector not an IndexPath.  We need to use the type to call mkIndexPath(idx, type)
# or have the IndexPath object be created before calling the predicate. The latter is expensive.
# We could analyze the predicate and see if we need to create the IndexPath for each call.
# We can leave it to the person writing the predicate, but that is not very good.
# We can have getParent() require the type if the idx is not an IndexPath and then compute
# the IndexPath there.
idx = indexWalkCode(eg3, pred2)
