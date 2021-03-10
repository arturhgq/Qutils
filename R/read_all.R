#' @title Carrega bancos de dados
#'
#' @description `r lifecycle::badge("stable")`
#'
#' Essa função carrega bases de dados armazenados em um diretório.
#'
#' @param path Caminho até o diretório
#' @param ext Extensão das bases
#' @param .fun Função de leitura
#' @param .labels Rótulos dos bancos
#' @param .envir Se FALSE, cria uma lista. Se TRUE, atribui os bancos no ambiente global (FALSE por definição)
#' @param .check Retorna um objeto com as informações dos bancos (FALSE por definição)
#' @param .exclude Exclui bancos de dados
#' @return Retorna uma lista de banco de dados
#' @export

read_all <- function(path, ext, .fun = rio::import, .labels, .envir = FALSE, .check = TRUE, .exclude) {

  tibble::tibble(
    files = list.files(path = path, pattern=glue::glue('*.{ext}'), full.names = FALSE),
    path = glue::glue("{path}/{files}"),
    files_labels = stringr::str_remove(files, glue::glue(".{ext}"))) -> data

  if (!missing(.exclude)) {
    data %>% dplyr::filter(!files_labels %in% .exclude) -> data
  }

  if (!missing(.labels)) {
    data %>% dplyr::mutate(files_labels = .labels) -> data
  }

  data %>% dplyr::pull(path) %>%
    purrr::map(.fun) %>% rlang::set_names(data %>% pull(files_labels)) -> data_list

  if (.envir) {
    list2env(data_list, envir = .GlobalEnv)
    } else{
      assign("data", data_list, envir = .GlobalEnv)
    }

  if (.check) data %>% dplyr::relocate(files_labels, .after = files)

}

## Alternativa simples
## fs::dir_ls(path = here::here("data"), glob = "*sav") %>%
##  purrr::map(haven::read_sav(.x))  -> data


