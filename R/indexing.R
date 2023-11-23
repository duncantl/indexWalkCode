mkIndexPath =
function(idx, type) 
{
    klass = switch(type,
                   "body" = "BodyIndex",
                   "formals" = "FormalsIndex",
                   "BasicIndex")
    
    class(idx) = c(klass, "IndexPath")
    idx
}

getIndexObj =
    #
    # Which part of the ast - body, formals or the entire ast
    # and the index but that is less important now.
    #
function(ast, idx, dropSelf = TRUE)
{
    obj = switch(class(idx)[1],
                 BodyIndex = body(ast),
                 FormalsIndex = formals(ast),
                 ast
                 )

    if(dropSelf)
        idx = idx[ - length(idx)]    

    list(obj = obj, idx = idx)
}

getASTComponent =
    #
    #
    #
function(idx, type = NA)    
{
    switch(class(idx)[1],
           BodyIndex = "body",
           FormalsIndex = "formals",
           ""
           )
}

