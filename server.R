shinyServer(
  function(input, output, session){
    
    RDist<- reactive({
      dist <- switch(input$dist,
                     norm = rnorm,
                     binom = rbinom,
                     gama = rgamma,
                     rnorm)
      
      dist(input$n, ...)
    })
    
    output$plot1 <- renderPlot({
      
      Tdist <- input$dist
      Tamos <- input$tsample
      Namos <- input$namostra
      MedA <- numeric(Tamos)
      Eixox <- c(1:Tamos)
      
      if(Tdist == "Normal"){
        for(i in 1:Namos){
          vetA <- rnorm(Tamos, mean = as.numeric(input$med), 
                        sd = as.numeric(input$dp))
          MedA[i] <- mean(vetA)
        }
        
      }else{
        if(Tdist == "Exponencial"){
          for(i in 1:Namos){
            vetA <- rexp(Tamos, rate = 1/as.numeric(input$lambda))
            MedA[i] <- mean(vetA)
          }
          
        }else{
          for(i in 1:Namos){
            vetA <- rbinom(Tamos, as.numeric(input$n), as.numeric(input$p))
            MedA[i] <- mean(vetA)
          }
          
        }
      }
      
      plot(Eixox,MedA)
      #hist(MedA, col = "blue", main = "Histograma")
    })
    
#----------------------------------------------------------------------------------------------------------#
# Plotar o segundo gráfico
    
    output$plot2 <- renderPlot({
      
      
    })    
    
#----------------------------------------------------------------------------------------------------------#
# Plotar o terceiro gráfico    
    
    output$plot3 <- renderPlot({
      
      
    })  

#----------------------------------------------------------------------------------------------------------#
# Gerar a tabela
    
    output$table <- renderTable({
      
    })
    
    
})