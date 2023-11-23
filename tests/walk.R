library(indexWalkCode)

pred = function(x, idx, type, ast) {
    k = is.call(x) && is.name(x[[1]]) && as.character(x[[1]]) == "do.call"
#    if(k) browser()
    k
}

indexWalkCode(g, pred)

w = mkIndexWalker(pred, g)
walkCode2(g, w, idx = integer(), NA)

w = mkIndexWalker(pred, f)
walkCode2(f, w, idx = integer(), NA)

