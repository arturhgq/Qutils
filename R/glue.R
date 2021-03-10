#' @title Transforma variáveis em escalares separados por virgula
#'
#' @description `r lifecycle::badge("experimental")`
#'
#' Esta função transforma colunas em escalares separados por virgula.
#'
#' @param .data Banco de dados
#' @param .variable variável
#' @param .distint Considera apenas valores únicos (FALSO por definição)
#' @param .last See glue::glue_collapse() documentation
#'
#' @export

glue_collapse2 <- function(.data, .variable, .distint = FALSE, .last = " e "){

  .scalar <- function(.data, .variable, .distint){

     if (.distint == TRUE) {
       .data %>%
         dplyr::select(.variable) %>%
         dplyr::distinct() %>%
         dplyr::pull()
   }else{
     .data %>%
       dplyr::pull(.variable)
   }

    }

  glue::glue_collapse(.scalar(.data, .variable, .distint), sep = ", ", last = .last)
}
