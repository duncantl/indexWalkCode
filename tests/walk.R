library(indexWalkCode)

ff = system.file("sampleCode/eg.R", package = "indexWalkCode")
source(ff)

pred = function(x, idx, type, ast) {
         is.call(x) && is.name(x[[1]]) && as.character(x[[1]]) == "do.call"
       }

i = indexWalkCode(g, pred)
i = indexWalkCode(f, pred)



#walkCode2(g, w, idx = integer(), NA)

#w = mkIndexWalker(pred, f)
#walkCode2(f, w, idx = integer(), NA)


