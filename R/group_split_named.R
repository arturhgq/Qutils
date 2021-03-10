#' @title Cria uma lista nomeada de bancos de dados agrupados por uma ou mais variáveis
#'
#' @description `r lifecycle::badge("experimental")`
#'
#' Esta função cria uma lista nomeada de bancos de dados agrupados por uma ou mais variáveis
#'
#' @param .data Banco de dados
#' @param ... variáveis para agrupamento
#'
#' @export
group_split_named <- function(.data, ...) {

  .data %>%
    dplyr::group_by(...) %>%
    dplyr::group_keys(...) %>%
    dplyr::pull(...) %>%
    suppressWarnings() -> names

  .data %>%
    dplyr::group_split(...)  %>%
    purrr::set_names(names)
}
