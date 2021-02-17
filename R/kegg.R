
# # https://a-little-book-of-r-for-bioinformatics.readthedocs.io/en/latest/src/chapter11.html
#'https://bioconductor.org/packages/devel/data/experiment/html/KEGGdzPathwaysGEO.html
#
#   # https://yulab-smu.top/biomedical-knowledge-mining-book/clusterprofiler-kegg.html#clusterprofiler-kegg-module-ora
#   mkk <- enrichMKEGG(gene = gene,
#                      organism = 'hsa',
#                      pvalueCutoff = 1,
#                      qvalueCutoff = 1)
#   head(mkk)
# }
#
# # https://www.kegg.jp/kegg/rest/keggapi.html
# # https://www.kegg.jp/kegg/docs/dbentry.html
# # https://www.kegg.jp/kegg/docs/weblink.html



#' .encodeHighlightURL <- function(pathway, genes, bg.color, fg.color, text.color) {
#' 	#' @example \code{ KEGG.encodeHighlightURL("map05171", list("hsa:6868"), "white", "blue", "yellow") }
#' 	paste(
#' 		paste0("http://www.kegg.jp/kegg-bin/show_pathway?", pathway),
#' 		paste(
#' 			sapply(
#' 				KEGGREST::keggLink("ko", genes),
#' 				function(g) {
#' 					paste(c(g), collapse="")
#' 				}
#' 			),
#' 			collapse ="/"
#' 		),
#' 		sep="/"
#' 	)
#' }
#'
#' .writeKEGGMapToPNG <- function(dbentry, target=NULL) {
#' 	png::writePNG(
#' 		image=keggGet(
#' 			dbentries=dbentry,
#' 			option="image"
#' 		),
#' 		target=ifelse(
#' 			is.null(target),
#' 			paste0(dbentry, ".png"),
#' 			target
#' 		)
#' 	)
#' }
