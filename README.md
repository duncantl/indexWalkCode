# The indexWalkCode Package

This is a package that provides similar functionality as the `walkCode()` function in codetools
but uses an index path to identify elements in the R code/Abstract Syntax Tree (AST).
These indices allow us to
a) move up the tree, e.g., to check the parent, ancestors and siblings of a node in the predicate
  function of \code{indexWalkCode} or after the traversal, and
b) modify the AST after the travesal by inserting new/updated language objects at a specific location.

Nick (Ulle) did this in rstatic::find_nodes().

This comes from working on copyParameters.R (which I'll move here soon) and rewriting
functions - formals and body - to add parameters to calls.  I used rstatic to be able to
update the language objects. 


## IndexPath

The \code{IndexPath} is a simple integer vector giving us the sequence
of elements to sequentially subset from the top-most node of the AST
to the target element identified by the index path.

When process a function, a simple sequence of indices doesn't unambiguously 
identify the element of the AST. We need to know whether the sequence is
relative to the formal arguments/parameters or the body of the function.

The package creates index path objects of classes FormalsIndex, BodyIndex and BasicIndex to
differentiate these cases.
