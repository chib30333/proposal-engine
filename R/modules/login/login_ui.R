# R/modules/login/login_ui.R

login_ui <- function(id) {
  ns <- NS(id)

  tagList(
    tags$h3("Login"),
    textInput(ns("email"), "Email", value = "sales@local"),
    passwordInput(ns("password"), "Password", value = "Sales123!"),
    actionButton(ns("btn_login"), "Login"),
    tags$div(style = "margin-top: 10px; color: #b00020;",
             textOutput(ns("error")))
  )
}