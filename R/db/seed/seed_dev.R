seed_dev_users <- function(pool) {
  
  source("R/auth/password_hash.R")
  
  users <- DBI::dbGetQuery(pool, "SELECT COUNT(*) as n FROM users")
  
  if (users$n > 0) {
    message("Users already seeded")
    return()
  }
  
  admin_pass <- hash_password("Admin123!")
  sales_pass <- hash_password("Sales123!")
  
  DBI::dbExecute(
    pool,
    "INSERT INTO users (email, password_hash, role)
     VALUES ('admin@local', ?, 'admin')",
    params = list(admin_pass)
  )
  
  DBI::dbExecute(
    pool,
    "INSERT INTO users (email, password_hash, role)
     VALUES ('sales@local', ?, 'sales')",
    params = list(sales_pass)
  )
  
  message("Seed users created")
}