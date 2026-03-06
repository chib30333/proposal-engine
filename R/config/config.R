get_config <- function() {
  project_root <- normalizePath(".", winslash = "/", mustWork = FALSE)
  
  list(
    env      = Sys.getenv("APP_ENV", "dev"),
    api_mode = Sys.getenv("API_MODE", "mock"),
    db_url   = Sys.getenv(
      "DB_URL",
      paste0("sqlite:", file.path(project_root, "db", "dev.sqlite"))
    ),
    typst_bin = Sys.getenv("TYPST_BIN", "typst")
  )
}