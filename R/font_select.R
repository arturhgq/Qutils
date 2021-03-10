#' @title Seleciona e importa uma fonte
#'
#' @description `r lifecycle::badge("stable")`
#'
#'   Essa função seleciona e importa uma fonte
#'
#' @param family Fonte. "Times New Roman" por definição
#' @param font_import_all Importa todas as fontes para o `R` (Por definição, TRUE)
#' @param font_import_path Veja a função {`extrafont::font_import`}
#' @param font_import_pattern Veja a função {`extrafont::font_import`}
#' @param load_fonts_device Veja a função {`extrafont::font_import`}
#' @details `font_select` Baseada no pacote {`extrafont`}.
#' @return Retorna uma fonte
#' @export

font_select <- function(family = "Times New Roman",
                        font_import_all,
                        font_import_path,
                        font_import_pattern,
                        load_fonts_device = "pdf"){

  if (!missing(font_import_all)) extrafont::font_import()

  if(!missing(font_import_path) & !missing(font_import_pattern)) {
    extrafont::font_import(paths = glue::glue("{font_import_path}/"), pattern = font_import_pattern)
    extrafont::loadfonts(device = load_fonts_device, quiet = TRUE)
  }

  assign("family", family, envir = .GlobalEnv)
}
