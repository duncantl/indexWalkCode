\name{getByIndex}
\alias{getByIndex}
\title{Subset the code/AST using an \code{IndexPath}}
\description{
  Uses the IndexPath computed with \code{\link{indexWalkCode}}
  to extract the corresponding element of the AST/code.
}
\usage{
getByIndex(ast, idx, type = NA)
}
\arguments{
  \item{ast}{the same code object used in the call to \code{\link{indexWalkCode}}
   to compute the \code{idx}}
 \item{idx}{the \code{IndexPath} or an integer vector giving the sequence of indices to get to
   the desired element in the code/language object.  If this is not of class \code{IndexPath},
   the function will create the path using the value of \code{type}.}
 \item{type}{the type argument passed to the predicate function.
 This should be "formals", "body" or ""}
}
\value{
 An element from the code, i.e., a  language object or a literal value.
}
\author{
Duncan Temple Lang
}
\seealso{
  \code{\link{indexWalkCode}}
}
\examples{
  f = function(x, b) {
         if(b > 0)
            foo(x)

         foo(bar(x))
   }  

   p = function(x, idx, ast, ...) 
          isCallTo(x, "foo") && isCallTo(getParent(ast, idx), "if")
   i = indexWalkCode(f, p)

   getByIndex(f, i[[1]])
}
\keyword{programming}
\concept{metaprogramming}

