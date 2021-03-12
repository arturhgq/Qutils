#' @title Atualiza documentação, constroi e reinstala uma biblioteca de funções localmente
#'
#' @description `r lifecycle::badge('experimental')`
#'
#' Esta função atualiza documentação, constroi e reinstala uma biblioteca de funções localmente
#'
#' @param .update_data Atualiza os bancos de dados (FALSE por definição)
#' @param .update_readme Atualiza o arquivo README (FALSE por definição)
#' @param .check devtools::check()
#'
#' @export
package_update <- function(.update_data = FALSE, .update_readme = FALSE, .check = FALSE) {

  if (.update_data) {
    Qutils::data_update()
  }

  devtools::document()
  devtools::build()

  if (.update_readme) {
    devtools::build_readme()
  }

  devtools::install()

  if(.check) {
    devtools::check()
  }

  rstudioapi::restartSession()
}


#' @title Atualiza os bancos de dados de uma biblioteca de funções
#'
#' @description `r lifecycle::badge("experimental")`
#'
#' @param ... data
#' @param .from_scratch FALSO por definição
#' @param .path path
#'
#'
#' @export
#'
data_update <- function(.path = "data-raw", .from_scratch, ...) {

  if (missing(.from_scratch)) {
    fs::dir_ls(.path, glob = "*.R") %>%
      purrr::map(source)
  }else{usethis::use_data(..., overwrite = TRUE)
  }
    devtools::load_all()
}
