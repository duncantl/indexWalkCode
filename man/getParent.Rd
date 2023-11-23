\name{getParent}
\alias{getParent}
\alias{getAncestors}
\alias{getSiblings}
\title{Access the code tree, specifically upwards or sideways}
\description{
  These functions allow a caller to walk up
  or across an AST (abstract syntax tree) of R code
  starting from a specific node in the tree.
}
\usage{
getParent(ast, idx, type = NA)
}
\arguments{
  \item{ast}{the top-level, entire AST relative to which \code{idx} was computed.}
  \item{idx}{the \code{IndexPath} identifying the node in the tree.}
  \item{type}{the type passed to the predicate function in calls from \code{\link{indexWalkCode}}}
}

\value{
  An R language object or literal value.
}
\author{
Duncan Temple Lang
}

\seealso{\code{\link{indexWalkCode}}}

\examples{
}
\keyword{programming}
\concept{metaprogramming}
