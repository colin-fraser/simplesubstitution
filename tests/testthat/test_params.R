library(simplesubstitution)
context("Parameters")

test1 <- "SELECT {$column} FROM {$table}"

test_that("parameters are detected", {
  expect_equal(list_parameters(test1), c("column", "table"))
  expect_equal(list_parameters("{$column} {$column} {$table}"), c("column", "table"))
  expect_equal(list_parameters(test1, pattern = "sfds"), character(0))
})
