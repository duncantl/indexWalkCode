    pred = function(x, idx, type, ast) {
                k = is.call(x) && is.name(x[[1]]) && as.character(x[[1]]) == "do.call"
                if(k) browser()
                k
    }

    indexWalkCode(g, pred)

    w = mkIndexWalker(pred, g)
    walkCode2(g, w, idx = integer(), NA)
    
    w = mkIndexWalker(pred, f)
    walkCode2(f, w, idx = integer(), NA)

    sc = parse("~/GitWorkingArea/CodeAnalysis/R/indexASTWalker.R")[[2]][[3]]
    i = indexWalkCode(sc, mkIsCallTo("is.name"))
    k = getByIndex(sc, i[[1]])
    k[[1]] = as.name("isName")
    sc2 = insertByIndex(k, sc, i[[1]])


if(FALSE)  {
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
    

}

