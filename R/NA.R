#'  @title Check if a value is not NA
#'
#'  @description `r lifecycle::badge("experimental")`
#'
#'  This function check if a value is not a missing value (NA)
#' @export
#'
not.na <- function(...) !is.na(...)
