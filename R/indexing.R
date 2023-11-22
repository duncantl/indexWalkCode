mkIndexPath =
function(idx, type) 
{
#            browser()
    klass = switch(type,
                   "body" = "BodyIndex",
                   "formals" = "FormalsIndex",
                   "BasicIndex")
    
#   idx = c(if(is.na(type) || type == "")
#               NA
#           else if(type == "body")
#               1L
#           else 0L,
#           idx)

    class(idx) = c(klass, "IndexPath")
    idx
}

if(FALSE) 
getIndexObj = 
function(ast, idx, type = NA, dropSelf = TRUE)
{    
    obj = if(is.na(type)) {
              ty = idx[1]
              idx = idx[-1]
              if(is.na(ty))
                  ast
              else switch(as.character(ty),
                     "0" = formals(ast),
                     "1" = body(ast),
                     ast)
          } else               
              switch(type,
                     body = body(ast),
                     formals = formals(ast),
                     ast)

    if(dropSelf)
        idx = idx[ - length(idx)]

    list(obj = obj, idx = idx)
}


getIndexObj =
    #
    # Which part of the ast - body, formals or the entire ast
    # and the index but that is less important now.
    #
function(ast, idx, type = NA, dropSelf = TRUE)
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
#  if(is.na(type)) {
#      ty = idx[1]
#       switch(as.character(ty),
#             "0" = "formals",
#             "1" = "body",
#              "")
#  } else               
#      switch(type,
#             body = "body",
#             formals = "formals",
#             "")    
}

