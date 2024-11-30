\name{getParent}
\alias{getParent}
\alias{getAncestors}
\alias{getAncestorFuns}
\alias{getSiblings}
\title{Access the code tree, specifically upwards or sideways}
\description{
  These functions allow a caller to walk up
  or across an AST (abstract syntax tree) of R code
  starting from a specific node in the tree.
}
\usage{
getParent(idx, ast, type = NA)
getAncestors(idx, ast, self = FALSE, type = NA)
getSiblings(idx, ast, before = TRUE, type = NA)
getAncestorFuns(idx, code, ...)
}
\arguments{
  \item{idx}{the \code{IndexPath} identifying the node in the tree.}
  \item{ast,code}{the top-level, entire AST relative to which \code{idx} was computed.}
  \item{type}{should not be necessary.
    The type passed to the predicate function in calls from \code{\link{indexWalkCode}}}
  \item{self}{a logical value. If \code{TRUE}, \code{getAncestors} includes
   the actual node in the results; otherwise, only the parent and its parents, etc. are returned}
  \item{before}{a logical value. If \code{TRUE}, \code{getSiblings} returns
    the sibling nodes before the current node; otherwise, the nodes after the current node.
  }
  \item{\dots}{additional arguments passed to \code{\link[base]{parse}}}
}

\value{
  An R language object or literal value.

  \code{getAncestorFuns} returns a list of language objects.
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
          isCallTo(x, "foo") && isCallTo(getParent(idx, ast), "if")
   i = indexWalkCode(f, p)

   # We can also use getParent() with the results from indexWalkCode()
   getByIndex(i[[1]], f)


   # Note should the if() have a {}, then we have to look at the ancestors, not the direct parent.
   g = function(x, b) {
         if(b > 0) {
           for(i in x)
               foo(i)
         }

         foo(bar(x))
   }  

   p = function(x, idx, ast, ...) 
          isCallTo(x, "foo") && any(sapply(getAncestors(idx, ast), isCallTo, "if"))

   i = indexWalkCode(g, p)
   i

   a = rev(getAncestors(i[[1]], g, self = TRUE))
   sapply(a, class)
}
\keyword{programming}
\concept{metaprogramming}
