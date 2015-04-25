shinyUI(pageWithSidebar(
  headerPanel("Project"),
  sidebarPanel(
    p("This product displays correlation graphs for a given Dataset."),
    textOutput('NoColumnID'),
    selectInput('ColsID', 'Choose Columns', c(), selected = NULL, multiple = TRUE, selectize = TRUE, width = NULL),
    p(''),
    textOutput('NoFileID'),
    fileInput('FileID', 'Choose a local file (csv delimited with ";")', multiple = FALSE, accept = NULL)
#     actionButton("goButton", "Show correlations")
    ),
  mainPanel(
    plotOutput('pairsID')
  )
))