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
getAncestors(ast, idx, self = FALSE, type = NA)
getSiblings(ast, idx, before = TRUE, type = NA)
}
\arguments{
  \item{ast}{the top-level, entire AST relative to which \code{idx} was computed.}
  \item{idx}{the \code{IndexPath} identifying the node in the tree.}
  \item{type}{should not be necessary.
    The type passed to the predicate function in calls from \code{\link{indexWalkCode}}}
  \item{before}{a logical value. If \code{TRUE}, \code{getSiblings} returns
    the sibling nodes before the current node; otherwise, the nodes after the current node.
  }
}

\value{
An R language object or literal value.
}
\author{
Duncan Temple Lang
}

\seealso{\code{\link{indexWalkCode}}}

\examples{
  # using getParent() in a predicate function
  f = function(x, b) {
         if(b > 0)
            foo(x)

         foo(bar(x))
   }  

   # Find foo(x) but not foo(bar(x)) because foo(x) is a child of
   # the if().
   # Note should the if() have a {}, then we have to look at the ancestors, not the direct parent.
   p = function(x, idx, ast, ...) 
          isCallTo(x, "foo") && isCallTo(getParent(ast, idx), "if")
   i = indexWalkCode(f, p)

   # We can also use getParent() with the results from indexWalkCode()
   getByIndex(f, i[[1]])


   # Note should the if() have a {}, then we have to look at the ancestors, not the direct parent.
   g = function(x, b) {
         if(b > 0) {
           for(i in x)
               foo(i)
         }

         foo(bar(x))
   }  

   p = function(x, idx, ast, ...) 
          isCallTo(x, "foo") && any(sapply(getAncestors(ast, idx), isCallTo, "if"))

   i = indexWalkCode(g, p)
   i

   a = rev(getAncestors(g, i[[1]], self = TRUE))
   sapply(a, class)
}
\keyword{programming}
\concept{metaprogramming}
