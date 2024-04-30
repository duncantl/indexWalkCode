hasSymbol =
function(code, sym)    
{
    #    syms = getAllSymbols(code)
    length(getSymbol(cod, sym)) > 0
    sym %in% syms
}

# rcode2$"EFRM_constructCommitteeTableForFilingProcess"

getSymbol =
function(code, sym)
    indexWalkCode(code,  function(x, type, ...) isSymbol(x, sym))


getAncestors2 =
    # See getAncestors in treeAccessors.
function(p, code)
{
    i = seq(along.with = p)[-c(1, length(p))]
    lapply(i, function(i) { idx = structure(p[1:i], class = c("BasicIndex", "IndexPath"))
                                  tmp = code[[ idx ]] 
                                })
}

getAncestorFuns =
function(idx, code, ...)    
{
    a = getAncestors(idx, code)
    fns = sapply(a, function(x) deparse(x[[1]], ...))
}
