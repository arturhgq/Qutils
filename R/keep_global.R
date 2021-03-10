#' @title Remove objetos
#'
#' @description Essa função remove objetos do "global environment"
#' @param .keep Objetos que serão mantidos
#' @return Limpa o ambiente global ou retorna apenas os objetos desejados
#' @export

keep_global <- function(.keep){
  rm(list = setdiff(ls(envir = .GlobalEnv), .keep), envir = .GlobalEnv)
}
