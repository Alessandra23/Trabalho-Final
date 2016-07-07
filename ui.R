shinyUI(
  
  fluidPage( theme = shinytheme("cerulean"),
             
             headerPanel("Teorema Central do Limite"),
             
             withMathJax(), uiOutput("tex"),
             
             sidebarPanel(
               radioButtons("dist", "Selecione a distribuição:",
                            list("Normal" = "rnorm",
                                 "Uniforme" = "runif",
                                 "Exponencial" = "rexp")),
               
               uiOutput("min"), uiOutput("max"), uiOutput("med"), uiOutput("dp"), uiOutput("lamb"),
               sliderInput("n", "Tamanho da amostra", min = 1, max = 1000, value = 10),
               
               
               
               sliderInput("N",
                           "Número de amostras",
                           min = 10,
                           max = 500,
                           step = 10,
                           value = 30,
                           ticks = F,
                           animate=list(interval=500,loop=F))
               
               
             ),
             
             
             mainPanel(
               tabsetPanel(type = "tabs", 
                           tabPanel("Gráfico - Média", 
                                    plotlyOutput("plot1"),
                                    plotlyOutput("plot2")), 
                           tabPanel("Gráfico-Mediana", div(textOutput("tex3"), align = "center"),
                                    plotlyOutput("plot3")),
                           tabPanel("Tabela", tableOutput("tab"), div(textOutput("tex2"), align = "center")))
             )
             
             
             
  ))


