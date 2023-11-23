\name{indexWalkCode}
\alias{indexWalkCode}
\title{Walk R code to identify elements and get the indices to those elements}
\description{
}
\usage{
indexWalkCode(code, pred, collectCode = FALSE, w =
              mkIndexWalker(pred, code, collectCode))
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
  \item{w}{the list of code walker handlers}
  \item{collectCode}{a logical value controlling whether to also
    collect the actual nodes in the AST corresponding to the
    elements the predicate identifies, along with the list of \code{IndexPath}
    objects.
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
   f = indexWalkCode:::mkIndexWalker
   i = indexWalkCode(f,  mkIsCallTo("pred"))
   i
   getByIndex(f, i[[1]])
   getParent(f, i[[1]])
}
\keyword{programming}
\concept{metaprogramming}

