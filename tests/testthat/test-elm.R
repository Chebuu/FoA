test_that("test-elm", {
  TRUE
})

test_that("fiddle-elm". {
  # ######
  # # DEL
  # ######
  # P0DTC.elms.LOCAL_CACHE <- paste0(getwd(), "/elms_indext-q=P0DTC3.tsv")
  #
  # if (!file.exists(P0DTC.elms.LOCAL_CACHE)) {
  #   download.file(
  #     "http://elm.eu.org/elms/elms_index.tsv%30q=P0DTC3%26taxon=homo+sapiens",
  #     destfile = "./elms_indext-q=P0DTC3.tsv"
  #   )
  # }
  #
  # P0DTC3.elms <- read.delim(
  #   paste0(getwd(), "/elms_indext-q=P0DTC3.tsv"),
  #   comment.char = "#"
  # )
  #
  # print(
  #   sprintf(
  #     "Human ELM IDs for SWISS-PROT P0DTC3 (N=%s): ",
  #     nrow(bind_rows(P0DTC3.elms))
  #   )
  # )
  #
  # P0DTC3.elms %>%
  #   dplyr::select(
  #     Accession, ELMIdentifier, FunctionalSiteName, Probability, X.Instances
  #   ) %>%
  #   head(20)
  # ######
  # # END
  # ######

  TRUE
})
