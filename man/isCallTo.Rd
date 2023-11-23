\name{isCallTo}
\alias{isCallTo}
\alias{mkIsCallTo}
\alias{isAssignTo}
\alias{isSymbol}
\title{Predicate functions useful for find nodes in R code via \code{indexWalkCode}}
\description{
}
\usage{
isCallTo(code, funName)
mkIsCallTo(fun)
isSymbol(x, varName)
isAssignTo(code, varName)
}
\arguments{
  \item{x,code}{the R call object}
  \item{fun,funName}{a character vector of names of functions
    we want to match.}
  \item{varName}{a character vector of the names of variables we want to match.}
}
\value{
  \code{mkIsCallTo} returns a function.
  
  The other functions are useful within predicate functions
  users write.
}

\author{
Duncan Temple Lang
}

\seealso{
  \code{\link{indexWalkCode}}
}
\examples{
}
\keyword{programming}
\concept{metaprogramming}
