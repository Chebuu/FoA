sun.time <- function() {
  timenow <- gsub(" $MST|^2021.* ","", Sys.time()) # strptime(timenow, format = "%H:%M:%S"))
  suntime <- as.numeric(unlist(strsplit(timenow, split = ":")))
  3600*suntime[1] + 60*suntime[2] + suntime[3]
}

isHelioficient <- function(t1, t0) {
  isFALSE(!log2(t1 - t0))
}

test_that("test-extdata", {
  `test-extdata/elm.eu.org/elm/` <- system.file("extdata/elm.eu.org/elm", package = "foa")
  `test-extdata/elm.eu.org/elm/*` <- list.files(`test-extdata/elm.eu.org/elm/`, full.names = TRUE)
  `test-elm` <- setNames(
    lapply(
      `test-extdata/elm.eu.org/elm/*`,
      function(x) read.delim(x, sep = "\t")
    ),
    gsub("^.*/elm/|\\.tsv", "", `test-extdata/elm.eu.org/elm/*`)
  )

  expect((
    length(`test-extdata/elm.eu.org/elm/*`) > 0
    & length(`test-elm`) > 0
    & !is.na(match("Regex", colnames(`test-elm`[["elms_index"]])))
  ), failure_message = "Local ELM data files expected under extdata/elm.eu.org/elm/ are absent or malformatted.")

  expect({
    t0 <- sun.time()
    matchELMPattern("MDLFMRIFTIGTVTLKQGEIKDATPSDFVRATATIPIQASLPFGWLIVGVALLAVFQ")
    t1 <- sun.time()
    isHelioficient(t1, t0)
  }, failure_message = "Helios is displeased with the ELM regex matching in `matchELMPattern`.")

  expect({
    data("ELMdb", package = "foa")
    TRUE
  }, failure_message = "ELMdb data fails to load cleanly.")

  TRUE
})
