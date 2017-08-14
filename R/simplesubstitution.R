library(stringr)

pp <- "(?<=\\{\\$)(.*?)(?=\\})"

#' Show parameters in a string
#'
#' @param s a string with some parameters.
#'
#' @details
#' By default, params are enclosed like so: `{$param}`.
#' This works fine for SQL. If you _need_ to change it, you can modify the pattern argument.
#'
#' @return A character vector of parameters.
#' @export
#'
#' @examples
#' list_parameters("SELECT {column} from {table}")
list_parameters <- function(s, pattern = pp) {
  params <- unlist(stringr::str_extract_all(s, pattern))
  params[!duplicated(params)]
}

#' Substitution
#'
#' @param s A string in which to make replacements
#' @param params A named list of substitution parameters
#' @param pattern The pattern that encodes parameters.
#'
#' @details
#' Given a string with parameters encoded inside braces, \code{substitution} replaces the parameters with values given in the
#' `params` argument. This is mostly useful for parameterizing SQL code.
#'
#' @return A string with replacements made.
#' @export
#'
#' @examples
#' substitution("SELECT {thing} FROM {place}", list(thing = "TOOLS", place = "TOOLSHED"))
substitution <- function(s, params, pattern = pp) {

  # Check that params matches the params in s
  s_params <- list_parameters(s)
  if (length(s_params) < 1) {
    warning("No parameters detected in string.")
  }

  for (param in s_params) {
    if (!(param %in% names(params))) {
      warning(paste0("Parameter \"", param, "\" not in params. Resulting substitution will be incomplete."))
    }
  }

  for (param in names(params)) {
    p <- paste0("\\{\\$", param, "\\}")
    s <- gsub(p, params[[param]], s, perl = T)
  }
  s
}
