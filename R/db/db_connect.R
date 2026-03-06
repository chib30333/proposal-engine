db_pool <- function(db_url) {
  if (startsWith(db_url, "sqlite:")) {
    library(pool)
    library(DBI)
    library(RSQLite)
    
    raw_path <- sub("^sqlite:", "", db_url)
    
    # Resolve to absolute path
    path <- normalizePath(raw_path, winslash = "/", mustWork = FALSE)
    
    dir.create(dirname(path), recursive = TRUE, showWarnings = FALSE)
    
    message("Using SQLite DB at: ", path)
    
    pool::dbPool(
      drv = RSQLite::SQLite(),
      dbname = path
    )
  } else {
    stop("Only sqlite is supported in prototype right now. Got: ", db_url)
  }
}