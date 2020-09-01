
library(shiny)

select_opts = list('category1'=letters[1:3], 'category2'=LETTERS[1:2])
select_opts2 = list('category3'=letters[4:6], 'category4'=LETTERS[3:4])

ui <- fluidPage(
    titlePanel("title"),
    sidebarLayout(
        sidebarPanel(
            sliderInput(inputId = "slider", label = "slider",
                min = 0.1, max = 10, value = 1),
            numericInput(inputId = "numeric", label = "numeric",
                min = 0, max = 100, value = 0.5),
            selectizeInput('select', label='select', selected='a',
                choices=select_opts, multiple=TRUE, options=list(maxItems=3)),
            actionButton('button', 'modify select')
        ),
        mainPanel(
            plotOutput(outputId = "plot"),
            h3(HTML("thing, "), textOutput(outputId = "text"))
        )
    )
)

server <- function(input, output, session) {

    output$plot <- renderPlot({
        plot(input$slider:input$numeric, input$numeric:input$slider)
    })
    output$text <- renderText(input$select)

    observeEvent(input$button, {
        updateSelectizeInput(session, 'select',
            choices=select_opts2,
            selected=c('d', 'f', 'C'),
            options=list(maxItems=3))
    })
}

shinyApp(ui = ui, server = server)
