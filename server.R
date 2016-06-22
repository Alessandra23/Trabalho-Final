library(plotly)
require(ggplot2)
library(shinythemes)


shinyServer(function(input, output){
  
  output$tex1 <- renderText({ 
    "O Teorema Central do Limite diz que..."
  })
  
  
  output$med = renderUI({
    if (input$dist == "rnorm"){sliderInput("med", "Média", min = -50, max = 50, value = 0)}
  })
  output$dp = renderUI({
    if(input$dist == "rnorm"){sliderInput("dp", "Desvio padrão", min = 1, max = 40, value = 1)}
  })
  output$min = renderUI({
    if (input$dist == "runif"){sliderInput("min","Minimo", min = -20, max = 20,value = 0)}
  })
  output$max = renderUI({
    if (input$dist == "runif"){sliderInput("max", "Maximo", value = 2, min = 0, max = 20)}
  })
  
 
  f1 <- function(dist, n, med, dp, min, max){
    
    val <- NULL
    
    if(dist == "rnorm"){
      med <- input$med 
      dp <- input$dp
      n <- input$n
      val <- rnorm(n, med, dp)
    } else if(dist == "runif"){
      min <- input$min
      max <- input$max
      n <- input$n
      val <- runif(n, min, max) 
    }
    return(val)
  } # Fim da função 1
  
  
  rep_f1 <- repeatable(f1)
  
  pri <- reactive({
    n <- input$n
    return(rep_f1(input$dist, n, input$med, input$dp, input$min, input$max))
  }) 
  
  
  
  
  amostra <- reactive({
    Dis <- pri()
    N <- input$N
    n <- input$n
    return(replicate(N, sample(Dis, n, replace = T)))
  }) 
  
  
  # Gráfico 1
  
  output$plot1 <- renderPlotly({
    nome_dist <- switch (input$dist,
                         rnorm = "Distribuição Normal",
                         runif = "Distribuição Uniforme"
    )
    
    Dis <- pri()
    mDist <- mean(Dis)
    dpDist <- sd(Dis)
    
    Mi <- NULL
    Ma <- NULL
    erro <- F
    
    if(input$dist == "runif"){
      Mi <- input$min
      Ma <- input$max
      if(Mi > Ma){
        erro <- T
      }
    }
    
    if(erro){
      
      plot(0,0,type = 'n', xlab = " ", ylab = " ")
      text(0,0,"ERRO : O limite inferior é maior que o superior.", col = "red")
      
    } else {
      
      Df <- data.frame(x = Dis)
      library(plotly)
      g <- ggplot(Df, aes(x = x)) +
        geom_histogram(aes(y = ..density..), binwidth = density(Df$x)$bw)+
        geom_density(fill = "red", alpha = 0.2) +
        xlab(" ") + ylab(" ") + 
        ggtitle(" ")
      p <-  ggplotly(g) ; p
      
    }
    
  }) # Fim do gráfico 1  
  
  
  # Gráfico 2
  
  output$plot2 <- renderPlotly({
    
    Mi <- NULL
    Ma <- NULL
    erro <- F
    
    if(input$dist == "Uniforme"){
      Mi <- input$min
      Ma <- input$max
      if(Mi > Ma){
        erro <- T
      }
    }
    
    if(erro) 
      return
    else{
      
      nome_dist <- switch(input$dist,
                          rnorm = "Distribuição Normal",
                          runif = "Distribuição Uniforme")
      N <- input$N
      n <- input$n
     
      Dis <- pri()
      mDist <- mean(Dis)
      dpDist <- sd(Dis)
      medis <- colMeans(amostra())
      
      med_amost <- mean(medis)
      dp_amost <- sd(medis)
      
      Df2 <- data.frame(x = medis)
      library(plotly)
      ggplot(Df2, aes(x = x)) +
        geom_histogram(aes(y = ..density..), binwidth = density(Df2$x)$bw)+
        geom_density(fill = "red", alpha = 0.2) +
        xlab(" ") + ylab(" ") +
        ggtitle(" ")
      ggplotly()
      
    }
    
    
  }) # Fim do gráfico 2
  
  
  
}) # Fim da seção
