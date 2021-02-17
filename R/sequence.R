# biomaRt::exportFASTA()
# biomaRt::getSequence()
# biomaRt::getGene()
# biomaRt::getLDS()

# `proteomics`
# https://bioconductor.org/packages/release/workflows/html/proteomics.html

# seqmagick
# https://cran.r-project.org/web/packages/seqmagick/index.html

# `MSstats`
# https://www.bioconductor.org/packages/3.1/bioc/vignettes/MSstats/inst/doc/MSstats.pdf
# `kebabs`
# https://bioconductor.org/packages/devel/bioc/html/kebabs.html
#
# `Position weight matrix (PWM)`
# https://en.wikipedia.org/wiki/Position_weight_matrix
# https://bioconductor.org/packages/release/bioc/html/Logolas.html
# https://bioconductor.org/packages/release/bioc/html/MatrixRider.html

# `Alignment`
# https://github.com/wangshisheng/motifeR
# https://github.com/omarwagih/rmotifx/
# https://bioconductor.org/packages/release/bioc/html/muscle.html
# https://bioconductor.org/packages/release/bioc/html/seqPattern.html
# https://www.bioconductor.org/packages/release/bioc/html/seqcombo.html'

# `K-mers`
# https://bioconductor.org/packages/release/bioc/html/periodicDNA.html
# Package `ensembldb`
# https://bioconductor.org/packages/release/bioc/vignettes/ensembldb/inst/doc/coordinate-mapping.html


# https://bioconductor.org/packages/release/bioc/html/ensembldb.html

Ensembl.fetchGenes.protein_domain_id <- function(id = c(), .EnsDb = NULL) {
  genes(.EnsDb, filter = ~ protein_domain_id %in% c(id))
}

Ensembl.fetchProteinCoordinates.protein_domain_id <- function(id, .EnsDb = NULL) {
  pgenes <- Ensembl.fetchGenes.protein_domain_id(id, .EnsDb)
  genes(.EnsDb, filter = ~ entrezid %in% c(id))
  # ensembldb::genomeToProtein(EnsDb.Hsapiens.v86, ...)
}

Ensemble.proteins <- function(entrezid, edb) {
  results <- proteins(edb, filter = EntrezFilter(c(entrezid)))
  do.call(rbind, as.list(results@listData))
}

Ensembl.proteinDomains <- function(entrezid, .EnsDb) {
  seqlevelsStyle(.EnsDb) <- "UCSC"

  pdoms <- na.omit(
    proteins(
      .EnsDb,
      filter =  EntrezFilter(c("7030")),
      columns = c(
        "protein_domain_id",
        "prot_dom_start",
        "prot_dom_end"
      )
    )
  )

  IRanges(
    start = pdoms$prot_dom_start,
    end = pdoms$prot_dom_end,
    names = pdoms$protein_domain_id
  )
}

Ensembl.getProteinIRanges <- function(entrezid, iranges = c()) {
  Ensemble.proteins(entrezid)[["protein_sequence"]]
}

Ensemble.proteinMotifMatrix <- function(entrezid, motifs = c()) {
  lapply(
    Ensemble.proteins(entrezid)[["protein_sequence"]],
    function(aaseq) {
      kebabs::getExRep(AAString(aaseq), kebabs::motifKernel(motifs))
    }
  )

}

Ensemble.proteinMotifRanges <- function(entrezid, motifs = c()) {
  lapply(motifs, function(motif) {
    stringr::str_locate_all(
      as.character(
        as.data.frame(
          Ensembl.proteins(entrezid, edb)
        )[,3]
      )[1],
      motif
    )
  })
}

