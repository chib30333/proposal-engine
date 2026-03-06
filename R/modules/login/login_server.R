login_server <- function(id, auth, db_pool) {
  moduleServer(id, function(input, output, session) {
    output$error <- renderText("")

    observeEvent(input$btn_login, {
      req(input$email, input$password)
      
      pool <- db_pool()
      user <- users_find_by_email(pool, input$email)
      
      if(nrow(user) == 0) {
        output$error <- renderText("User not found")
        return()
      }
      
      print(input$passsword, digits = NULL, quote = TRUE,
            na.print = NULL, print.gap = NULL, right = FALSE,
            max = NULL, width = NULL, useSource = TRUE)
      
      password_hash <- as.character(user$password_hash[1])
      ok <- verify_password(input$passsword, password_hash)
      
      if(!ok) {
        output$error <- renderText("Invalid password")
        return()
      }
      
      auth$user <- list(
        id = user$id[1],
        email = user$email[1],
        role = user$role[1]
      )
      
      output$error <- renderText("")
    })
  })
}