## ## https://github.com/reactome/ReactomeContentService4R
##
# https://bioconductor.org/packages/release/bioc/html/ReactomePA.html

##
# .encodePathwayDiagramJS <- function() {
#   # https://reactome.org/dev/diagram#API
#   # https://reactome.org/dev/diagram/js#API
# }

#' @title `Reactome`
#' @description
#' Reactome R client ([github.com/reactome/ReactomeGraph4R](https://github.com/reactome/ReactomeGraph4R))
#' Reactome Content Service API ([reactome.org](cehttps://reactome.org/ContentService/))
#' Reactome content service API [documentation](https://chilampoon.github.io/projects/ReactomeContentService4R.html)
#' @concept An R interface to The Reactome Project


.PathwayAnalysisService <- function() {
# https://reactome.org/AnalysisService/#/download
}

Reactome.fetch <- function() {
  warning("TODO:: ")
}

#' `Reactome.searchToI`
#' @concept A structured wrapper for `ReactomeContentService4R::searchQuery`
#' @example \dontrun{
#' results <- Reactome.searchToI(
#'   list(
#'     "coagulation" = list(species = "Homo sapiens"),
#'     "complement" = list(species = "Homo sapiens"),
#'     "inflammation" = list(species = "Homo sapiens"),
#'     "kawasaki" = list(species = "Homo sapiens")
#'   )
#' )
#' }
#' @export
Reactome.searchToI <- function(toi) {
  setNames(
    lapply(names(toi), function(term) {
      term.argv <- as.character(toi[[term]])
      call.args <- append(list(query = term),term.argv)
      tryCatch(
        do.call(ReactomeContentService4R::searchQuery, as.list(call.args)),
        error = function(e) {warning(e); return(list(NA))},
        warning = function(w) {warning(cat(w, term, c(term.argv)))} # TODO::
      )
    }),
    names(toi)
  )
}
