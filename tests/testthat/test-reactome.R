test_that("test-reactome", {
  `test-searchResults` <- NULL
  `test-toi` <- list(
    "inflammation" = list(species = "Homo sapiens"),
    "kawasaki" = list(species = "Homo sapiens")
  )

  expect({
    Reactome.searchToI(toi)
  }, "The searchToI method fails to handle a list of two ToIs.")

  TRUE
})
