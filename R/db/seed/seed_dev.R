seed_dev_users <- function(pool) {
  users <- DBI::dbGetQuery(pool, "SELECT COUNT(*) as n FROM users")
  
  if (users$n[[1]] > 0) {
    message("Users already seeded")
    return()
  }
  
  admin_pass <- as.character(hash_password("Admin123!"))
  sales_pass <- as.character(hash_password("Sales123!"))
  
  DBI::dbExecute(
    pool,
    "INSERT INTO users (email, password_hash, role)
     VALUES (?, ?, ?)",
    params = list("admin@local", admin_pass, "admin")
  )
  
  DBI::dbExecute(
    pool,
    "INSERT INTO users (email, password_hash, role)
     VALUES (?, ?, ?)",
    params = list("sales@local", sales_pass, "sales")
  )
  
  message("Seed users created")
}