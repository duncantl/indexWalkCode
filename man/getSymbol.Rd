\name{getSymbol}
\alias{getSymbol}
\alias{hasSymbol}
\title{Find or get a given symbol in code}
\description{
 These find the occurrences of the given symbol in the code if it is present.
}
\usage{
getSymbol(code, sym)
hasSymbol(code, sym)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{code}{the code in which to search for the specified symbol}
  \item{sym}{a character or name object identifying the symbol being sought}
}
\value{
  \code{hasSymbol} returns a logical scalar value.

  \code{getSymbol} returns a list containing the index path
  for each occurrence of that symbol in the code.
}
\author{
Duncan Temple Lang
}
\seealso{
  \code{\link{indexWalkCode}}
}
\examples{
   getSymbol(indexWalkCode, "integer")
}
