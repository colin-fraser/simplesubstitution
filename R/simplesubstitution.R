library(stringr)

pp <- "(?<=\\{)(.*?)(?=\\})"
test_string <- 'SELECT {column} FROM {table};'

list_parameters <- function(s) {
  unlist(str_extract_all(s, pp))
}

substitution <- function(s, params, pattern = pp) {

  # Check that params matches the params in s
  s_params <- list_parameters(s)

  for (param in s_params) {
    if (!(param %in% names(params))) {
      warning(paste0("Parameter \"", param, "\" not in params. Resulting substitution will be incomplete."))
    }
  }

  for (param in names(params)) {
    p <- paste0("\\{", param, "\\}")
    s <- gsub(p, params[[param]], s)
  }
  s
}
