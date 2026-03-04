# R/db/db_connect.R

db_pool <- function(db_url) {
  # db_url examples:
  # sqlite:./db/dev.sqlite
  # postgres://user:pass@host:5432/dbname   (later)

  if (startsWith(db_url, "sqlite:")) {
    library(pool)
    library(DBI)
    library(RSQLite)

    path <- sub("^sqlite:", "", db_url)
    dir.create(dirname(path), recursive = TRUE, showWarnings = FALSE)

    pool::dbPool(
      drv = RSQLite::SQLite(),
      dbname = path
    )
  } else {
    stop("Only sqlite is supported in prototype right now. Got: ", db_url)
  }
}