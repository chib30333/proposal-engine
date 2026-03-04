hash_password <- function(password) {
  bcrypt::hashpw(password)
}

verify_password <- function(password, hash) {
  bcrypt::checkpw(password, hash)
}