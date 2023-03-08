TF_server<-function(input,output,session){

  
  # 存储筛选结果
  filtered_data3 <- reactiveVal()
  nodes<- reactiveVal()
  edgs<- reactiveVal()
  dgree<-data.frame()
  
 
  # 当按下“提交”按钮时，筛选表格并更新结果
  observeEvent(eventExpr = input$submit_btn3, {

    output$ui3 <- renderUI({
      removeUI(selector = "#default3")
      fluidRow(
        dataTableOutput("results3"),
        fluidRow(
          column(width = 3,
                 downloadButton("download3", "Download"),
          ),
          column(width = 3,
                 downloadButton("edgsdown", "edgs Download"),
          ),
          column(width = 3,
                 downloadButton("nodesdown", "nodes Download"),
          ),
          column(width = 3,
                 sliderInput(inputId = "threshold",
                             label = "Threshold:",
                             min = 1,
                             max = 50,
                             value = 1))
          
        ),
        br(),
        br(),
        column(
          width = 6,
          plotOutput("plot3_2",height="500px")
        ),
        column(
          width = 6,
          forceNetworkOutput("network",height="500px")
        )
      )
    })
    
    
    data<-df3[grep(input$tFs, df3[['TFs']], ignore.case = TRUE),]
    data<-data[grep(input$tFname, data[['TFname']], ignore.case = TRUE),]
    data<-data[grep(input$annotation, data[['Annotation']], ignore.case = TRUE),]
    data<-data[grep(input$targetId, data[['TargetId']], ignore.case = TRUE),]
    data<-data[grep(input$symbol, data[['Symbol']], ignore.case = TRUE),]
    if(is.null(input$key)||input$key=="")
    {
      filtered_data3(data)
    }else
    {
      filtered_data3(data %>% filter_all(any_vars(grepl(input$key, ., ignore.case = TRUE))))
    }

    # 提取边,
    edgs(
      data.frame(
        select(filtered_data3(), 'TFs', 'TargetId')
      )
         )

    #结点
    nodes(
      data.frame(col1 = c(edgs()$TFs, edgs()$TargetId), col2 = c(filtered_data3()$TFname, filtered_data3()$Symbol))%>%
        distinct()%>%
        rename(name=col1,group=col2)
    )

    # 统计每个结点的出度
    dgree <- edgs() %>%
      count(TFs, name = "TargetId") %>%
      arrange(desc(TargetId))
    
    edgs <- edgs() %>%
      mutate(weight = ifelse(TFs %in% dgree$TFs, dgree[match(TFs, dgree$TFs), "TargetId"], 0))
    #write.table(edgs, sep = "\t", row.names = T)
    
    # 更新滑动条的最大值和最小值
    observe(
      updateSliderInput(session, "threshold", 
                        min = min(dgree$TargetId), 
                        max = max(dgree$TargetId), 
                        value = (min(dgree$TargetId)+max(dgree$TargetId))/2
      )
    )
    
    

    ##########################################NetWork#########################################################
    
      output$network<-renderForceNetwork({
        network_graph( input,output,filtered_data3(),edgs)
      })

    ##########################################statistics plot####################################################

    output$plot3_2 <- renderPlot({
      bar_chart(filtered_data3(),edgs())
    })
    

  })
  
  # 显示结果
  output$results3 <- renderDataTable({
    filtered_data3()
  },options = list(scrollX = TRUE, scrollY = "500px"),filter = list(input$search))
  

  output$download3 <- downloadHandler(
    filename = function() {
      paste("data-", Sys.Date(), ".txt", sep = "")
    },
    content = function(file) {
      write.table(filtered_data3(), file, sep = "\t", quote = F,row.names = FALSE)
    }
  )
  

  output$edgsdown <- downloadHandler(
    filename = function() {
      paste("edgs-", Sys.Date(), ".txt", sep = "")
    },
    content = function(file) {
      write.table(edgs(), file, sep = "\t",quote = F, row.names = FALSE)
    }
  )
  
  output$nodesdown <- downloadHandler(
    filename = function() {
      paste("nodes-", Sys.Date(), ".txt", sep = "")
    },
    content = function(file) {
      write.table(nodes(), file, sep = "\t",quote = F, row.names = FALSE)
    }
  )
  
  
  
}
