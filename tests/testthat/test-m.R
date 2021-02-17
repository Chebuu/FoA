test_that("test-M", {

  expect({
    inherits(Matrix(matrix(0), sparse = T), c("ddiMatrix", "Matrix")) & class(as.matrix(Matrix(matrix(T), sparse = T))) == "matrix"
  }, "The Matrix package works good enough.")

  expect({
    m <- M(matrix())
    mm <- as.matrix(m@m)
    inherits(m, c("M")) & all(is.na(mm))
  }, "Default initialization of `M` instance returns unexpected object.")
})
