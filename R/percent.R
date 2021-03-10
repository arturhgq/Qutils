#' @title Extrai a porcentagem de um valor
#'
#' @description `r lifecycle::badge("stable")`
#'
#' Esta função extrai a porcentagem de um valor
#'
#' @param .x valor
#' @param .total 100 por default
#' @param .decrease To decrease by 100
#'
#' @export

percent <- function(.x, .total, .decrease) {
  if (missing(.decrease)) .x/.total* 100
  else 100 - (.x/ .total* 100)
}
