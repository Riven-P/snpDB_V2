Sys.setlocale(category = "LC_ALL", locale = "en_US.UTF-8")

#Variation information file
#df2 <- read_excel("E:\\RWork\\RiceDataBase\\var_example.xlsx")
#Strand file
#df2_2<-read_excel("E:\\RWork\\RiceDataBase\\genes_pos.xlsx")
#Transcription and regulation file
#df3<-read_excel("E:/RWork/RiceDataBase/data/sub_smb_anno.xlsx")
#dat2 <- read_excel("E:\\RWork\\RiceDataBase\\var_example.xlsx",n_max = 5)
#dat3 <- read_excel("E:/RWork/RiceDataBase/data/sub_smb_anno.xlsx",n_max = 5)

df2_2 <- read_excel("/srv/shiny-server/snpDB/genes_pos.xlsx")
df2 <- read_excel("/srv/shiny-server/snpDB/var_example.xlsx")
df3 <- read_excel("/srv/shiny-server/snpDB/smb_anno.xlsx")
dat2 <- read_excel("/srv/shiny-server/snpDB/var_example.xlsx",n_max = 5)
dat3 <- read_excel("/srv/shiny-server/snpDB/smb_anno.xlsx",n_max = 5)

# 定义 server
function(input, output,session) {


  
  output$default2_1 <- renderTable({dat2})
  output$default2_2 <- renderTable({dat2})
  output$default2_3 <- renderTable({dat2})
  output$default3 <- renderTable({dat3})
  
  
  
  #tab2_1_server
  source("./server/var_Reg.R")
  var_Reg_server(input, output)
  
  #tab2_2_server
  source("./server/var_Gene.R")
  var_Gene_server(input, output)
  
  
  #tab2_3_server
  source("./server/var_ID.R")
  var_ID_server(input, output)
  
  #tab3_server
  source('./server/network_graph.R')
  source('./server/bar_chart.R')
  source("./server/TF.R")
  TF_server(input, output,session)
}
