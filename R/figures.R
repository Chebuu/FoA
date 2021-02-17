#' `proteomics`
#' https://bioconductor.org/packages/release/workflows/html/proteomics.html

#' `Venn diagram`
#' https://cran.rstudio.com/web/packages/VennDiagram/index.html
#' `DiffLogo: A comparative visualisation of biooligomer motifs`
# http://geneinfinity.org/sp/sp_seqlogos.html
# https://bioconductor.org/packages/release/bioc/html/DiffLogo.html
# https://bioconductor.org/packages/release/bioc/html/Logolas.html
# https://bioconductor.org/packages/release/bioc/html/seqLogo.html
# https://bioconductor.org/packages/release/bioc/html/dagLogo.html
# https://bioconductor.org/packages/release/bioc/html/motifStack.html
# https://bioconductor.org/packages/release/bioc/html/DominoEffect.html
#' `Dot bracket annotations`
#' https://bioconductor.org/packages/release/bioc/html/Structstrings.html


# # https://www.r-graph-gallery.com/base-R.html

# ### Motif enrichment
# ## https://bioconductor.org/packages/devel/bioc/vignettes/universalmotif/inst/doc/IntroductionToSequenceMotifs.pdf
# # https://bioconductor.org/packages/devel/bioc/vignettes/ELMER/inst/doc/plots_motif_enrichment.html
# # https://bioconductor.org/packages/release/bioc/vignettes/transite/inst/doc/spma.html
# # https://bioconductor.org/packages/release/bioc/html/MotifDb.html

# ## Regulex regex display
# # https://jex.im/regulex/#!flags=&re=(.RK)%7C(RR%5B%5EKR%5D)


# ## Reactome 3D/2D visualizations
# https://bioconductor.org/packages/release/bioc/html/transomics2cytoscape.html
# https://bioconductor.org/packages/release/bioc/html/RCy3.html

# ### CDD CDTree domain viewer
# ## https://www.ncbi.nlm.nih.gov/Structure/cdtree/cdtree.shtml
# https://bioconductor.org/packages/release/bioc/html/ggtree.html

# ### Heatmaps
# https://bioconductor.org/packages/release/bioc/html/heatmaps.html
# https://cran.rstudio.com/web/packages/pheatmap/index.html

# Trees
# https://bioconductor.org/packages/release/bioc/html/ggtree.html

# # https://a-little-book-of-r-for-bioinformatics.readthedocs.io/en/latest/src/chapter11.html
# # https://yulab-smu.top/biomedical-knowledge-mining-book/enrichplot.html#pubmed-trend-of-enriched-terms


# ### Sequence plots
# ## https://cran.rstudio.com/web/packages/ggseqlogo/index.html
# https://bioconductor.org/packages/release/bioc/html/seqPattern.html
# ## https://www.bioconductor.org/packages/release/bioc/vignettes/trackViewer/inst/doc/trackViewer.html

# ### Plots 'n such
# ## https://www.tidyverse.org/blog/2020/03/ggplot2-3-3-0/
# # https://www.tidyverse.org/blog/2020/08/taking-control-of-plot-scaling/
# # https://rviews.rstudio.com/2019/09/19/intro-to-ggforce/
# # https://rviews.rstudio.com/2020/12/14/plotting-surfaces-with-r/
# # https://rviews.rstudio.com/2018/07/18/monte-carlo-shiny-part-3/
# # https://www.tidyverse.org/blog/2018/07/ggplot2-tidy-evaluation/
# # https://s4be.cochrane.org/blog/2016/07/11/tutorial-read-forest-plot/
# # https://rviews.rstudio.com/2016/10/19/creating-interactive-plots-with-r-and-highcharts/
# # https://rviews.rstudio.com/2021/01/15/wonderful-wednesdays-forest-plot/
# # https://rviews.rstudio.com/2020/12/14/plotting-surfaces-with-r/
# # https://rviews.rstudio.com/2017/05/03/shiny-in-medicine/

# # https://bioconductor.org/packages/devel/bioc/html/pathRender.html

# # https://www.bioconductor.org/packages/release/bioc/html/Rgraphviz.html
# # https://warwick.ac.uk/fac/sci/moac/people/students/peter_cock/r/rgraphviz/

# # https://bioconductor.org/packages/devel/data/experiment/html/RforProteomics.html
# # https://bioconductor.org/packages/devel/data/experiment/vignettes/RforProteomics/inst/doc/RProtVis.html
# # https://bioconductor.org/packages/devel/data/experiment/vignettes/RforProteomics/inst/doc/RforProteomics.html

# # https://www.tidyverse.org/blog/2020/03/forcats-0-5-0/
# # https://www.tidyverse.org/blog/2018/04/pillar-1-2-2/
# # https://www.tidyverse.org/blog/2020/07/broom-0-7-0/
# # https://www.tidyverse.org/blog/2017/08/purrr-0.2.3/
# # https://www.tidyverse.org/blog/2017/10/glue-1.2.0/
# # https://www.tidyverse.org/blog/2018/01/fs-1.0.0/

# renderGeneAnswersConceptNet <- function() {
# 	# library(InterMineR)
# 	# library(GeneAnswers)
# 	# IMR.Human <- initInterMine(listMines()["HumanMine"])
# 	#
# 	# Widgets.Human <- getWidgets(IMR.Human) %>% as.data.frame
# 	#
# 	# Widgets.Human.Gene <-Widgets.Human %>%
# 	# 	subset(targets == "Gene")
# 	# Widgets.Human.Protein <- Widgets.Human %>%
# 	# 	subset(targets == 'Protein')
# 	#
# 	# Widgets.Human.Gene.Enrichment <- Widgets.Human.Gene %>%
# 	# 	subset(widgetType == "enrichment")
# 	# Widgets.Human.Protein.Enrichment <- Widgets.Human.Protein %>%
# 	# 	subset(widgetType == "enrichment")
# 	#
# 	# # [...]
# 	#
# 	# CoV2.ORF3a.Human.AffinityCaptureMS.Gene.Enrichment.PT = doEnrichment(
# 	# 	im = IMR.Human,
# 	# 	ids = CoV2.ORF3a,
# 	# 	organism = "Homo sapiens",
# 	# 	widget = "pathway_enrichment",
# 	# 	# correction = "Benjamini Hochberg"
# 	# ) %>%
# 	# 	convertToGeneAnswers(
# 	# 		CoV2.ORF3a.Human.AffinityCaptureMS.Gene.Enrichment.PT,
# 	# 		geneInput = data.frame(
# 	# 			GeneID = CoV2.ORF3a,
# 	# 			stringsAsFactors = FALSE
# 	# 		),
# 	# 		geneInputType = "Gene.primaryIdentifier",
# 	# 		annLib = 'org.Hs.eg.db',
# 	# 		categoryType = "REACTOME"
# 	# 	) # %>% geneAnswersReadable()
# 	#
# 	# geneAnswersConceptNet(
# 	# 	colorValueColumn=NULL,
# 	# 	centroidSize='correctedPvalue',
# 	# 	output='fixed',
# 	# 	geneSymbol=TRUE,
# 	# 	catTerm = TRUE,
# 	# 	catID = TRUE
# 	# )


# }
