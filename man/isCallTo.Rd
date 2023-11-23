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
}
\arguments{
  \item{code}{}
  \item{funName}{}
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
