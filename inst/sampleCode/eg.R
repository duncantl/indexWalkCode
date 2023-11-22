f = function(x, y = do.call(foo, x))  x + y
g = function(x, y ) {
    z = do.call(foo, list(x, y))
    z + 1L
}

eg3 = function(x, y, df) {
    o = order(x)
    o2 = do.call(order, list(x, y))

    o3 = do.call(order, list(x, y, na.last = FALSE))

    # Need to update args - or inline c(args, p1 = p1, p2 = p2)
    args = list(x, y)
    args$z = x + y
    o2 = do.call(order, args)

    # not order
    o3 = do.call(foo, args)

    o4 = lapply(df, order, decreasing = TRUE)
    o5 = mapply(order, x, y)
    o5 = mapply(order, x, y, MoreArgs = list(decreasing = TRUE))

    o5 = mapply(order, x, y, MoreArgs = list(decreasing = TRUE, method = "radix"))

    o5 = mapply(order, x, y, MoreArgs = foo(x + y))        

    foo(x[order(y)])
}

