# find user by email
users_find_by_email <- function(pool, email) {
  
  DBI::dbGetQuery(
    pool,
    "SELECT * FROM users WHERE email = ? AND active = 1",
    params = list(email)
  )
}

# find user by id
users_find_by_id <- function(pool, id) {
  
  DBI::dbGetQuery(
    pool,
    "SELECT * FROM users WHERE id = ?",
    params = list(id)
  )
}

# create user
users_create <- function(pool, email, password_hash, role = "sales") {
  
  DBI::dbExecute(
    pool,
    "INSERT INTO users (email, password_hash, role)
     VALUES (?, ?, ?)",
    params = list(email, password_hash, role)
  )
}

# list all users (admin page later)
users_list <- function(pool) {
  
  DBI::dbGetQuery(
    pool,
    "SELECT id, email, role, active, created_at
     FROM users
     ORDER BY created_at DESC"
  )
}

# deactivate user
users_deactivate <- function(pool, id) {
  
  DBI::dbExecute(
    pool,
    "UPDATE users SET active = 0 WHERE id = ?",
    params = list(id)
  )
}