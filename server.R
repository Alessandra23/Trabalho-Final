library(plotly)
require(ggplot2)
library(shinythemes)
library(gridExtra)

options(encoding = 'UTF-8')


shinyServer(function(input, output, session){
  
  
  output$tex <- renderUI({
    withMathJax(sprintf("O Teorema Central do Limite fornece um importante resultado. Seja  $$X_1, ..., X_n$$ uma amostra aleatória de tamanho n de uma população com média e variância $$\\mu ,\\sigma^{2}$$ respectivamente. Então, à medida que n cresce, a distribuição das médias é aproximadamente $$N(\\mu,\\frac{\\sigma}{\\sqrt{n}})$$."))
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
  
  output$lamb = renderUI({
    if (input$dist == "rexp"){sliderInput("lamb", "Lambda", value = 1, min = 0, max = 30)}
  })

 
  
  # GrÃ¡fico 1
  
  
  
  output$plot1 <- renderPlotly({
    
    
    if (input$dist == "rnorm"){
      val <- rnorm(input$n*input$N, input$med, input$dp)
    } else if (input$dist == "runif"){
      val <- runif(input$n*input$N, input$min, input$max)
    } else if (input$dist == "rexp"){
      val <- rexp(input$n*input$N, input$lamb)
    } 
    
    nome_dist <- switch(input$dist,
                        rexp = "Distribuição Exponencial", 
                        rnorm = "Distribuição Normal", 
                        runif = "Distribuição Uniforme") 
    
   
    Df <- data.frame(x = val)
    library(plotly)
    g <- ggplot(Df, aes(x = x)) +
      geom_histogram(aes(y = ..density..))+
      geom_density(fill = "red", alpha = 0.2) +
      xlab("x") + ylab(" ") +
      ggtitle(nome_dist)
    p <-  ggplotly(g) ; p
    
  })
  
  
  
  # GrÃ¡fico 2
  
  output$plot2 <- renderPlotly({
    
    
    if (input$dist == "rnorm"){
      val <- rnorm(input$n*input$N, input$med, input$dp)
    } else if (input$dist == "runif"){
      val <- runif(input$n*input$N, input$min, input$max)
    } else if (input$dist == "rexp"){
      val <- rexp(input$n*input$N, input$lamb)
    } 
    
  
    nome_dist <- switch(input$dist,
                        rexp = "Distribuição Exponencial", 
                        rnorm = "Distribuição Normal", 
                        runif = "Distribuição Uniforme") 
    
    n <- input$n
    N <- input$N
    amost <- matrix(val, n,N)
    
    med_amostral <- colMeans(amost)
    Df2 <- data.frame(x = med_amostral)
    library(plotly)
    ggplot(Df2, aes(x = x)) +
      geom_histogram(aes(y = ..density..))+
      geom_density(fill = "red", alpha = 0.2) +
      xlab("Médias amostrais") + ylab(" ") +
      ggtitle(paste("Distribuição das médias de",N, 
                    "amostras aleatórias de tamanho", n, 
                    "de uma", nome_dist))
    ggplotly()
    
    
      }) # Fim do grÃ¡fico 2
  
 
  output$tab <- renderTable({
    if (input$dist == "rnorm"){
      val <- rnorm(input$n*input$N, input$med, input$dp)
    } else if (input$dist == "runif"){
      val <- runif(input$n*input$N, input$min, input$max)
    } else if (input$dist == "rexp"){
      val <- rexp(input$n*input$N, input$lamb)
    } 
    
    n <- input$n
    N <- input$N
    amost <- matrix(val, n,N)
    Médias <- apply(amost, 2, mean)
    DP <- apply(amost, 2, sd)
    Medianas <- apply(amost, 2, median)
    tabela <- data.frame(Médias, DP, Medianas)
    tabela
    }) # Fim da tabela
  
  output$tex2 <- renderText({
    paste("A tabela  apresenta as médias, desvios-padrão e medianas das", input$N,"amostras.")
  })
  
  
  output$plot3 <- renderPlotly({
    
    
    if (input$dist == "rnorm"){
      val <- rnorm(input$n*input$N, input$med, input$dp)
    } else if (input$dist == "runif"){
      val <- runif(input$n*input$N, input$min, input$max)
    } else if (input$dist == "rexp"){
      val <- rexp(input$n*input$N, input$lamb)
    } 
    
    
    nome_dist <- switch(input$dist,
                        rexp = "Distribuição Exponencial", 
                        rnorm = "Distribuição Normal", 
                        runif = "Distribuição Uniforme") 
    
    n <- input$n
    N <- input$N
    amost <- matrix(val, n,N)
    
    mediana_amostral <- apply(amost, 2, median)
    
    Df2 <- data.frame(x = mediana_amostral)
    library(plotly)
    ggplot(Df2, aes(x = x)) +
      geom_histogram(aes(y = ..density..))+
      geom_density(fill = "red", alpha = 0.2) +
      xlab("Medianas amostrais") + ylab(" ") +
      ggtitle(paste("Distribuição das medianas de",N,
                    "amostras aleatórias de tamanho", n, 
                    "de uma", nome_dist, sep = " "))
    ggplotly()
    
    
  })
  
  
}) # Fim da seÃ§Ã£o