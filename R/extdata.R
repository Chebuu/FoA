#' `ELMdb`
#' @example \dontrun{`
#' `elm.eu.org/elm/` <- system.file("extdata/elm.eu.org/elm/", package = "foa")
#' elm <- list.files(`elm.eu.org/elm/`, full.names = TRUE)
#' ELMdb <- setNames(
#'   lapply(elm, function(x) read.delim(x, sep = "\t")),
#'   gsub("^.*/elm/|\\.tsv", "", elm)
#' )
#' }

#' `BG43194db`
#' @example \dontrun{
#' BG43194db.files <- list.files(
#'   system.file(
#'     "extdata/thebiogrid.org/BIOGRID-PROJECT-covid19_coronavirus_project-LATEST",
#'     package = "foa"
#'   ),
#'   full.names = TRUE
#' )
#' BG43194db <- setNames(
#'   lapply(BG43194db.files, function(f) read.delim(f, header = T)),
#'   gsub(".*project-|(PTM|GENES|INTERACTIONS)|-.*\\..*\\.txt", "\\1", BG43194db.files)
#' )
#' }
