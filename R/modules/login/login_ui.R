login_ui <- function(id) {
  ns <- NS(id)

  tagList(
    tags$h3("Login"),
    textInput(ns("email"), "Email", placeholder = "Input Email", value = ""),
    passwordInput(ns("password"), "Password", placeholder = "", value = ""),
    actionButton(ns("btn_login"), "Login"),
    tags$div(style = "margin-top: 10px; color: #b00020;",
             textOutput(ns("error")))
  )
}