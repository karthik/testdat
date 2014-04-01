context("UTF8")

# Sample data objects
data(iris)
utf8df <- structure(
  list(
    x = 'The\U3e32393cs quick brown fox jumps over the \U3e32393cs the lazy dog',
    y = 'Lorem\U3e32393cs ipsum \U3e32393cs dolor',
    dat = 43.5
  ),
  .Names = c('x', 'y', 'dat'), row.names = c(NA, -1L), class = 'data.frame'
)


test_that("test_utf8 errors on non-data frames", {
  expect_error(test_utf8(1:8))
  expect_error(test_utf8(list(1,2,3)))
})


test_that("test_utf8 correctly detects UTF-8", {
  expect_false(test_utf8(iris))
  expect_true(test_utf8(utf8df))

  # This CSV file is UTF-8
  data <- read.csv("data/km1314-waypoints.csv")
  expect_true(test_utf8(data))

  # Testing latin1 encoded strings
  txt <- "fa\xE7ile"
  Encoding(txt) <- "latin1"
  df <- data.frame(txt)
  expect_false(test_utf8(df))
  # FIXME: test_utf8 returns TRUE for non-UTF-8 encoded strings.
  # Maybe it should be called test_nonascii?
})


test_that("sanitize_text cleans weird chars", {
  expect_identical(
    sanitize_text("This is some bad text \U3e32393cs that contains utf-8 characters"),
    "This is some bad text s that contains utf-8 characters"
  )
})


test_that("sanitize_text only works on character vectors", {
  expect_error(sanitize_text(iris))
  expect_error(sanitize_text(1:10))
})
