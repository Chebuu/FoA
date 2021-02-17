# https://www.tidyverse.org/blog/2020/06/embed-0-1-0/
# https://datatricks.co.uk/one-hot-encoding-in-r-three-simple-methods

######
## DEL
######

#' `Matrix funtions`
# https://cran.rstudio.com/web/packages/matrixStats/index.html
# https://www.bioconductor.org/packages/3.1/bioc/vignettes/MSstats/inst/doc/MSstats.pdf

######
## END
######


#' @title Sparse matrix structures
#' @about A small collection of `Matrix` extensions and wrappers.
#' @references https://cran.r-project.org/web/packages/Matrix/Matrix.pdf
#' @export
setClass(
  Class = "M",
  slots = c(meta = "list", m = "Matrix"),
  prototype = list(meta = list(), m = Matrix::Matrix(FALSE, sparse = T))
)

#' @export
setGeneric(
  name = "M",
  def = function(m, ...) {
    new("M", m = Matrix(m, sparse = T), meta = list(...)["meta"])
  }
)

#' @export
setMethod(
  "as.matrix",
  signature(x = "M"),
  function(x, ...) {
    m <- as.matrix(x@m, ...)
    attr(m, "meta") <- as.list(x@meta)
    return(m)
  }
)
