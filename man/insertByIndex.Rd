\name{insertByIndex}
\alias{insertByIndex}
\title{Rewrite part of an R AST using an index to the node.}
\description{
  Replace the node identified by the specified index
  in an R language object/abstract syntax tree (AST).
}
\usage{
insertByIndex(x, ast, idx, type = NA, rmSrcref = TRUE)
}
\arguments{
  \item{x}{the new code object/node to be inserted into the AST}
  \item{ast}{the original AST from which \code{idx} was computed}
  \item{idx}{the \code{IndexPath} identifying the node in the AST.}
  \item{rmSrcref}{a logical value that controls whether
    to remove the original \code{srcref} attribute on the AST
    being returned. Without this, printing the resulting code/AST may
    not show the updates.    
   }
  \item{type}{this should not be necessary}
}

\value{
  The updated R code object/AST.
}
\author{
Duncan Temple Lang
}

\seealso{
\code{\link{indexWalkCode}}
}
\examples{
   f = function(x, y) {
        a = foo(x)
        b = foo(y)

        foo(a + b)
   }

   idx = indexWalkCode(f, mkIsCallTo("foo"))

   f2 = f
   for(i in idx) {
      k = getByIndex(f2, i)
      k$otherArg = TRUE
      f2 = insertByIndex(k, f2, i)
   }

   f2

   indexWalkCode(f2, mkIsCallTo("foo"), collectCode = TRUE)$code
}
\keyword{programming}
\concept{metaprogramming}
