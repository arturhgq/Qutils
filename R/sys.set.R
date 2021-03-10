#' @title Define a localidade dos processos em R
#'
#' @description `r lifecycle::badge("deprecated")`
#'
#' Esta função definie a localidade dos processos em R
#'
#' @export
#'
Sys.set <- function() {
  Sys.setlocale("LC_ALL","English")
  Sys.setenv(LANG = "en_US.UTF-8")
}
