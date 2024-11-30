\name{indexWalkCode}
\alias{indexWalkCode}
\title{Walk R code to identify elements and get the indices to those elements}
\description{
  Traverse the R code/Abstract Syntax Tree (AST) and find
  nodes identified by the predicate function (\code{pred})
  and return a list of \code{IndexPath}
  that identify these specific nodes.
  These \code{IndexPath} can then be used to
  rewrite the AST.

  The \code{IndexPath} objects can also be used by the predicate
  function to query "up" the tree, i.e., the parent, ancestors
  and siblings of the current node.
}
\usage{
indexWalkCode(code, pred, collectCode = FALSE, w =
              mkIndexWalker(pred, code, collectCode, missing = missing),
              missing = FALSE)
}
\arguments{
  \item{code}{any R code} %  or an environment
  \item{pred}{a predicate function used to identify each element
    of interest whose index path is to be returned.
    This is called with the node in the AST, the index path to the current node,
    the top-level AST and the type of this index path (which can be ignored.)
    This function must return \code{TRUE} or \code{FALSE}.
    The function can query the parent node, ancestors and siblings.
    One should write predicate functions with a signature
     \code{function(node, index, ast, ...)}
  }
  \item{w}{the list of code walker handlers}
  \item{collectCode}{a logical value controlling whether to also
    collect the actual nodes in the AST corresponding to the
    elements the predicate identifies, along with the list of \code{IndexPath}
    objects.
  }
  \item{missing}{logical scalar controlling whether the code walking functions call the predicate
    function for missing arguments in a call.}
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
   getByIndex(i[[1]], f)
   getParent(i[[1]], f)
}
\keyword{programming}
\concept{metaprogramming}

