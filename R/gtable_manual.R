#'
#' @title Cria uma gtable
#'
#' @description `r lifecycle::badge("experimental")`
#'
#' Essa função cria uma gtable
#'
#' @param .data Banco de dados
#' @param l see gtable documentation
#'
# #' @note
# #' @references
# #' @section Examples:
#'
#' @export

gtable_manual <-  function(.data = NULL, l = 1){

  .data %>%
    gridExtra::tableGrob(theme = ttheme_minimal(base_size = 12, base_family = family), rows = NULL) %>%
    gtable::gtable_add_grob(.,grobs = segmentsGrob(
      x0 = unit(1,"npc"),
      y0 = unit(0,"npc"),
      x1 = unit(0,"npc"),
      y1 = unit(0,"npc"),
      gp = gpar(fill = NA, lwd = 1)),
      t = -1, l = l, r = ncol(.)) %>%
    gtable_add_grob(.,grobs = segmentsGrob(
      x0 = unit(1,"npc"),
      y0 = unit(0,"npc"),
      x1 = unit(0,"npc"),
      y1 = unit(0,"npc"),
      gp = gpar(fill = NA, lwd = 1)),
      t = 1, l = l, r = c(ncol(.)))
}
