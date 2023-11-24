library(indexWalkCode)

    # example of rewriting calls to order() to add decreasing = decreasing and na.last = na.last
    # Comes from copyParameters.R example.

    # Need eg3 as a function.
ff = system.file("sampleCode/eg.R", package = "indexWalkCode")
source(ff)
    # Was in if(FALSE)    eval(parse("~/GitWorkingArea/CodeAnalysis/R/indexASTWalker.R")[[1]][[3]])

    # Find the locations of the direct calls to order in the body.
    # Get the call objects using the indices.
    # Rewrite them to add named arguments
    # Insert them into the body
    # Update the body of eg3
b = body(eg3)
i = indexWalkCode(b,  mkIsCallTo("order"))
k = lapply(i, getByIndex, b)
k2 = lapply(k, function(x) { x[ c("decreasing", "na.last")] = sapply(c("decreasing", "na.last"), as.name); x})
for(j in seq(along.with = i)) 
    b = insertByIndex(k2[[ j ]], i[[ j ]], b)
body(eg3) = b
    # Note that we can't use lapply() as we are updating b in each iteration.
    # Also, if we change the structure of b, the following indices may not be correct.
