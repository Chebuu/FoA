# .myDomain.encodeHit <- function(
#   start = NA_integer_,
#   stop =  NA_integer_,
#   shape = NA_integer_,
#   color = NA_integer_,
#   label = NA_character_
# ) {
#   stringr::str_interp(
#     "${start},${stop},${shape}_${color},${label}"
#   )
# }

# .myDomain.encodeRange <- function(
#   start = NA_integer_,
#   stop =  NA_integer_,
#   type = 0
# ) {
#   stringr::str_interp(
#     "${start},${stop},${type}"
#   )
# }

# .myDomain.encodeSite <- function(
#   position = NA_integer_,
#   type = 0
# ) {
#   stringr::str_interp(
#     "${start},${stop},${type}"
#   )
# }

# #' @example \code{
# #'.myDomain.encodeQuery(
# #'  hits = list(
# #'    c(100, 200, 1, 1, "TEST"),
# #'    c(30, 90, 1, 2, "TEST2")
# #'  ),
# #'  len = 1000
# #' )
# #' }
# .myDomain.encodeQuery <- function(
#   len,
#   hscale = 1.0,
#   hits = list(),
#   sites = list(),
#   ranges = list()
# ) {
#   .doEncode <- function(x, encoding) {
#     paste(
#       lapply(x, function(.x) {
#         if (any(is.na(.x))) return("")
#         do.call(encoding, as.list(.x))
#       }),
#       collapse = "+"
#     )
#   }

#   uhits <- .doEncode(hits, .myDomain.encodeHit)
#   usites <- .doEncode(sites, .myDomain.encodeSite)
#   uranges <- .doEncode(ranges, .myDomain.encodeRange)

#   gsub(
#     "\\+\\+", "+",
#     stringr::str_interp(
#       paste0(
#         "https://prosite.expasy.org/cgi-bin/prosite/PSImage.cgi",
#         "?hit=${uhits}&site=${usites}&range=${uranges}",
#         "&len=${len}&hscale=${hscale}"
#       )
#     )
#   )
# }

# #' #' @concept Generate one PNG image URL per Entrez gene with ProSite domains annotated
# #' #' @details `https://prosite.expasy.org/cgi-bin/prosite/PSImage.cgi?hit=50,150,2_4,MY+300,400,3_2,DOMAIN&range=100,200,1&site=320,1&len=700&hscale=0.8`
# #' #' @example \code{
# #' #' PROSITE.encodePSImageURL(CoV2.ORF3a.Human.PROSITE)
# #' #' }
# #' #' @export
# #' PROSITE.encodePSImageURL <- function(dataset, hscale=0.7) {
# #'   .encodeGroupedPSImageArgs <- function(datasubset, subsetkey) {
# #'     .collapseGroupedDomains <- function(domainsubset, subsetkey) {
# #'       paste(
# #'         paste(
# #'           domainsubset[["scanprosite_start"]],
# #'           domainsubset[["scanprosite_end"]],
# #'           sep = ","
# #'         ),
# #'         paste(
# #'           paste(
# #'             domainsubset[["shape_1"]],
# #'             domainsubset[["shape_2"]],
# #'             sep = "_"
# #'           ),
# #'           domainsubset[["scanprosite"]],
# #'           sep = ","
# #'         ),
# #'         collapse = "+",
# #'         sep = ","
# #'       )
# #'     }
# #'     list(
# #'       id = datasubset[["entrezgene_id"]][[1]],
# #'       query = stringr::str_interp(
# #'         "hit=${hit}&range=${range}&site=${site}&len=${len}&hscale=${hscale}",
# #'         list(
# #'           hit = (
# #'             datasubset %>%
# #'               dplyr::mutate(
# #'                 shape_1 = 1 %% 6 ,
# #'                 shape_2 = 1 %% 4
# #'               ) %>%
# #'               dplyr::grouped_df(
# #'                 vars = c("scanprosite"), drop = FALSE
# #'               ) %>%
# #'               dplyr::group_map(
# #'                 .f = .collapseGroupedDomains, .keep = TRUE
# #'               ) %>%
# #'               paste(
# #'                 collapse = "+"
# #'               )
# #'           ),
# #'           range = "1,2,3",
# #'           site = "1,2",
# #'           len = max(as.numeric(datasubset[["scanprosite_end"]])),
# #'           hscale = "1.8"
# #'         )
# #'       )
# #'     )
# #'   }
# #'
# #'   formatted <- dataset %>%
# #'     as.data.frame() %>%
# #'     dplyr::filter(scanprosite != "") %>%
# #'     dplyr::mutate(
# #'       range = "",
# #'       site = "",
# #'       label = as.character(scanprosite),
# #'       len = ifelse(
# #'         "len" %in% names(.),
# #'         as.character(len),
# #'         ifelse(
# #'           "cds_length" %in% names(.),
# #'           as.character(
# #'             as.numeric(cds_length) / 3
# #'           ),
# #'           as.character(
# #'             6 + max(as.numeric(scanprosite_end))
# #'           )
# #'         )
# #'       ),
# #'       hscale = ifelse(
# #'         (
# #'           "hscale" %in% names(.)
# #'           & !is.na(is.numeric(hscale))
# #'         ),
# #'         as.character(hscale),
# #'         stringr::str_interp("${hscale}")
# #'       )
# #'     )
# #'
# #'     grouped <- formatted %>%
# #'       dplyr::grouped_df(
# #'         vars = c("entrezgene_id"), drop = FALSE
# #'       ) %>%
# #'       dplyr::group_map(
# #'         .f = .encodeGroupedPSImageArgs, .keep = TRUE
# #'       ) %>%
# #'       lapply(
# #'         function(group) {
# #'           entrez <- group[["id"]]
# #'           query <- group[["query"]]
# #'           list(
# #'             PSImageEntrez = entrez,
# #'             PSImageURL = stringr::str_interp(
# #'               'https://prosite.expasy.org/cgi-bin/prosite/PSImage.cgi?${query}'
# #'             )
# #'           )
# #'         }
# #'       )
# #'
# #'     bind_rows(grouped)
# #' }
