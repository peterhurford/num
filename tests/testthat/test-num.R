context("num")
library(testthat)
library(magrittr)
#library(funtools)
library(checkr)

#TODO: Finish when funtools is ready.
# comma_split_num <- ensure(
#   pre = x %is% numeric,
#   post = result %is% character,
#   function(x) {
#     withr::with_options(c("scipen" = 100, "digits" = 20), {
#       x %>% lsplit %>% rev %>% chunk(., 3) %/>% collapse %>%
#         join(",") %>% lsplit %>% rev %>% join
#     })
#   })

abbrev <- abbreviations()
quickcheck_nums <- checkr::function_test_objects(pre = list(x %is% numeric, length(x) == 1))
random_nums <- round(runif(100, 1, 100000000), 0)
test_nums <- c(quickcheck_nums, random_nums)

# describe("comma separation is parsable", {
#   expect_true(all(sapply(test_nums, is.numeric)))
#   # Turns a bunch of numbers like 40000 into "40,000"
#   comma_test_nums <- lapply(test_nums, comma_split_num)
#   for (i in seq_along(test_nums)) {
#     test_that(paste(comma_test_nums[[i]], "is converted to", test_nums[[i]]),
#       expect_equal(num(comma_test_nums[[i]]), test_nums[[i]]))
#   }
# })

describe("letter interpolation is parsable", {
  for (i in seq_along(abbrev)) {
    describe(names(abbrev)[[i]], {
      # Generates a bunch of stuff like 1000M, 100K, etc.
      letter_nums <- unlist(test_nums) %>% paste0(names(abbrev)[[i]])
      test_nums <- (unlist(test_nums) * abbrev[[i]]) %>% unname
      for (j in seq_along(test_nums)) {
        test_that(paste(letter_nums[[j]], "is converted to", test_nums[[j]]),
          expect_equal(num(letter_nums[[j]]), test_nums[[j]]))
      }
    })
  }
})

test_that("multiple letter interpolation is not parsable", {
  expect_error(num::num("40M2K"))
  expect_error(num::num("40M20K"))
})

describe("decimal separation is parsable with letters", {
  random_nums <- round(runif(100, 1, 100000), 3)
  for (i in seq_along(abbrev)) {
    letter_nums <- random_nums %>% paste0(names(abbrev)[[i]])
    test_nums <- unname(unlist(random_nums) * abbrev[[i]])
    for (j in seq_along(test_nums)) {
      test_that(paste(letter_nums[[j]], "is converted to", test_nums[[j]]),
        expect_equal(num(letter_nums[[j]]), test_nums[[j]]))
    }
  }
})
