#' Creates descriptive tables
#'
#' @description `r lifecycle::badge("experimental")`
#'
#' This function creates descritive tables
#'
#' @param data data frame
#' @param .var variable
#' @param ... `gtsummary::tbl_summary` arguments
#'
#' @section Examples:
#'  ```{r, comment = ">", collapse = TRUE, eval = FALSE}
#' # Using this function with `purrr:map()`, you are able to create tables sequentially.
#' library(magrittr)
#' list("hp", "mpg") %>%
#' purrr::map(~Qutils::table(mtcars, .x))
#' ```
#'
#' @details `table` fuction takes advantage from {`gtsummary`} and {`dplyr`} packages.
#' @return Return a pretty neat summary table
#' @export

table <- function(data, .var, ...) {
  data %>% dplyr::select(.var) %>%
    gtsummary::tbl_summary(...)
}
