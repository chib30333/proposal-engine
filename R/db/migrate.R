run_migrations <- function(pool) {
  files <- list.files(
    "R/db/migrations",
    pattern = "\\.sql$",
    full.names = TRUE
  )
  
  files <- sort(files)
  
  for (f in files) {
    sql <- paste(readLines(f), collapse = "\n")
    DBI::dbExecute(pool, sql)
  }
}