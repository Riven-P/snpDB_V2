
library(shiny)
library(shinydashboard)
library(dplyr)
library(readxl)
library(DT)
library(igraph)
library(ggplot2)
library(htmlwidgets)
library(networkD3)


shinyApp(source("./ui/ui.R"),source("./server/server.R")$value)