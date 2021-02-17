#' @title ELM — the eukaryotic linear motif resource in 2020. (PMID:31680160)
#' @references
#' Kumar M, Gouw M, Michael S, Sámano-Sánchez H, Pancsa R, Glavina J, Diakogianni A, Valverde JA, Bukirova D, Čalyševa J, Palopoli N, Davey NE, Chemes LB, Gibson TJ. ELM-the eukaryotic linear motif resource in 2020. Nucleic Acids Res. 2020 Jan 8;48(D1):D296-D306. doi: 10.1093/nar/gkz1030. PMID: 31680160; PMCID: PMC7145657.
#' [http://elm.eu.org/downloads.html](http://elm.eu.org/downloads.html)
#' [#http://elm.eu.org/elms/CLV_NRD_NRD_1](#http://elm.eu.org/elms/CLV_NRD_NRD_1)

NULL

#' `ELM.matchPattern`
#' @concept Match ELM pattern to protein sequence
#' @param x A list of `Biostrings::AAString`s or an object coercible to `character`.`
#' @param pattern A `character` representing a single ELM regular expression to match against argument `x`.
#' @export
ELM.matchPattern <- function(x, pattern = "[RK].[AILMFV][LTKF].", acccession = NULL) {
  if (length(x) < 1) return(NULL)
  if (!any(grepl(pattern, x))) return(rep(NA_character_, times = length(x)))
  matches <- as.character(regmatches(x, regexec(pattern, x)))
  if (length(names(x)) == length(matches)) names(matches) <- names(x)
  return(matches)
}

.parseInstancesTSV <- function(tsvfile) {
  tmplines <- readLines(tsvfile)
  instances <- do.call(
    rbind,
    lapply(
      stringr::str_split(tmplines[-c(1:6)], "\\t"),
      function(row) {
        gsub('\\\"', "", row)
      }
    )
  )
  if (!is.null(instances)) {
    colheader <- stringr::str_split(gsub('\\\t"', "", tmplines[[6]]), '\\"')[[1]]
    colnames(instances) <- colheader[colheader != ""]
  }
  return(instances)
}

#' `ELM.fetch`
#' @concept Interface to the ELM ReST API via `httr` verbs
#' @references
#' [http://elm.eu.org/api/manual.html](http://elm.eu.org/api/manual.html)
#' [#http://elm.eu.org/elms/CLV_NRD_NRD_1](#http://elm.eu.org/elms/CLV_NRD_NRD_1)
ELM.fetch <- function() {
  warning("TODO:: ")
}

# #' @example \dontrun{EML.query(q = "P12931")}
# #' @export
# ELM.query <- function(..., db = "elms/instances.tsv") {
#   argv <- list(...)
#   argn <- names(argv)
#   paste0("http://elm.eu.org/", db, "?", paste(argn, argv, sep = "=", collapse = "&"), sep = "")

# }

# #' @example \code{ELM.fetchInstances("P12931")}
# #' @export
# ELM.fetchInstances <- function(q) {
#   url <- paste0("http://elm.eu.org/instances.tsv?q=", q, sep = "")
#   tmp <- tempfile(fileext = ".tsv")
#   download.file(url, destfile = tmp)
#   instances <- .parseInstancesTSV(tmp)
#   return(instances)
# }

# # # http://elm.eu.org/downloads.html
# # # http://phospho.elm.eu.org/dataset.html
# # .fetchlib <- function(
# #   db = "elms",
# #   lib = "elms_index.tsv",
# #   slug = "http://elm.eu.org/${db}/${lib}"
# # ) {
# #   url <- stringr::str_interp(slug, list(db = db, lib = lib))
# #   destfile <- paste0(system.file("extdata/elm/", package = "FoA"), lib)
# #   list.files(destfile)
# #   download.file(url, destfile = destfile)
# #   return(destfile)
# # }
# #
# # .parselib <- function(...) {
# #   object <- as.list(...)
# #   if (all(is.null(c(object[["file"]], object[["dir"]])))) {
# #     libs <- list.files(system.file("extdata/elm/"), full.names = TRUE)
# #     if (!is.null(object[["lib"]])) {
# #       elms <- unlist(libs[libs == object[["lib"]]])
# #     }
# #     # # TODO::
# #     # load all the regexs into a list
# #   }
# # }
# #
# # .elmexec <- function(pattern, text) {
# #   .parselib(dir = system.file("extdata/elm", package = "FoA"))
# # }
# #
# #
# # .libexec <- function(text, elmlib = "elms_index.tsv") {
# #   elmfile <- system.file(paste0("extddata/elm/", elmlib, sep = ""), package = "FoA")
# #   print(elmfile)
# #   if (elmfile == "") {
# #     elmlib <- .fetchlib(db = "elms", lib = elmlib)
# #   }
# #   elm <- read.delim(elmfile, header = TRUE)
# #   colnames(elm)
# # }



# # # Downloads
# # http://elm.eu.org/downloads.html
# #
# # ## Classes
# # ### All
# # elms/elms_index.tsv
# # elms/elms_index.html
# # ### By query term
# # /elms/elms_index.tsv?q=PCSK
# # ### By ELM ID
# # html	/ELME000012.html
# #
# # ## Instances
# # ### all
# # html/elms/instances.html?q=*
# # ### By Instance (id)
# # /ELMI000123.html ==> html
# # ### By Uniprot (name)
# # instances.gff?q=SRC_HUMAN ==> gff
# # ### By Uniprot (acc)
# # instances.fasta?q=P12931 ==> fasta
# # instances.tsv?q=P12931 ==> tsv
# # ### By query (term)
# # instances.pir?q=PCSK ==> pir
# # instances.tsv?q=src ==> tsv
# # instances.mitab?q=src ==> mitab
# # instances.psimi?q=src ==> xml
# # ### By query using additional parameter "instance logic"
# # instances.tsv?q=src&instance_logic=true+positive ==> tsv
# # ### All docking motifs annotated in taxon "mouse"
# # instances.tsv?q=DOC_&taxon=mus+musculus ==> tsv
# #
# # ## Interactions
# # ### All interactions
# # /interactions/as_tsv ==> tsv
# # /interactions/as_mitab ==> mitab
# # /interactions/as_psimi ==> psimi
# # # All interactions from certain taxon
# # /interactions/as_mitab?taxon=mus%20musculus ==> mitab
# # ## By Interaction id
# # /interactions/ELMINT000120.mitab
# # /interactions/ELMINT000120.xml
# # ## By Uniprot acc
# # /interactions/P33379.mitab
# # ## By Uniprot acc
# # /interactions/P02751.xml
# #
# # ## Interaction Domains
# # ### all interaction domains
# # /infos/browse_elm_interactiondomains.html
# # /infos/browse_elm_interactiondomains.tsv
# #
# # ## Methods
# # ## PDBs
# # ## GO Terms
# # ## Pathways
# # ## [...]

# ####################
# # Use the HTTP API #
# # #    ABOVE    # #
# ####################

# ELM.SCHEMA.Instance <- data.frame(
#   Acc = NA,
#   Start = NA,
#   End = NA,
#   Gene = NA,
#   Org = NA,
#   Name = NA,
#   Logic = NA,
#   N = NA
# )

# ELM.SCHEMA.Accession <- list(
#   # http://elm.eu.org/elms
#   Accession = NA,
#   Motif = data.frame(
#     Pattern = NA,
#     ProbPattern = NA,
#     Fxn.Class = NA,
#     Fxn.Descr = NA,
#     ELM.Class = NA,
#     ELM.DESCR = NA
#   ),
#   Instances = list()
# )

# # `.asXMLDocuaament`
# #' @title Fetch and parse XML documents
# #' @param html
# #' Either a remote URL ("character"), a local URL ("character"), a local
# #' file path ("character"), xml2 document ("xml_document"), or xml2 node
# #' ("xml_node").
# #' @param grepl.pattern
# #' A regex that, if found in argument `html`, will cause the function to
# #' treat `html` as a local file path. The default is set to treat all
# #' files starting with "
# #' @concept
# #' Coerce argument `html` to `assert_that(inherits(html, "xml_document"))`.
# #' @about
# #' This function is a wrapper for `xml2::read_html()` +
# #' `xml2::download_html()`. It guesses the meaning of `html` from class
# #' attributes to locate and parse an HTML document as an "xml_document"
# #' object.
# #' @details
# #' Retrieves an "xml_document" formatted-object when passed a local or
# #' remote URI pointing to either an ".xml" or ".html" file, Character
# #' arguments are assumed to be URIs; an existing local file has priority
# #' over a remote URL. Any file name matching the regex pattern in
# #' `grepl.pattern`. has class attribute "xml_document" or "xml_node",
# #' indicating that argument `html` can be coerced directly to an
# #' "xml_document" without further manipulation.
# #' @export
# .asXMLDocument <- function(html, grepl.pattern="^.*\\.py\\?") {
#   if (class(html) == "character")
#     if (file.exists(html) | grepl(grepl.pattern, html))
#       html <- xml2::read_html(html)
#     else
#       html <- xml2::read_html(xml2::download_html(html))
#     if (!inherits(html, c("xml_document", "xml_node")))
#       stop("assert_that({ file.exists(html) | inherits(html, c('xml_document','xml_node')) })")
#     xml2::as_xml_document(html)
# }

# ELM.parseResultsHTML <-
#   ELM.parseCGIModelHTML <-
#   function(html, id=NULL, xpath="/html/body/table[3]") {

#     doc <- NULL

#     if (inherits(html, c("xml_document", "xml_node"))) {
#       doc <- html
#     }
#     if (class(html) == "character") {
#       if (file.exists(html) | grepl("^.*\\.py\\?", html)) {
#         doc <- xml2::read_html(html)
#       } else{
#         doc <- xml2::read_html(
#           xml2::download_html(html)
#         )
#       }
#     } else {
#       stop(
#         "
#       assert(
#         file.exists(html) | inherits(html, c('xml_document','xml_node'))
#       )
#       "
#       )
#     }

#     xml2::xml_find_all(doc, xpath = xpath)
#   }

# #' @note http://elm.eu.org/elms
# #' @export
# ELM.fetchID <- function(query) {}

# #' #' @param elmid
# #' #' @concept Extract all the HTML data for a single ELM identifier.
# #' #' @value A list representing a single ELM ID, where each item is a data.frame  a table on the HTML page or the combination of several fields
# #' #' @note http://elm.eu.org/elms/CLV_C14_Caspase3-7.html
# #' #' @export
# ELM.fetchMotif <-
#   ELM.fetchInstance <- function(elmid) {}

# ELM.matchAll <- function(sequence, pattern) {
#   if (!grepl()) {}
# }

#' #' #' @concept Map all patterns over a given sequence and fetch ELM instances for each.
#' #' #' @export
#' ELM.mapSeq <-
#'   ELM.mapSequence <-
#'   ELM.mapAAString <- function(sequence, patterns, features) {
#'     lapply(patterns, function(p) {
#'       ELM.matchAll(x, p)
#'     })
#'   }

# #' #' @concept Map over patterns for each sequence and fetch ELM data.
# #' #' @description Get ELM SLiM annotations for all `pattern` matches in every `sequence`.
# #' #' @export
# #' ELM.map <- function(sequences, patterns, features) {
# #'   # dset <- list()
# #'   # seqs <- as.list(sequences)
# #'   # pats <- as.list(patterns)
# #'   # for s in seqs:
# #'   #   for p in pats:
# #'   #     if isMatch(s, p):
# #'   #        fetchData(s, p)
# #'   # data.frame(dset)
# #' }
