# Copied from the codetools package and adapted to allow additional arguments
# so that we can pass the index  as we loop over elements in the call, leaf and other handler functions.
# The changes are adding ... in the function signature and in the calls to the different handlers.
# These walker-specific functions have to accept these additional arguments.
walkCode2 =
function (e, w, ...) 
{
    if (typeof(e) == "language") {
        if (typeof(e[[1]]) %in% c("symbol", "character")) {
            h <- w$handler(as.character(e[[1]]), w)
            if (!is.null(h)) 
                h(e, w, ...)
            else w$call(e, w, ...)
        }
        else w$call(e, w, ...)
    }
    else w$leaf(e, w, ...)
}

