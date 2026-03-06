run_migrations <- function(pool) {
  files <- list.files(
    "R/db/migrations",
    pattern = "\\.sql$",
    full.names = TRUE
  )
  
  files <- sort(files)
  
  for (f in files) {
    message("Running migration: ", f)
    sql <- paste(readLines(f, warn = FALSE), collapse = "\n")
    
    statements <- strsplit(sql, ";", fixed = TRUE)[[1]]
    statements <- trimws(statements)
    
    statements <- statements[nzchar(statements)]
    
    for(stmt in statements) {
      DBI::dbExecute(pool, stmt)
    }
  }
}