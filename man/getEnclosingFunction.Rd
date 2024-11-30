\name{getEnclosingFunction}
\alias{getEnclosingFunction}
\title{Find parent/enclosing function of a nested function}
\description{
  Having found a function object by walking the AST,
  this allows one to find the enclosing function(s)
  for that function.
}
\usage{
getEnclosingFunction(idx, ast, assignment = FALSE)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{idx}{the index path to the nested function call, or the assignment of that nested function call}
  \item{ast}{the top-level language object/AST}
  \item{assignment}{a logical value} %XXX
}
\value{
  A list of one or more language objects which are either calls to \code{function}
  or a top-level function object.
}
\author{
Duncan Temple Lang
}
\seealso{
  \code{\link{indexWalkCode}}
  \code{\link{getAncestors}}
}
\examples{

top = function(x, y) {

  tmp = x/y

  two = function(a, b) {
     tmp2 = a*b
     g = function(x) {
          tmp2 + x + sum(tmp)
     }


     g(b^2)
  }

  two(x, 2*y)
}

# Find the nested function() calls

idx = indexWalkCode(top,
                    pred = function(x, ...)
                                is.call(x) && isSymbol(x[[1]], "function"))

a = getEnclosingFunction(idx[[2]], top)
length(a)


# Find the assignments of the nested function calls, i.e. two = function()... and
# g = function()...

idx2 = indexWalkCode(top,
                     pred = function(x, ...)
                                is.call(x) && isSymbol(x[[1]], c("=", "<-")) &&
                                    is.call(x[[3]]) && isSymbol(x[[3]][[1]], "function"))

b = getEnclosingFunction(idx2[[2]], top, TRUE)

}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory (show via RShowDoc("KEYWORDS")):
\keyword{programming}
\concept{meta-programming}
