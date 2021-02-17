# # setClass(
# # 	Class = "GeneList",
# # 	slots = c(
# # 		Meta = "list",
# # 		Data = "list"
# # 	)
# # )
# #
# # setClass(
# # 	Class = "GeneSet",
# # 	slots = c("Genes", "Background")
# # )
#
#
# # TODO::
# ## Factor in each subset should be recoded to reflect their current levels
# ## ## I guess just map over each column with dplyr::recode(M, .default=levels(M))
#
# subsetGenes <- function(dataset=GENES, organism=2697049) {
# 	GENES %>%
# 		filter(ORGANISM.ID == organism) %>%
# 		distinct(ENTREZ.GENE.ID, .keep_all=TRUE)
# }
#
# # CoV2Genes <- subsetGenes()
#
# subsetInteractors <- function(
# 	dataset=INTERACTIONS,
# 	Entrez.A=43740569, # ORF3a
# 	Organism.A=2697049, # SARS-CoV-2
# 	Organism.B=9606, # Homo sapiens
# 	Exp.System="Affinity Capture-MS"
# ) {
# 	dataset %>%
# 		filter(
# 			Experimental.System %in% c(Exp.System)
# 			& Organism.ID.Interactor.A %in% c(Organism.A)
# 			& Organism.ID.Interactor.B %in% c(Organism.B)
# 			& Entrez.Gene.Interactor.A %in% c(Entrez.A)
# 		)
# }
#
# # InteractionsForCoV2GeneORF3a <- subsetInteractors()
#
# groupInteractionsByGene <-
# 	groupInteractionsByEntrezA <-
# 	function(
# 		Organism.A=2697049, Organism.B=9606,
# 		Exp.System="Affinity Capture-MS",
# 		Interactions=INTERACTIONS, Genes=GENES
# 	) {
# 		GroupLabels <- list()
# 		GroupedInteractions <- Genes %>%
# 			subsetGenes(Organism.A) %>%
# 			apply(1, function(gene) {
# 				entrezid <- gene["ENTREZ.GENE.ID"]
# 				genename <- gene["OFFICIAL.SYMBOL"]
# 				interactors <- Interactions %>%
# 					subsetInteractors(entrezid, Organism.A, Organism.B, Exp.System)
# 				attr(interactors, "ORGANISM.ID") <- Organism.A
# 				attr(interactors, "ENTREZ.GENE.ID") <- entrezid
# 				attr(interactors, "OFFICIAL.SYMBOL") <- genename
# 				attr(interactors, "Experimental.System") <- Exp.System
# 				attr(interactors, "Organism.B") <- Organism.B
# 				GroupLabels <<- append(GroupLabels, genename)
# 				as_tibble(interactors)
# 			}
# 			)
# 		setNames(GroupedInteractions, GroupLabels)
# 	}
#
# # InteractionsByCoV2Gene <- groupInteractionsByGene()
#
# groupInteractionsByVirus <-
# 	groupInteractionsByOrganismA <-
# 	function(
# 		Organism.B=9606, Exp.System="AffinityCapture-MS",
# 		Genes=GENES, Interactions=INTERACTIONS
# 	) {
# 		VirusIDs <- Genes %>%
# 			distinct(ORGANISM.ID)
# 		VirusNames <- Genes %>%
# 			left_join(VirusIDs) %>%
# 			distinct(ORGANISM.NAME)
# 		GroupedDatasets <- apply(VirusIDs, 1, function(virusid) {
# 			GroupedInteractions <- groupInteractionsByGene(
# 				virusid, Organism.B, Exp.System, Interactions, Genes
# 			)
# 		})
# 		setNames(GroupedDatasets, unlist(VirusNames))
# 	}
#
# InteractionsByVirus <- groupInteractionsByVirus() {}
