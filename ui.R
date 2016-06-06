shinyUI(
  pageWithSidebar(
    headerPanel("Teorema do Limite Central"),
    
    sidebarPanel(
      selectInput("dist", "Selecione a distribuicao",
                  choices = c("Normal", "Gama", "Uniforme")), 
      sliderInput("tsample","Tamanho da amostra", 
                  min = 1, max = 1000, value = 10, step = 10), 
      sliderInput("namostra", "Numero de amostras",
                  min = 1, max = 1000, value = 10, step = 10), 
      
      uiOutput("med"), 
      uiOutput("dp"),
      uiOutput("min"),
      uiOutput("max"),
      
      conditionalPanel(condition = "input.dist == 'Normal'", 
                       textInput("med", "Media da distribuicao", 5),
                       textInput("dp", "Desvio padrao da distribuicao", 2)),
      conditionalPanel(condition = "input.dist == 'Gama'",
                       textInput("lambda","Parametro de escala", 1)),
      conditionalPanel(condition = "input.dist == 'Uniforme'",
                       textInput("n", "Numero de tentativas",5),
                       textInput("p", "Parametro p da distribuicao",0.5))
    ),
    
    mainPanel(
      tabsetPanel(type = "tabs", 
                  tabPanel("Densidade", plotOutput("plot1")), 
                  tabPanel("Distribuicao das amostras", plotOutput("plot2")), 
                  tabPanel("Distribuicao amostral das medias", plotOutput("plot3")), 
                  tabPanel("Tabela", tableOutput("table"))
      )
)))