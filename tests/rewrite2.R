library(indexWalkCode)

sc = parse("walk.R")
i = indexWalkCode(sc, mkIsCallTo("is.name"))
k = getByIndex(sc, i[[1]])
k[[1]] = as.name("isName")
sc2 = insertByIndex(k, sc, i[[1]])

# If you print sc2, it appears the change was not made.
# This is because R is showing the srcref.
# Now remove the srcref attribute by default in insertByIndex().


i2 = indexWalkCode(sc2, mkIsCallTo("isName"))
stopifnot(length(i) == length(i2))
stopifnot(identical(i[[1]], i2[[1]]))
# The names are different since they are 
stopifnot(identical(unname(i), unname(i2)))

