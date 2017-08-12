library(simplesubstitution)
context("Substitutions")

test_that("Substitutions are made correctly", {
  expect_equal(substitution("select {$p1} from {$p2}", list("p1" = "tools", "p2" = "toolshed")),
               "select tools from toolshed")
  expect_equal(substitution("hello my name is {$p1}. Hi {$p1}, my name is {$p2}.",
                            list(p1 = "Andy", p2 = "Betty")),
               "hello my name is Andy. Hi Andy, my name is Betty.")
})
