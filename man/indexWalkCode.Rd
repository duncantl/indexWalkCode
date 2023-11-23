\name{indexWalkCode}
\alias{indexWalkCode}
\title{Walk R code to identify elements and get the indices to those elements}
\description{
}
\usage{
indexWalkCode(code, pred)
}
\arguments{
  \item{code}{any R code} %  or an environment
  \item{pred}{a predicate function used to identify each element
    of interest whose index path is to be returned.
    This is called with the node in the AST, the index path to the current node,
    the type of this index path and the top-level AST.
    This function must return \code{TRUE} or \code{FALSE}.
    The function can query the parent node, ancestors and siblings.
   }
}
\value{
A list of \code{IndexPath} objects.
}
\author{
Duncan Temple Lang  
}
\seealso{
  \code{\link{getParent}},
  \code{\link{getAncestors}}
  \code{\link{getSiblings}}  
}
\examples{
   f = indexWalkCode:::indexWalkCode
   i = indexWalkCode(f,  mkIsCallTo("pred"))
   i
   getByIndex(f, i[[1]])
}
\keyword{programming}
\concept{metaprogramming}

