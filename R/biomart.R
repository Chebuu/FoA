#' `Proteomics workflow`
#' https://bioconductor.org/about/removed-packages/#___ProteomicsWorkflow
#' https://bioconductor.org/packages/release/bioc/html/ChIPpeakAnno.html

# # https://www.tidyverse.org/blog/2019/12/hardhat-0-1-0/

# #' @concept Simple `biomaRt` wrapper to return a list of dataframes.
# #' @export
fetchGeneFeatures <- function(entrez, features, mart) {
  setNames(
    lapply(
      features, 
      function(attrname) {
        message(attrname)
        tryCatch(
          biomaRt::getBM(
            values = list(
              "entrezgene_id" = as.character(entrez)
            ),
            attributes = c("entrezgene_id", as.character(attrname)), 
            filters = "entrezgene_id",
            mart = mart,
            useCache = FALSE
          ),
          error = function(e) {
            message(e)
            errval <- data.frame(entrezgene_id = as.character(entrez))
            errval[[attrname]] <- rep(NA_character_, length(entrez))
            return(errval)
          }
        )
      }
    ),
    features
  )
}