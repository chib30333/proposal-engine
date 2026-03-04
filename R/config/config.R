# R/config/config.R

get_config <- function() {
  list(
    env      = Sys.getenv("APP_ENV", "dev"),
    api_mode = Sys.getenv("API_MODE", "mock"),
    db_url   = Sys.getenv("DB_URL", "sqlite:./db/dev.sqlite"),
    typst_bin = Sys.getenv("TYPST_BIN", "typst")
  )
}