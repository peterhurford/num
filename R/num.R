abbreviations <- function() {
  list(
    "K" = 1000,           # thousand
    "M" = 1000000,        # million
    "B" = 1000000000,     # billion
    "T" = 1000000000000   # trillion
  )
}


#' Convert a string expression into a number.
#'
#' @param num character. The string expression to convert.
#' @export
num <- checkr::ensure(
  pre = num %is% simple_string,
  post = result %is% numeric,
  function(num) {
    abbrev <- abbreviations()
    for (i in seq_along(abbrev)) {
      if (grepl(names(abbrev)[[i]], num)) {
        num <- gsub(names(abbrev)[[i]], paste("*", abbrev[[i]]), num)
      }
    }
    tryCatch({
      eval(parse(text = gsub(",", "", num)))
    }, error = function(e) {
      stop("Could not parse.")
    })
  })
