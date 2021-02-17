test_that("test-ncbi", {
  `test-eSearch` <- NCBI.eSearch()

  expect(
    length(names(`test-eSearch`)) > 0,
    failure_message = "NCBI eSearch utility fails to fetch and extract text from XML-encoded results of a query for human mRNA."
  )


  expect(
    inherits(`test-eSearch`$IdList, c("matrix")),
    failure_message = "NCBI eSearch utility returns some object other than a matrix."
  )

  TRUE
})

