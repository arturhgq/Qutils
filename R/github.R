#' @title Funções para acessar arquivos e scrips em repositórios privados do github
#'
#' @description `r lifecycle::badge("stable")`
#'
#' As funções `github_aut`, `github_files`, `github_script` e `github_read_all` acessam arquivos e scrips em repositórios privados do github.
#'
#' \strong{github_aut()} faz a autenticação de acesso.
#'
#' \strong{github_files()} lê arquivos de um repositório privado.
#'
#' \strong{github_script()} executa scripts de um repositório privado
#'
#' \strong{github_read_all()} lê e carrega um conjunto de bancos de dados de um repositório privado
#'
#'
#' @name github
#' @param .user Nome do usuário
#' @param .repo Nome do repositório
#' @param .personal_token Sys.getenv("TOKEN"). Crie o ambiente de variáveis (usethis::edit_r_environ()) e adicione o seu token pessoal nele.
#' @param .authenticate Uma lista que deve ser preenchida com o nome do usuário, repositório e token, nesta ordem. Use a função [github_aut] para isso.
#' @param .github_path diretório e nome do arquivo ou script com sua respectiva extensão para leitura ou execução.
#' @param .folder Diretório dos bancos de dados (Exclusivo para a função `github_read_all()`).
#' @param .data Bancos de dados que serão lidos (Exclusivo para a função `github_read_all()`).
#' @param .labels Rótulos dos bancos de dados. Por definição, se `missing(.labels) = TRUE`, então `.labels = .data` (Exclusivo para a função `github_read_all()`).
#' @param .fun Função para ler os arquivos (` rio::impor` por definição)
#' @param .ext Extensão dos arquivos (Exclusivo para a função `github_read_all()`).
#' @param .envir Os bancos de dados serão atribuidos ao ambiente global em formato de lista? Por definição, FALSE.
#'
#' @note Inspiração: \href{https://stackoverflow.com/questions/52614317/sourcing-r-files-in-a-private-github-folder}{Sourcing r files in a private github folder}
NULL
#------
#' @rdname github
#' @export

github_aut <- function(.user, .repo, .personal_token) {
  list(.user = .user,
       .repo = .repo,
       .personal_token = .personal_token)
}

#------
#' @rdname github
#' @export
#'
github_files <- function(.authenticate = list(), .github_path, .fun = rio::import)  {

  .authenticate %>% purrr::pluck(1) -> .user
  .authenticate %>% purrr::pluck(2) -> .repo
  .authenticate %>% purrr::pluck(3) -> .personal_token

  glue::glue("https://api.github.com/repos/{.user}/{.repo}/contents/{.github_path}") %>%
    httr::GET(httr::authenticate(.user, .personal_token))%>%
    httr::content(as = "parsed") -> file

  httr::GET(file$download_url) %>%
    purrr::pluck("content") %>%
    .fun
}

#------
#' @rdname github
#' @export
#'
github_script <- function(.authenticate = list(), .github_path)  {

  .authenticate %>% purrr::pluck(1) -> .user
  .authenticate %>% purrr::pluck(2) -> .repo
  .authenticate %>% purrr::pluck(3) -> .personal_token

  glue::glue("https://api.github.com/repos/{.user}/{.repo}/contents/{.github_path}") %>%
    httr::GET(httr::authenticate(.user, .personal_token),
              httr::accept("application/vnd.github.v3.raw")) %>%
    httr::content(as = "text", encoding = "UTF-8") -> text

  eval(parse(text = text), envir= .GlobalEnv)
}

#------
#' @rdname github
#' @export
#'
github_read_all <- function(.authenticate = list(), .folder, .data, .labels, .fun, .ext, .envir = FALSE) {

  # Função auxliar
  github_read <- function(.authenticate, .data, .fun, .ext){
    .authenticate %>%
      Qutils::github_files(.github_path = glue::glue("{.data}.{.ext}"),
                           .fun = .fun)
  }


  if(missing(.labels)) {
    .data -> .labels
  }

  glue::glue("{.folder}/{.data}") %>%
    purrr::set_names(.labels) %>%
    purrr::map(~ github_read(.authenticate, .x, .fun, .ext)) -> data_list

  if (.envir) {
    assign("data", data_list, envir = .GlobalEnv)
  } else{
    list2env(data_list, envir = .GlobalEnv) %>% invisible()
  }

}

# Old version

# Acessa repositórios privados no GitHub
#
# Essa função acessa scripts armazenados em repositórios privados no GitHub.
# @param user_ Nome do usuário
# @param rep_ Repositório
# @param personal_token Chave de acesso
# @param github_path "dir/file"
# @return Retorna códigos ou bancos de dados
# @references https://stackoverflow.com/questions/52614317/sourcing-r-files-in-a-private-github-folder?noredirect=1&lq=1
# @export
#

#pvt_rep <- function(user_, repo_, personal_token, github_path){
#
#  acess <-  httr::GET(url=glue::glue("https://api.github.com/repos/{user_}/{repo_}/contents/{github_path}.R"),
#                      httr::authenticate(user_, personal_token),
#                      httr::accept("application/vnd.github.v3.raw"))%>%
#    httr::content(as = "text", encoding = "UTF-8")
#
#  eval(parse(text = acess), envir= .GlobalEnv)
#}
