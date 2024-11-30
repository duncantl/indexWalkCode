\name{isCallTo}
\alias{isCallTo}
\alias{mkIsCallTo}
\alias{isAssignTo}
\alias{isSymbol}
\alias{isFunction}
\alias{isFunctionAssign}
\title{Predicate functions useful for find nodes in R code via \code{indexWalkCode}}
\description{
  These predicate functions are building blocks to writing
  predicate functions for identifying nodes in R code/Abstract Syntax Trees (ASTs).

  \code{mkIsCallTo} creates a predicate that tests for a call to any of a set of
  R functions.


  \code{isFunction} tests whether the language object is a function or a
  call to \code{function} which will create a function when evaluated.

  \code{isFunctionAssign} tests for an assignment where the right-hand-side is
  a call to \code{function}.
}
\usage{
isCallTo(code, funName)
isSymbol(x, varName)
isAssignTo(code, varName)
mkIsCallTo(fun)
isFunction(code)
isFunctionAssign(code)
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
  isCallTo(quote(foo(x)), "foo")
  isCallTo(quote(foo(x)), c("foo", "bar"))
  isCallTo(quote(other(x)), c("foo", "bar"))

  isSymbol( quote(x), "x")
  isSymbol( quote(x), "foo")
  isSymbol( quote(x) )

  isAssignTo( quote( x <- foo(y)) , "x")
  isAssignTo( quote( x <- foo(y)) , "y")

  e = parse(text = "x = 1")[[1]]
  isAssignTo( e , "x")

  p = mkIsCallTo("list.files")
  i = indexWalkCode(tools:::.check_packages, p)
}
%  i = codetools::walkCode(tools:::.check_packages, p)
\keyword{programming}
\concept{metaprogramming}
