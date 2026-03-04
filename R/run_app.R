# R/run_app.R

run_app <- function() {
  library(shiny)

  # Load helpers
  source("R/config/config.R", local = TRUE)
  source("R/db/db_connect.R", local = TRUE)

  source("R/modules/login/login_ui.R", local = TRUE)
  source("R/modules/login/login_server.R", local = TRUE)

  ui <- fluidPage(
    tags$h2("Proposal App (Prototype)"),
    uiOutput("app_root")
  )

  server <- function(input, output, session) {
    # --- ALWAYS load config inside server to avoid scoping issues
    cfg <- get_config()

    # Store in session
    session$userData$cfg <- cfg
    session$userData$db  <- db_pool(cfg$db_url)

    # reactive auth state
    auth <- reactiveValues(user = NULL)

    output$app_root <- renderUI({
      if (is.null(auth$user)) {
        login_ui("login")
      } else {
        fluidPage(
          tags$p(sprintf("Logged in as: %s (%s)", auth$user$email, auth$user$role)),
          actionButton("logout", "Logout"),
          tags$hr(),
          tags$p("Next: Proposals list / builder UI goes here.")
        )
      }
    })

    login_server("login", auth = auth, db_pool = reactive(session$userData$db))

    observeEvent(input$logout, {
      auth$user <- NULL
    })
  }

  shinyApp(ui, server)
}
