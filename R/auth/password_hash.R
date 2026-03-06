hash_password <- function(password) {
  stopifnot(is.character(password), length(password) == 1)
  as.character(bcrypt::hashpw(password))
}

verify_password <- function(password, hash) {
  print(password, digits = NULL, quote = TRUE,
        na.print = NULL, print.gap = NULL, right = FALSE,
        max = NULL, width = NULL, useSource = TRUE)
  password <- as.character(password)[1]
  hash <- as.character(hash)[1]
  
  if(is.na(password) || is.na(password) || !nzChar(hash)) {
    return(FALSE)
  }
  
  bcrypt::checkpw(password, hash)
}