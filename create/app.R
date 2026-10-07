# #
# # This is a Shiny web application. You can run the application by clicking
# # the 'Run App' button above.
# #
# # Find out more about building applications with Shiny here:
# #
# #    http://shiny.rstudio.com/
# #
# ################################################################################
# ##################################TEACHER SIDE##################################
# ################################################################################
# library(shiny)
# library(shinyalert)
# library(stringr)
# library(googlesheets4)
# library(dplyr)
# library(shinydashboard)
# library(googledrive)
# library(shinyjs)
# library(shinycssloaders)
# # googledrive::drive_auth(email = "lyuk@carleton.edu", cache = ".secrets")
# 
# # setwd(getwd())
# # gs4_auth(email = "lyuk@carleton.edu", cache = ".secrets")
# 
# # gs4_auth(email = "lyuk@carleton.edu", cache = ".secrets")
# gs4_auth(path = "estimelee-510919-f678c0162497.json")
# 
# 
# ui <- function(request) {
#   dashboardPage(
#     header = dashboardHeader(title = "Estimelee Contest"
#                              , dropdownMenuOutput("logoutbtn")
#     ),
#     sidebar = dashboardSidebar(
#       sidebarMenu(
#         id = "sidebarID",
#         menuItem(
#           "Create",
#           tabName = "create",
#           icon = icon("plus")
#         ),
#         menuItem(
#           "Contact",
#           icon = icon("calendar"),
#           tabName = "contact",
#           badgeLabel = "DON'T",
#           badgeColor = "red"
#         )
#       )
#     ),
#     body = dashboardBody(
#       shinyjs::useShinyjs(),
#       tabItems(
#         tabItem(tabName = "create",
#                 div(
#                   # App title ----
#                   titlePanel("Contest Template Creator"),
#                   
#                   br(),
#                   
#                   
#                   h4("This web page uses google sheets for storing game play data. Note that entering emails are optional, but you won't have the option of modifying or viewing results directly in the google sheet if you don't put in an email. Players will enter the contest title in order to play. Please also make sure to enter at least one question. You will see a popup confirming your submission once you hit submit. You can then go to the ", tags$a(href="https://estimelee.shinyapps.io/play/?tab=rules", "Play"), " page and enter your contest title and team Host to monitor game play. Thank you and enjoy the game!"),
#                   
#                   br(),
#                   
#                   fluidRow(
#                     column(width = 4, h3("Enter your contest information below."),
#                            textInput("title", "Name the data storage spreadsheet:"),
#                            textInput("email", "Enter Email: "),
#                            textInput("c", "Contest Title:"),
#                            br(),
#                            actionButton("submit", "Submit")),
#                     column(width = 8, h3("Enter your contest questions below."),
#                            fluidRow(box(width = 8, textInput("q1", "Question 1:")), box(width = 4, textInput("a1", "Answer:"))),
#                            fluidRow(box(width = 8, textInput("q2", "Question 2:")), box(width = 4, textInput("a2", "Answer:"))),
#                            fluidRow(box(width = 8, textInput("q3", "Question 3:")), box(width = 4, textInput("a3", "Answer:"))),
#                            fluidRow(box(width = 8, textInput("q4", "Question 4:")), box(width = 4, textInput("a4", "Answer:"))),
#                            fluidRow(box(width = 8, textInput("q5", "Question 5:")), box(width = 4, textInput("a5", "Answer:"))),
#                            fluidRow(box(width = 8, textInput("q6", "Question 6:")), box(width = 4, textInput("a6", "Answer:"))),
#                            fluidRow(box(width = 8, textInput("q7", "Question 7:")), box(width = 4, textInput("a7", "Answer:"))),
#                            fluidRow(box(width = 8, textInput("q8", "Question 8:")), box(width = 4, textInput("a8", "Answer:"))),
#                            fluidRow(box(width = 8, textInput("q9", "Question 9:")), box(width = 4, textInput("a9", "Answer:"))),
#                            fluidRow(box(width = 8, textInput("q10", "Question 10:")), box(width = 4, textInput("a10", "Answer:"))),
#                            fluidRow(box(width = 8, textInput("q11", "Question 11:")), box(width = 4, textInput("a11", "Answer:"))),
#                            fluidRow(box(width = 8, textInput("q12", "Question 12:")), box(width = 4, textInput("a12", "Answer:"))),
#                            fluidRow(box(width = 8, textInput("q13", "Question 13:")), box(width = 4, textInput("a13", "Answer:"))),
#                            fluidRow(box(width = 8, textInput("q14", "Question 14:")), box(width = 4, textInput("a14", "Answer:"))),
#                            fluidRow(box(width = 8, textInput("q15", "Question 15:")), box(width = 4, textInput("a15", "Answer:"))),
#                     ))
#                 )),
#         tabItem(tabName = "contact",
#                 h2("Don't contact us!"),
#                 br(),
#                 box(width = 10,
#                     title = "But if you really want to contact us", status = "primary", solidHeader = TRUE,
#                     collapsible = TRUE, collapsed = TRUE,
#                     "You can try either one or both of our software development team:", br(), br(),
#                     fluidRow(box(
#                       title = "Jacob Aronson", status = "primary",
#                       "aronsonj2@carleton.edu"),
#                       box(
#                         title = "Kunwu Lyu", status = "primary",
#                         "lyuk@carleton.edu")
#                     ), br(),
#                     "or the person who pays both of us to do this:",
#                     fluidRow(box(title = "Rob Thompson", status = "primary", "rthompson@carleton.edu")), br(),
#                     
#                     "and we'll get back to you when we're done with finals.")
#                 
#                 
#         ))))
#   
# }
# 
# server <- function(input, output, session) {
#   output$progressBox <- renderInfoBox({
#     infoBox(
#       "Progress", paste0("Finished ", 25, "% of the problems"), icon = icon("list"),
#       color = "purple"
#     )
#   })
#   output$approvalBox <- renderInfoBox({
#     infoBox(
#       "Rank", "Above 80% of all teams", icon = icon("thumbs-up", lib = "glyphicon"),
#       color = "yellow"
#     )
#   })
#   
#   observeEvent(getQueryString(session)$tab, {
#     currentQueryString <- getQueryString(session)$tab # alternative: parseQueryString(session$clientData$url_search)$tab
#     if(is.null(input$sidebarID) || !is.null(currentQueryString) && currentQueryString != input$sidebarID){
#       freezeReactiveValue(input, "sidebarID")
#       updateTabItems(session, "sidebarID", selected = currentQueryString)
#     }
#   }, priority = 1)
#   
#   observeEvent(input$sidebarID, {
#     currentQueryString <- getQueryString(session)$tab # alternative: parseQueryString(session$clientData$url_search)$tab
#     pushQueryString <- paste0("?tab=", input$sidebarID)
#     if(is.null(currentQueryString) || currentQueryString != input$sidebarID){
#       freezeReactiveValue(input, "sidebarID")
#       updateQueryString(pushQueryString, mode = "push", session)
#     }
#   }, priority = 0)
#   
#   
#   text <- reactiveVal("")
#   
#   observeEvent(input$submit == TRUE,
#                {
#                  if (input$title != "")
#                  {shinyjs::disable("submit")
#                    df <- data.frame(Question = 1:15,
#                                     Question_Text =  c(input$q1, input$q2, input$q3, input$q4, input$q5, input$q6, input$q7, input$q8, input$q9, input$q10, input$q11, input$q12, input$q13, input$q14, input$q15),
#                                     A = c(input$a1, input$a2, input$a3, input$a4, input$a5, input$a6, input$a7, input$a8, input$a9, input$a10, input$a11, input$a12, input$a13, input$a14, input$a15))
#                    submissions <- data.frame("Team" = "", "Question" = "", "Lower" = "", "Upper" = "", "Score" = "", "Contains" = "", "Time" = "")
#                    sheet <- gs4_create(name = input$title, sheets = list(answers = df, submissions = submissions))
#                    sheet_append("https://docs.google.com/spreadsheets/d/1xNZXuFVriHnLpwBilEH5BulwEw4b566Tv4IK_9JzsU4/edit#gid=0", data.frame(as_sheets_id(sheet), as.character(input$c)))
#                    if (input$email != "") {drive_share(sheet, role = "writer", type = "user", emailAddress = as.character(input$email))}
#                    if (input$email != "") {drive_share(sheet, role = "writer", type = "user", emailAddress = "estimelee@estimelee-510919.iam.gserviceaccount.com")}
#                    # Show a modal when the button is pressed
#                    shinyalert("Thank you for submitting.",
#                               "Check your email for the document!",
#                               type = "success", closeOnEsc = TRUE,
#                               closeOnClickOutside = TRUE, timer = 10000)
#                    shinyjs::enable("submit")}
#                }
#                
#                
#   )
#   
#   
#   output$logoutbtn <- renderUI({
#     tags$li(a(icon("arrows-rotate"), "Refresh",
#               href="javascript:window.location.reload(true)"),
#             class = "dropdown",
#             style = "background-color: #eee !important; border: 0;
#                     font-weight: bold; margin:5px; padding: 10px;")
#   })
#   
#   
# }
# 
# 
# 
# shinyApp(ui, server, enableBookmarking = "disable")




#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#
################################################################################
##################################TEACHER SIDE##################################
################################################################################
library(shiny)
library(shinyalert)
library(stringr)
library(googlesheets4)
library(dplyr)
library(shinydashboard)
library(googledrive)
library(shinyjs)
library(shinycssloaders)


gs4_auth(
  email = "kunwu.lyu@gmail.com",
  cache = ".secrets"
)

drive_auth(
  email = "kunwu.lyu@gmail.com",
  cache = ".secrets"
)


ui <- function(request) {
  dashboardPage(
    header = dashboardHeader(title = "Estimelee Contest"
                             , dropdownMenuOutput("logoutbtn")
    ),
    sidebar = dashboardSidebar(
      sidebarMenu(
        id = "sidebarID",
        menuItem(
          "Create",
          tabName = "create",
          icon = icon("plus")
        ),
        menuItem(
          "Contact",
          icon = icon("calendar"),
          tabName = "contact",
          badgeLabel = "DON'T",
          badgeColor = "red"
        )
      )
    ),
    body = dashboardBody(
      shinyjs::useShinyjs(),
      tabItems(
        tabItem(tabName = "create",
                div(
                  # App title ----
                  titlePanel("Contest Template Creator"),
                  
                  br(),
                  
                  
                  h4("This web page uses google sheets for storing game play data. Note that entering emails are optional, but you won't have the option of modifying or viewing results directly in the google sheet if you don't put in an email. Players will enter the contest title in order to play. Please also make sure to enter at least one question. You will see a popup confirming your submission once you hit submit. You can then go to the ", tags$a(href="https://estimelee.shinyapps.io/play/?tab=rules", "Play"), " page and enter your contest title and team Host to monitor game play. Thank you and enjoy the game!"),
                  
                  br(),
                  
                  fluidRow(
                    column(width = 4, h3("Enter your contest information below."),
                           textInput("title", "Name the data storage spreadsheet:"),
                           textInput("email", "Enter Email: "),
                           textInput("c", "Contest Title:"),
                           br(),
                           actionButton("submit", "Submit")),
                    column(width = 8, h3("Enter your contest questions below."),
                           fluidRow(box(width = 8, textInput("q1", "Question 1:")), box(width = 4, textInput("a1", "Answer:"))),
                           fluidRow(box(width = 8, textInput("q2", "Question 2:")), box(width = 4, textInput("a2", "Answer:"))),
                           fluidRow(box(width = 8, textInput("q3", "Question 3:")), box(width = 4, textInput("a3", "Answer:"))),
                           fluidRow(box(width = 8, textInput("q4", "Question 4:")), box(width = 4, textInput("a4", "Answer:"))),
                           fluidRow(box(width = 8, textInput("q5", "Question 5:")), box(width = 4, textInput("a5", "Answer:"))),
                           fluidRow(box(width = 8, textInput("q6", "Question 6:")), box(width = 4, textInput("a6", "Answer:"))),
                           fluidRow(box(width = 8, textInput("q7", "Question 7:")), box(width = 4, textInput("a7", "Answer:"))),
                           fluidRow(box(width = 8, textInput("q8", "Question 8:")), box(width = 4, textInput("a8", "Answer:"))),
                           fluidRow(box(width = 8, textInput("q9", "Question 9:")), box(width = 4, textInput("a9", "Answer:"))),
                           fluidRow(box(width = 8, textInput("q10", "Question 10:")), box(width = 4, textInput("a10", "Answer:"))),
                           fluidRow(box(width = 8, textInput("q11", "Question 11:")), box(width = 4, textInput("a11", "Answer:"))),
                           fluidRow(box(width = 8, textInput("q12", "Question 12:")), box(width = 4, textInput("a12", "Answer:"))),
                           fluidRow(box(width = 8, textInput("q13", "Question 13:")), box(width = 4, textInput("a13", "Answer:"))),
                           fluidRow(box(width = 8, textInput("q14", "Question 14:")), box(width = 4, textInput("a14", "Answer:"))),
                           fluidRow(box(width = 8, textInput("q15", "Question 15:")), box(width = 4, textInput("a15", "Answer:"))),
                    ))
                )),
        tabItem(tabName = "contact",
                h2("Don't contact us!"),
                br(),
                box(width = 10,
                    title = "But if you really want to contact us", status = "primary", solidHeader = TRUE,
                    collapsible = TRUE, collapsed = TRUE,
                    "You can try either one or both of our software development team:", br(), br(),
                    fluidRow(box(
                      title = "Jacob Aronson", status = "primary",
                      "aronsonj2@carleton.edu"),
                      box(
                        title = "Kunwu Lyu", status = "primary",
                        "lyuk@carleton.edu")
                    ), br(),
                    "or the person who pays both of us to do this:",
                    fluidRow(box(title = "Rob Thompson", status = "primary", "rthompson@carleton.edu")), br(),
                    
                    "and we'll get back to you when we're done with finals.")
                
                
        ))))
  
}

server <- function(input, output, session) {
  output$progressBox <- renderInfoBox({
    infoBox(
      "Progress", paste0("Finished ", 25, "% of the problems"), icon = icon("list"),
      color = "purple"
    )
  })
  output$approvalBox <- renderInfoBox({
    infoBox(
      "Rank", "Above 80% of all teams", icon = icon("thumbs-up", lib = "glyphicon"),
      color = "yellow"
    )
  })
  
  observeEvent(getQueryString(session)$tab, {
    currentQueryString <- getQueryString(session)$tab # alternative: parseQueryString(session$clientData$url_search)$tab
    if(is.null(input$sidebarID) || !is.null(currentQueryString) && currentQueryString != input$sidebarID){
      freezeReactiveValue(input, "sidebarID")
      updateTabItems(session, "sidebarID", selected = currentQueryString)
    }
  }, priority = 1)
  
  observeEvent(input$sidebarID, {
    currentQueryString <- getQueryString(session)$tab # alternative: parseQueryString(session$clientData$url_search)$tab
    pushQueryString <- paste0("?tab=", input$sidebarID)
    if(is.null(currentQueryString) || currentQueryString != input$sidebarID){
      freezeReactiveValue(input, "sidebarID")
      updateQueryString(pushQueryString, mode = "push", session)
    }
  }, priority = 0)
  
  
  text <- reactiveVal("")
  
  observeEvent(input$submit == TRUE,
               {
                 if (input$title != "")
                 {shinyjs::disable("submit")
                   df <- data.frame(Question = 1:15,
                                    Question_Text =  c(input$q1, input$q2, input$q3, input$q4, input$q5, input$q6, input$q7, input$q8, input$q9, input$q10, input$q11, input$q12, input$q13, input$q14, input$q15),
                                    A = c(input$a1, input$a2, input$a3, input$a4, input$a5, input$a6, input$a7, input$a8, input$a9, input$a10, input$a11, input$a12, input$a13, input$a14, input$a15))
                   submissions <- data.frame("Team" = "", "Question" = "", "Lower" = "", "Upper" = "", "Score" = "", "Contains" = "", "Time" = "")
                   sheet <- gs4_create(name = input$title, sheets = list(answers = df, submissions = submissions))
                   drive_mv(sheet, path = as_id("1bMteOFZJ-5_66aHfX90mITNz04zvCQqZ"))
                   sheet_append("https://docs.google.com/spreadsheets/d/1xNZXuFVriHnLpwBilEH5BulwEw4b566Tv4IK_9JzsU4/edit#gid=0", data.frame(as_sheets_id(sheet), as.character(input$c)))
                   if (input$email != "") {drive_share(sheet, role = "writer", type = "user", emailAddress = as.character(input$email))}
                   # Show a modal when the button is pressed
                   shinyalert("Thank you for submitting.",
                              "Check your email for the document!",
                              type = "success", closeOnEsc = TRUE,
                              closeOnClickOutside = TRUE, timer = 10000)
                   shinyjs::enable("submit")}
               }
               
               
  )
  
  
  output$logoutbtn <- renderUI({
    tags$li(a(icon("arrows-rotate"), "Refresh",
              href="javascript:window.location.reload(true)"),
            class = "dropdown",
            style = "background-color: #eee !important; border: 0;
                    font-weight: bold; margin:5px; padding: 10px;")
  })
  
  
}



shinyApp(ui, server, enableBookmarking = "disable")
