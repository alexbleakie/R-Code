library(shiny)
library(DT)
library(shinythemes)
####
#Created by Alex Bleakie   2018
#bleakie_8@hotmail.com
####
# Enjoy


ui <- fluidPage(theme = shinytheme("slate"),
                
            titlePanel("Table With Keystroke Arrows Left/Right to Move Rows"),

            tags$script(HTML({'var map = {37 : false, 39: false};
                               $(document).keydown(function(e){
                                    if(e.keyCode in map){
                                        map[e.keyCode] = true;
                                        Shiny.setInputValue("arrowTable",e.keyCode,{priority: "event"});
                                    }
                               }).keyup(function(e){

                                    if(e.keyCode in map){
                                        map[e.keyCode] = false;
                                    }

                               });'
            })),
            DTOutput('myTable')
            
)                                                                                                           


###############################################################################################
###############################################################################################


server <- function(input, output,session) {
              
          observeEvent(input$arrowTable,{
            if(is.null(input$myTable_rows_selected)){
             return(NULL) 
            }
            if(input$arrowTable==37){
              
              if(input$myTable_rows_selected==1){
                selectRows(proxyTableSelect,as.numeric(input$myTable_rows_selected))
              }else{
                
                selectRows(proxyTableSelect,as.numeric(input$myTable_rows_selected)-1) 
              }
              
              
            }else if(input$arrowTable==39){
              
                selectRows(proxyTableSelect,as.numeric(input$myTable_rows_selected)+1) 
              
              
            }
   
   
   
          })
  
        proxyTableSelect=dataTableProxy("myTable")
        
        output$myTable<-renderDT({
          
          datatable(iris,selection="single",filter="top",
                    options=list(scrollY="200",pageLength=10,lengthMenu=c(5,10,20,50),searchHighlight=TRUE,tabIndex=1))%>%
                    formatStyle(columns=colnames(iris),backgroundColor = c('lightgray'),color='black')
          
          
          
        })
  
  
}
##########################################################################################
##########################################################################################
##########################################################################################

shinyApp(ui = ui, server = server)
