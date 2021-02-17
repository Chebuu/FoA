# # https://intermine.readthedocs.io/en/latest/web-services/
# # https://www.humanmine.org/humanmine/begin.do
# # https://bioconductor.org/packages/release/bioc/html/InterMineR.html
# # https://www.humanmine.org/humanmine/template.do?name=geneInteractiongene&scope=all
# # https://www.humanmine.org/humanmine/service/template/results?name=geneInteractiongene&constraint1=Gene&op1=LOOKUP&value1=ABCC8&extra1=H.+sapiens&constraint2=Gene.interactions.participant2&op2=LOOKUP&value2=RAPGEF4&extra2=H.+sapiens&format=tab&size=10
#
#
# IMR.Human <- initInterMine(listMines()["HumanMine"])
#
# Widgets.Human <- getWidgets(IMR.Human) %>% as.data.frame
#
# Widgets.Human.Gene <-Widgets.Human %>%
#   subset(targets == "Gene")
# Widgets.Human.Protein <- Widgets.Human %>%
#   subset(targets == 'Protein')
#
# Widgets.Human.Gene.Enrichment <- Widgets.Human.Gene %>%
#   subset(widgetType == "enrichment")
# Widgets.Human.Protein.Enrichment <- Widgets.Human.Protein %>%
#   subset(widgetType == "enrichment")
