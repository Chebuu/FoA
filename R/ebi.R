# # https://www.ebi.ac.uk/interpro/api/
# # https://www.ebi.ac.uk/ols/ontologies/mi/terms?obo_id=MI%3A0004
# # https://github.com/ProteinsWebTeam/interpro7-api/tree/master/docs#5-how-do-i-retrieve-a-list-of-uniprotkb-reviewed-proteins-containing-the-entry-ipr002117-domain

# ### https://www.bioconductor.org/packages/release/bioc/vignettes/trackViewer/inst/doc/trackViewer.html
# # library(httr) # load library to get data from REST API
# # APIurl <- "https://www.ebi.ac.uk/proteins/api/" # base URL of the API
# # taxid <- "9606" # human tax ID
# # gene <- "TP53" # target gene
# # orgDB <- "org.Hs.eg.db" # org database to get the uniprot accession id
# # eid <- mget("TP53", get(sub(".db", "SYMBOL2EG", orgDB)))[[1]]
# # chr <- mget(eid, get(sub(".db", "CHR", orgDB)))[[1]]
# # accession <- unlist(lapply(eid, function(.ele){
# #   mget(.ele, get(sub(".db", "UNIPROT", orgDB)))
# # }))
# # stopifnot(length(accession)<=20) # max number of accession is 20
# #
# # tryCatch({ ## in case the internet connection does not work
# #   featureURL <- paste0(APIurl,
# #                        "features?offset=0&size=-1&reviewed=true",
# #                        "&types=DNA_BIND%2CMOTIF%2CDOMAIN",
# #                        "&taxid=", taxid,
# #                        "&accession=", paste(accession, collapse = "%2C")
# #   )
# #   response <- GET(featureURL)
# #   if(!http_error(response)){
# #     content <- content(response)
# #     content <- content[[1]]
# #     acc <- content$accession
# #     sequence <- content$sequence
# #     gr <- GRanges(chr, IRanges(1, nchar(sequence)))
# #     domains <- do.call(rbind, content$features)
# #     domains <- GRanges(chr, IRanges(as.numeric(domains[, "begin"]),
# #                                      as.numeric(domains[, "end"]),
# #                                      names = domains[, "description"]))
# #     names(domains)[1] <- "DNA_BIND" ## this is hard coding.
# #     domains$fill <- 1+seq_along(domains)
# #     domains$height <- 0.04
# #     ## GET variations. This part can be replaced by user-defined data.
# #     variationURL <- paste0(APIurl,
# #                            "variation?offset=0&size=-1",
# #                            "&sourcetype=uniprot&dbtype=dbSNP",
# #                            "&taxid=", taxid,
# #                            "&accession=", acc)
# #     response <- GET(variationURL)
# #     if(!http_error(response)){
# #       content <- content(response)
# #       content <- content[[1]]
# #       keep <- sapply(content$features, function(.ele) length(.ele$evidences)>2 && # filter the data by at least 2 evidences
# #                        !grepl("Unclassified", .ele$clinicalSignificances)) # filter the data by classified clinical significances.
# #       nkeep <- c("wildType", "alternativeSequence", "begin", "end",
# #                  "somaticStatus", "consequenceType", "score")
# #       content$features <- lapply(content$features[keep], function(.ele){
# #         .ele$score <- length(.ele$evidences)
# #         unlist(.ele[nkeep])
# #       })
# #       variation <- do.call(rbind, content$features)
# #       variation <-
# #         GRanges(chr,
# #                 IRanges(as.numeric(variation[, "begin"]),
# #                         width = 1,
# #                         names = paste0(variation[, "wildType"],
# #                                        variation[, "begin"],
# #                                        variation[, "alternativeSequence"])),
# #                 score = as.numeric(variation[, "score"]),
# #                 color = as.numeric(factor(variation[, "consequenceType"]))+1)
# #       variation$label.parameter.gp <- gpar(cex=.5)
# #       lolliplot(variation, domains, ranges = gr, ylab = "# evidences", yaxis = FALSE)
# #     }else{
# #       message("Can not get variations. http error")
# #     }
# #   }else{
# #     message("Can not get features. http error")
# #   }
# # },error=function(e){
# #   message(e)
# # },warning=function(w){
# #   message(w)
# # },interrupt=function(i){
# #   message(i)
# # })

# #################
# #################
# #################
# #################
# #################
# #################
# #################

# # https://www.ebi.ac.uk/seqdb/confluence/display/JDSAT/Protein+Functional+Analysis

# #################
# #################
# #################

# #' @title EBI interface to UniProtKB
# #' @references [Protein API](https://www.ebi.ac.uk/proteins/api/doc/index.html)

# #' @title `.attach`
# #' @concept Add params to a url for interpolation
# #' @example \code{.attach("id" = "${id}", "Finde en Culiacán" = "Bien machín, perro.")}
# .attach <- function(slug="", ...) {
#   argv <- list(...)
#   argn <- names(argv)
#   argc <- which(!is.na(argn))

#   .slug <- slug
#   for (i in argc) {
#     segm <- setNames(
#       list(
#         paste(
#           argn[i], "=", argv[i], "&",
#           collapse = "",
#           sep = ""
#         )
#       ),
#       argn[i]
#     )
#     .slug <- append(.slug, segm)
#   }
#   .slug <- paste(.slug, collapse = "")
#   return(URLencode(.slug))
# }

# #' @title `.ebi.api.proteins`
# #' @example \code{ebi.api.proteins(accession = "P0DTC3", size = "-1")}
# .ebi.api <- function(..., endpoint = "proteins", method = httr::GET) {
#   argv <- list(...)
#   argn <- names(argv)
#   argc <- which(!is.na(argn))

#   slug <- paste0(
#     "https://www.ebi.ac.uk/proteins/api/",
#     as.character(endpoint), "?"
#   )

#   url <- paste0(slug, do.call(.attach, argv))

#   return(method(url))
# }

# #' @title `EBI.fetchAAString`
# #' @example \code{
# #' EBI.fetchAAString(accession = "P0DTC3")
# #' }
# #' @export
# EBI.fetchAAString <- function(...) {
#   res <- .ebi.api(...)
#   doc <- httr::content(res, as = "parsed")[[1]]
#   aastring <- Biostrings::AAString(as.character(doc[["sequence"]][["sequence"]]))
#   aastring@metadata <- append(aastring@metadata, list(id = doc$id))
#   return(aastring)
# }

# #' @title `EBI.fetchUniProtKB`
# #' @description
# #' https://github.com/ProteinsWebTeam/interpro7-api/tree/master/docs#5-how-do-i-retrieve-a-list-of-uniprotkb-reviewed-proteins-containing-the-entry-ipr002117-domain
# #' 5. How do I retrieve a list of UniProtKB reviewed proteins containing the entry IPR002117 domain?
# #' This query returns a list of proteins with IPR002117 domains together with the location of the domain in the protein sequence.
# #' `/api/protein/reviewed/entry/interpro/ipr002117`
# #' @example \code{
# #' EBI.fetchUniProtKB(InterPro = "")
# #' }
# EBI.fetchUniProtKB <- function(...) {
#   argv <- list(...)
#   argn <- tolower(names(argv))

#   result <- list()

#   if (any("interpro" == argn)) {

#     interpro <- c(argv[argn == "interpro"])

#     if (length(interpro) > 0) {

#       result <- append(
#         result,
#         list(
#           interpro = setNames(
#             lapply(
#               as.list(interpro),
#               function(ipr) {
#                 httr::GET(
#                   stringr::str_interp(
#                     "https://ebi.ac.uk/interpro/api/protein/reviewed/entry/interpro/${ipr}"
#                   )
#                 )
#               }
#             ),
#             as.character(interpro)
#           )
#         )
#       )

#     }

#     # result <- append(
#     #   result,
#     #   list(
#     #     interpro = httr::GET(
#     #       stringr::str_interp(
#     #         "https://ebi.ac.uk/interpro/api/protein/reviewed/entry/interpro/${interpro}",
#     #         list(interpro = interpro)
#     #       )
#     #     )
#     #   )
#     # )

#     return(result)

#   }

#   return(result)
# }

# # DEL
# EBI.fetchUniProtKB(interpro = "ipr002117")
# # END


# EBI.fetchProteome <- function(...) {
# # https://www.ebi.ac.uk/interpro/api/proteome
# }

# #' @title `EBI.listEndpoints`
# #' @description
# #' REST interface
# #' Queries to the API are formatted as URL queries. As a general principle a short query to the API will return general data and a specific query will return detailed data. The following example shows the most basic query that can be made, '/'.
# #'
# #' https://www.ebi.ac.uk/interpro/api/
# #'
# #' The JSON response from the API, amongst other attributes, includes a list of all supported "endpoints".
# #'
# #' The main endpoints
# #' The main data types (entry, protein, structure, set, proteome, taxonomy) are the most important of these endpoints because they determine the type of data which will be returned from a query. The URLs below request some general information about each of the main data types. The response is a list of source databases together with a count of how many entities of that type from that datasource are stored in InterPro.
# #'
# #' /api/entry
# #' /api/protein
# #' /api/structure
# #' /api/set
# #' /api/taxonomy
# #' /api/proteome
# #' @export
# EBI.listEndpoints <- function(...) {
#   # https://www.ebi.ac.uk/interpro/api/
# }

# .iprscan5 <- function(...) {}
# #' @title `EBI.InterProScan5`
# #' @references
# #' https://www.ebi.ac.uk/Tools/services/rest/iprscan5?wadl
# #' https://www.ebi.ac.uk/seqdb/confluence/display/JDSAT/InterProScan+5+Help+and+Documentation#InterProScan5HelpandDocumentation-RESTAPI
# EBI.InterProScan5 <- function(...) {

# }

# .pfamscan <- function(...) {}
# #' @references https://www.ebi.ac.uk/seqdb/confluence/display/JDSAT/PfamScan+Help+and+Documentation?src=contextnavpagetreemode
# EBI.PfamScan <- function(...) {

# }

# .seqret <- function(...) {}
# #' @references https://www.ebi.ac.uk/seqdb/confluence/display/JDSAT/Sequence+Format+Conversion
# EBI.Seqret <- function(...) {

# }


# EBI.resolver <- function() {
#   # https://resolver.api.identifiers.org
# }
