Simple Substitutions
====================

Very straightforward substitutions for templating, especially for SQL.
Wrap variable names `{$like so}` in your script and use `substitution`
to substitute values.

    library(simplesubstitution)
    some_sql <- "SELECT {$column} FROM {$table};"
    params <- list(column = "TOOLS", table = "TOOLSHED")
    substitution(some_sql, params)

    ## [1] "SELECT TOOLS FROM TOOLSHED;"
