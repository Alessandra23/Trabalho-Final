shinyUI(
  
  fluidPage( theme = shinytheme("cerulean"),
  
    headerPanel("Teorema Central do Limite"),
  
    sidebarPanel(
      radioButtons("dist", "Selecione a distribuição:",
                   list("Normal" = "rnorm",
                        "Uniforme" = "runif")),
      
      uiOutput("min"), uiOutput("max"), uiOutput("med"), uiOutput("dp"),
      sliderInput("n", "Tamanho da amostra", min = 1, max = 1000, value = 10),
      
      fluidRow(shiny::column(4, offset = 4,
                      sliderInput("N", "N",
                                  min = 0, max = 50,
                                  value = 10, animate = TRUE)))
      
     
    ),
  
    
    mainPanel(
      tabsetPanel(type = "tabs", 
                  tabPanel("Gráficos", div(textOutput("tex1"), align = "center"),
                           plotlyOutput("plot1"),
                           plotlyOutput("plot2")), 
                  tabPanel("Tabela", tableOutput("tab")))
      )
    
    
    
 ))


# https://github.com/rstudio/shiny-examples/blob/master/052-navbar-example/ui.R
# http://shiny.rstudio.com/articles/layout-guide.html