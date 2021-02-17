#' @references \url{https://www.ncbi.nlm.nih.gov/books/NBK25498/}
#' @export
NCBI.eSearch <- function(
  db = "nucleotide",
  term = "human[orgn]+AND+biomol+mrna[prop]",
  retstart = "0",
  retmax = "499",
  usehistory = "y",
  protocol = "https://",
  domain = "eutils.ncbi.nlm.nih.gov",
  slug = "/entrez/eutils/esearch.fcgi?",
  params = "db=${db}&term=${term}&usehistory=${usehistory}&retstart=${retstart}&retmax=${retmax}",
  method = httr::GET,
  ...
) {
  query <- stringr::str_interp(
    params,
    append(
      list(
        db = db, term = term, usehistory = usehistory, retstart = retstart, retmax = retmax
      ),
      list(...)
    )
  )
  url <- paste0(protocol, domain, slug, query, sep = "")
  result <- method(url)
  content <- httr::content(result, as = "parsed")

  xmlrefs <- list(
    WebEnv = xml2::xml_find_all(content, xpath = ".//WebEnv"),
    RetMax = xml2::xml_find_all(content, xpath = ".//RetMax"),
    RetStart = xml2::xml_find_all(content, xpath = ".//RetStart"),
    QueryKey = xml2::xml_find_all(content, xpath = ".//QueryKey"),
    TermSet = xml2::xml_find_all(content, xpath = ".//TermSet"),
    Field = xml2::xml_find_all(content, xpath = ".//Field"),
    Count = xml2::xml_find_all(content, xpath = ".//Count")

    )
  refs <- lapply(xmlrefs, xml2::xml_text)

  idlist <- sapply(
    xml2::xml_find_all(content, xpath = "IdList"),
    function(xmlnode) {
      children <- xml2::xml_children(xmlnode)
      xml2::xml_text(children)
    }
  )

  append(refs, list(IdList = idlist, result = result))
}


# #   hijuelagranperra <- "https://eutils.ncbi.nlm.nih.gov/entrez/eutils/elink.fcgi?dbfrom=${dbfrom}&db=${db}&id=${id}&linkname=${linkname}&cmd=neighbor_history"
# #
# #   stringr::str_interp(
# #     hijuelagranperra,
# #     list(
# #       db = NA_character_,
# #       id = NA_character_,
# #       dbfrom = NA_character_,
# #       linkname = NA_character_
# #     )
# #   )

# .getNCBI <- function(url=NULL, ...) {
#   output <- NULL

#   .help <- ""
#   .base <- ""

#   if (is.null(url)) {
#     message(.help)
#     return(output)
#   }

#   if (is.character(url)) {
#     warning("TODO:: ")
#     FALSE
#   }

#   return(output)
# }

# #' NCBI remote queries and transforms
# #' @references https://www.ncbi.nlm.nih.gov/home/develop/api/
# BLAST <- list(
#   base = c(),
#   slug = c(),
#   opt = c(),
#   db = c()
# )

# EUTILS <- list(
#     base = "https://eutils.ncbi.nlm.nih.gov/entrez/eutils/",
#     elink = c(
#       slug = c(
#         "elink.fcgi?dbfrom=${dbfrom}&db=${db}&id=${id_list}",
#         "&linkname=${linkname}&cmd=neighbor_history",
#         "&query_key=$key1&WebEnv=$web1"
#       )
#     ),
#     efetch = c(
#       slug = c(
#         "efetch.fcgi?db=$db2&query_key=$key&WebEnv=$web",
#         "&rettype=xml&retmode=xml"
#       )
#     ),
#     esearch = c(
#       slug = c(
#         "esearch.fcgi?db=$db1&term=$query&usehistory=y"
#       )
#     ),
#     esummary = c(
#       slug = c(
#         "esummary.fcgi?db=$db2&query_key=$key2&WebEnv=$web2"
#       )
#     )
# )

# .collapseSlug <- function(...) {
#   paste(..., collapse = "")
# }

# .formatQuery <- function(base, slug, argv) {
#   paste0(base, stringr::str_interp(.collapseSlug(slug), argv))
# }

# #' @export
# NCBI.queryEntrez <- function(...) {
#   .formatQuery(...)
# }

# #' @export
# NCBI.queryBLAST <- function(...) {}

# #' @export
# NCBI.query <- function(method, ...) {}

# #' #' @export
# #' setClass(
# #'   "NCBIResult",
# #'   slots = c(Meta = "list", Data = "list")
# #' )
# #'
# #' #' @export
# #' setClass(
# #' 	"NCBIEutilsResult",
# #' 	contains = "NCBIResult
# #' )
# #' #' @export
# #' setClass(
# #' 	"NCBIBLASTResult",
# #' 	contains = "NCBIResult"
# #' )
# #'
# #' #' @export
# #' NCBI.fetch <- function(
# #' 	input.vals = NULL,
# #' 	input.type = NULL,
# #' 	result.vals = NULL,
# #' 	result.type = NULL
# #' ){
# #' 	if (is.null(input.vals)) {
# #' 		return("<default>")
# #' 	}
# #'
# #' 	if (inherits(input.type, c("character", "numeric"))) {
# #' 		if (any(match(result.type, c("protein")))) {
# #' 			if (any(match(result.vals, "sequence"))) {
# #' 			  NULL
# #' 				# NCBI.fetchSequence(
# #' 				# 	input.vals = input.vals,
# #' 				# 	input.type = input.type,
# #' 				# 	result.type = result.type
# #' 				# )
# #' 			}
# #' 		}
# #' 	}
# #'
# #'
# #' }
# #'
# #' #' @export
# #' NCBI.fetchSequence <- function(
# #' 	input.vals = c(),
# #' 	input.type = c(),
# #' 	result.type = "protein"
# #' ) {
# #' 	# TODO::
# #' 	## https://www.ncbi.nlm.nih.gov/books/NBK25498/#_chapter3_Basic_Pipelines_
# #'  return(NULL)
# #' }
# #'
# #' #' @export
# #' NCBI.fetchProtein <- function(
# #' 	input.vals = c(),
# #' 	input.type = NULL,
# #' 	result.type = NULL
# #' ) {
# #' 	# TODO::
# #' 	## https://www.ncbi.nlm.nih.gov/books/NBK25498/#_chapter3_EPost__ESummaryEFetch
# #'  return(NULL)
# #' }
# #'
# #' #' High-level NCBI queries
# #' #' @' @export
# #' NCBI.query <- function() { NULL }
