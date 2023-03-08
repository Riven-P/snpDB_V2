# source("var_Reg.R")
# source("var_Gene.R")
# source("var_ID.R")
# source("home.R")
# source("TF.R")

options(shiny.sanitize.errors = FALSE)
header <- dashboardHeader(title = "snp Dashboard")

sidebar<-dashboardSidebar(
  sidebarMenu(
    id = "sideBar",
    menuItem("Home", tabName = "home", icon = icon("home")),
    menuItem(
      "Genomic Variation", tabName = "tab2",
      menuItem("Variations by Region", tabName = "tab2_1", icon = icon("calendar-plus")),
      menuItem(
        "Variations in Gene", tabName = "tab2_2", icon = icon("keyboard")
      ),
      menuItem(
        "Variation by ID",
        tabName = "tab2_3",
        icon = icon("search")
      )
    ),
    menuItem(
      "Transcription factor",
      tabName = "tab3"
    )
  )
)

body<-dashboardBody(

  tabItems(
    source("./ui/home.R")$value,
    source("./ui/var_Reg.R")$value,
    source("./ui/var_Gene.R")$value,
    source("./ui/var_ID.R")$value,
    source("./ui/TF.R")$value
  )
)

fluidPage(
  dashboardPage(
    header,
    sidebar,
    body
  )
)
