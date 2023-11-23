library(indexWalkCode)

sc = parse("walk.R")
i = indexWalkCode(sc, mkIsCallTo("is.name"))
k = getByIndex(sc, i[[1]])
k[[1]] = as.name("isName")
sc2 = insertByIndex(k, sc, i[[1]])


