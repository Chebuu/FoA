test_that("test-hello", {
  expect({
    suppressMessages({
       echo(1); TRUE
    })
  }, "The `echo` generic accepts a number.")

  expect({
    suppressMessages({
      echo(crayon::blue(1)); TRUE
    })
  }, "The `echo` generic accepts a `crayon::blue` number.")
})
