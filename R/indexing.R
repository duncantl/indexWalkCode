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

getComponent =
function(idx, type = NA)    
{
    if(is.na(type)) {
        ty = idx[1]
         switch(as.character(ty),
               "0" = "formals",
               "1" = "body",
                "")
    } else               
        switch(type,
               body = "body",
               formals = "formals",
               "")    
}

