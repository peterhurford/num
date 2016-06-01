is_comma_sep_num_rex <- rex::rex(start,
  one_or_more(group(one_or_more(numbers), ",", one_or_more(numbers))), end)
is_comma_sep_num <- function(str) {
  grepl(is_comma_sep_num_rex, str)
}

abbreviations <- function() {
  list(
    "K" = ",000",              # thousand
    "M" = ",000,000",          # million
    "B" = ",000,000,000",      # billion
    "T" = ",000,000,000,000"   # trillion
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
        num <- gsub(names(abbrev)[[i]], abbrev[[i]], num)
      }
    }
    if (is_comma_sep_num(num)) {
      as.numeric(gsub(",", "", num))
    } else {
      stop("Could not parse.")
    }
  })
