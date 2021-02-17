test_that("test-cdd", {
  expect_false(
    any(is.na(CDD.fetchDescription("cd00200")))
  )
})
