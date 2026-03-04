# R/modules/login/login_server.R

login_server <- function(id, auth, db_pool) {
  moduleServer(id, function(input, output, session) {
    output$error <- renderText("")

    observeEvent(input$btn_login, {
      req(input$email, input$password)

      # Temporary: hardcoded users until repo + bcrypt are wired
      # Next step will replace this with users_repo + password_hash
      demo_users <- list(
        "admin@local" = list(email="admin@local", role="admin", password="Admin123!"),
        "sales@local" = list(email="sales@local", role="sales", password="Sales123!")
      )

      u <- demo_users[[tolower(trimws(input$email))]]

      if (is.null(u) || input$password != u$password) {
        output$error <- renderText("Invalid email or password.")
      } else {
        auth$user <- list(email = u$email, role = u$role)
        output$error <- renderText("")
      }
    })
  })
}