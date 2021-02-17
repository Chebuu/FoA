#' `convert the whole UniProt Proteins API into a single R function` <-
#' @example \dontrun{
#' function(...) {
#'    httr::GET("https://www.ebi.ac.uk/proteins/api/doc/#proteinsApi")
#'      ==> "/coordinates/location/{accession}:{pStart}-{pEnd}"
#'        ==> stringr::str_interp(
#'          "/coordinates/location/${accession}:${pStart}-${pEnd}", ...)
#'  }
#' }

.GET_UniProtAPI <- function(slug) {
  httr::GET(
    sprintf("https://www.ebi.ac.uk/proteins/api/%s", slug)
  )
}

UniProt.getAccession <- function(accession) {
  .GET_UniProtAPI(sprintf("accession/%s", accession))
}

UniProt.getCoordinates <- function(accession) {

}

UniProt.getCoordinatesStartEnd <- function(accession, pStart, pEnd) {
  slug <- sprintf(
    "/coordinates/location/%s:%s-%s",
    accession, pStart, pEnd
  )

  .GET_UniProtAPI(slug)
}

qBM.getTREMBLSequence <- function(...) {
  biomaRt::getBM(
    attributes = c(

    ),
    values = list(...),
    filterns = names(...)
  )

}

# # https://cran.r-project.org/web/packages/UniprotR/index.html
# # https://bioconductor.org/packages/devel/bioc/manuals/UniProt.ws/man/UniProt.ws.pdf
# # https://www.ebi.ac.uk/proteins/api/doc/#!/features/getByAccession
# .getByAccession <- function(accession) {
#   slug <- paste0(
#     "https://www.ebi.ac.uk/proteins/api/features/",
#     "${accession}?categories=DOMAINS_AND_SITES&types=DOMAIN"
#   )
#   url <- stringr::str_interp(slug) # TrixXxies
#   result <- httr::GET(url)
#   content <- httr::content(result, as = "parsed")
#   return(content)
# }

# UniProt.getByAccession <- function(...) .getByAccession(...)

# # UniProt.getSequenceByAccession <- function(accession2label) {
# #   apply(
# #     accession2label, 1,
# #     function(row) {
# #       uaccs <- stringr::str_split(row[["accession"]], "\\|")
# #       if (all(grepl("^A0", "", uaccs))) return(NA)
# #       splitted <- uaccs[!grepl(uaccs, "^A0")]
# #       result <- .getByAccession(accession = splitted[[1]]) # Only get the first one
# #       append(
# #         row,
# #         list(
# #           query = row[["accession"]],
# #           sequence = result[["sequence"]]
# #         )
# #       )
# #     }
# #   )
# # }

# # library(dplyr)
# # library(stringr)

# # data(INTERACTIONS)
# # colnames(INTERACTIONS)
# # unique(INTERACTIONS[["Organism.Name.Interactor.A"]])

# .groupBy <- function(Interactions, .groups=NULL, ...) {
#   object <- as.list(...)

#   # # DEL
#   # library(FoA)
#   # Interactions <- INTERACTIONS
#   # object <- list(".groupBy" = "Entrez.Gene.Interactor.A")
#   # .groups <- NULL
#   # # END

#   if (is.null(.groups)) {
#     if (!all(is.na(match(names(object), c(".groupBy"))))) {
#       Genes <- object[[".groupBy"]]
#     }
#     if (!all(is.na(match(colnames(Interactions), c("Group"))))) {
#       Genes <- Interactions[["Groups"]]
#     }
#     if (!all(is.na(match(colnames(Interactions), c("Entrez.Gene.Interactor.A"))))) {
#       Genes <- Interactions[["Entrez.Gene.Interactor.A"]]
#     }
#   } else {
#     Genes <- .groups
#   }

#   Interactions  %>%
#     group_split(
#       # "Group", # TODO::
#       "Organism.Name.Interactor.A", # # TODO::
#       "Experimental.System",
#       .keep = TRUE
#     ) %>%
#     lapply(
#       function(Group) {
#         UniProtAcc <- lapply(
#           Group[["TREMBL.Accessions.Interactor.B"]],
#           function(uacc) {
#               spp <- unlist(str_split(uacc, "\\|"))
#               acc <- spp[!grepl(spp, "^A0")][1[]]
#               return(acc)
#           }
#         )

#         Group %>%
#           mutate(
#             "UniProtAcc" = UniProtAcc
#           ) %>%
#           select(
#             "Entrez.Gene.Interactor.A",
#             "Entrez.Gene.Interactor.B",
#             "TREMBL.Accessions.Interactor.B",
#             "Experimental.System",
#             "Author",
#             "UniProtAcc",
#             "Sequence",
#           )
#       }
#     )
# }

# #' @title UniProt remote queries and transforms
# #' @teruega \code{stringr::str_interp(...)}
# #' @references https://www.ebi.ac.uk/proteins/api
# #' @references https://www.ncbi.nlm.nih.gov/books/NBK25498/

# UNIPROT <- list(
# 	base = "",
# 	slugs = list(),
# 	dbs = list(),
# 	opts = list()
# )


# .formatUniProtQuery <- function(base, slug, argv) {
# 	paste0(base, stringr::str_interp(slug, argv))
# }

# #' @export
# setClass(
# 	"UniProt",
# 	slots = c("character")
# )

# #' @export
# UniProt.fetch <- function(
# 	input.vals = NULL,
# 	input.type = NULL,
# 	result.vals = NULL,
# 	result.type = NULL
# ){

# 	if (is.null(input.vals)) {
# 		return("<default>")
# 	}

# 	if (inherits(input.type, c("character", "numeric"))) {
# 		if (any(match(result.type, c("protein")))) {
# 			if (any(match(result.vals, "sequence"))) {
# 				# UniProt.fetchSequence(
# 				# 	input.vals = input.vals,
# 				# 	input.type = input.type,
# 				# 	result.type = result.type
# 				# )
# 			}
# 		}
# 	}
# }

# # #' @export
# # UniProt.fetchSequence <- function(
# # 	input.vals = c(),
# # 	input.type = c(),
# # 	result.type = "protein"
# # ) {
# # 	# TODO::
# # 	## https://www.UniProt.nlm.nih.gov/books/NBK25498/#_chapter3_Basic_Pipelines_
# # }

# # #' @export
# # UniProt.fetchProtein <- function(
# # 	input.vals = c(),
# # 	input.type = NULL,
# # 	result.type = NULL
# # ) {
# # 	# TODO::
# # 	## https://www.UniProt.nlm.nih.gov/books/NBK25498/#_chapter3_EPost__ESummaryEFetch
# # }

# #' @title `UniParc.fetch`
# #' @example \code{
# #' UniParc.fetch(
# #'   input.values = list(
# #'     "entrez.gi" = c(123, 456, 7890, 111213)
# #'   )
# #' )
# #' }

# #' @references https://www.ebi.ac.uk/proteins/api/doc/#!/uniparc
# #' @export
# UniParc.fetch <- function(
# 	input.vals = NULL,
# 	input.type = NULL,
# 	result.vals = NULL,
# 	result.type = NULL,
# 	...
# ){

#   result <- list()

#   if (is.null(input.vals)) {
#     warning("TODO:: ")
#     FALSE
#   }

#   if (any("entrez.gi" == names(input.type))) {
#     entrez.gi <- input.type[["entrez.gi"]]
#   }

#   if (any("AAString" == names(result.type))) {
#     if (exists("entrez.gi", envir = parent.frame())) {
#       warning("TODO:: ")
#       FALSE
#     }
#   }

# }
