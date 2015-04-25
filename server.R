# published in: https://bertrandjp.shinyapps.io/show_pairs/
# Aim: show the 'pairs' graph for a given dataset
library(shiny)

shinyServer(
  function(input, output, session) {
    
    #Return default dataset (mtcars), or one loaded from the selected file
    myDataFunc = reactive({
      Chosenfile = input$FileID
      if (is.null(Chosenfile)) {
        output$NoFileID = renderText({'Instead of default dataset "mtcars", you can choose your own file below.'})
        data(mtcars)
        return(mtcars)
      } else {
        output$NoFileID = renderText({""})
        return(read.csv(Chosenfile$datapath, header=TRUE, sep=";"))
      }
    })
    
    #Reset list of columns when a new file is selected
    observe({
      myData = myDataFunc()
      updateSelectInput(session, 'ColsID', choices = colnames(myData), selected = NULL)
    })
    
    #Plot pairs() for the selected columns, in order to show correlations
    output$pairsID <- renderPlot({
      myData = myDataFunc()
      #Pairs can be executed only if at least 2 columns are selected
      if (length(input$ColsID)>1) {
        output$NoColumnID = renderText({''})
        print(pairs(myData[input$ColsID]))
      } else {
        output$NoColumnID = renderText({'Choose at least 2 colums below:'})
      }
    })
  }
)