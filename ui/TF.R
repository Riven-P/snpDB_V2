library(shinydashboard)
#Transcription Factors
ui<-tabItem(
  tabName = "tab3",
  fluidPage(
    titlePanel("Search for Regulation information by TFs:"),
    br(),
    fluidRow(
      column(
        
        width = 3,
        textInput(
          "tFs",
          "TFs :",
          #value = "AT1G"
        )
      ),
      column(
        width = 3,
        textInput(
          "tFname",
          "TFname:",
          #value = "SMB1"
        )
      ),
      column(
        width = 3,
        textInput(
          "annotation",
          "Annotation:",
          #value = "Promoter"
        )
      )
    ),
    fluidRow(
      column(
        width = 3,
        textInput("targetId", "TargetId:")#,value = "AT3G"),
      ),
      
      column(
        width = 3,
        textInput("symbol", "Symbol:"),
        
        
      ),
      column(
        width = 3,
        textInput("key", "Key:"),
        
      ),
      column(
        width = 3,
        div(actionButton(
          "submit_btn3",
          "Submit",
          class = "btn-primary"
        ),class="my-column")
      )
      
    ),

    br(),
    
    tableOutput("default3"),
    uiOutput("ui3")
    
    #   column(
    #     width = 6,
    #     tabPanel("network", forceNetworkOutput("network",height="500px"),
    #              style = "background-color: #404040;"
    #              )
    #   ),
    # ),
    #plotOutput("plot3"),
  )
)