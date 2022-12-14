# Do this every so often to get latest bslib stuff
# remotes::install_github("rstudio/bslib@dev")
# remotes::install_github("cpsievert/histoslider")
library(shiny)
library(bslib)
library(sass)
library(ggplot2)
library(plotly)
library(DT)
library(histoslider)
library(GGally)
library(viridis)


sidebar <- accordion(
  class = "accordion-flush",
  accordion_item(
    "Foo", icon = icon("globe"),
    histoslider::input_histoslider("foo", NULL, rnorm(100))
  ),
  accordion_item(
    "Bar", icon = icon("globe"),
    histoslider::input_histoslider("bar", NULL, rnorm(100))
  )
)

main <- card_grid(
  card_width = 1/2,
  # height = "500px",
  heights_equal = "row",
  navs_tab_card(
    title = "Card with Tabs for Parameters",
    height = "500px",
    full_screen = TRUE,
    stretch = TRUE,
    # placement = "below",
    nav(
      "Table",
      fluidRow(
        style = "height:100%",
        column(6, plotOutput("bars", height = "100%")),
        column(6, DT::dataTableOutput("dt2", height = "100%"))
      )
    ),
    #nav("plotly", plotlyOutput("plotly", height = "100%")),

    nav_menu(
      "Plots",
      nav("ggplot2", plotOutput("ggplot2", height = "100%")),
      nav("base", plotOutput("base", height = "100%")),
    )
  ),
  navs_pill_card(
    title = "Card with Tabs for Parameters",
    height = "500px",
    #full_screen = TRUE,
    stretch = TRUE,
    # placement = "below",
    nav(
      "Table",
      fluidRow(
        style = "height:100%",
        column(6, plotOutput("bars2", height = "100%")),
        column(6, DT::dataTableOutput("dt3", height = "100%"))
      )
    ),
    #nav("plotly", plotlyOutput("plotly", height = "100%")),
    nav_menu(
      "Plots",
      nav("ggplot2", plotOutput("ggplot22", height = "100%")),

      nav("base", plotOutput("base2", height = "100%")),
    )
  ),

  card(
    card_header("Some other table"),
    p("dfsljndflgndflgnfdl  algadfgh lfkdg lk;f aglhfd glkh fdglh fgdlkh fdgs;klh gfsd;hkl g;lkh dsfg;hkl glf;dksghl dfh gladfh l;kghal;dfh ;lkfdha ghldfkaghl;kh"),
    #card_plot_output("bars"),
    card_body(
      stretch = TRUE,
      DT::dataTableOutput("dt", height = "100%")
      #card_body(
      #  stretch = TRUE,
      #  dataTableOutput("dt2", height = "100%")
      #)

    ),
  )
)

ui <- page_navbar(
  theme = bs_theme(),
  title = tags$span(
    tags$img(
      src = "shinyhex-white-test.png",
      style = "width:46px;height:auto;margin-right:24px;"
    ),
    "Shiny Demo"
  ),
  nav(
    "Sidebar Example (HTML)",
    layout_sidebar(sidebar, main)
  ),
  nav("Value Boxes (R)", "Coming soon")
)


server <- function(input, output) {

  p <- ggparcoord(
    iris,
    columns = 1:4, groupColumn = 5, order = "anyClass",
    showPoints = TRUE,
    alphaLines = 0.3
  ) +
    scale_color_viridis(discrete = TRUE) +
    theme_bw(base_size = 16)

  output$base <- renderPlot({
    hist(rnorm(100))
  })
  output$base2 <- renderPlot({
    hist(rnorm(100))
  })

  output$bars <- renderPlot({
    hist(rnorm(100))
  })

  output$bars2 <- renderPlot({
    hist(rnorm(100))
  })


  output$ggplot2 <- renderPlot(p)

  output$ggplot22 <- renderPlot(p)

  output$plotly <- renderPlotly({
    #info <- getCurrentOutputInfo()
    #plotly::ggplotly(p, height = info$height(), width = info$width())
    plot_ly(x = 1:10, y = 1:10)
  })

  output$dt <- DT::renderDataTable({
    datatable(mtcars, fillContainer = TRUE, options = list(dom = 't'))

  })

  output$dt2 <- DT::renderDataTable({
    info <- getCurrentOutputInfo()
    large <- isTRUE(info$height() > 600)
    datatable(
      ggplot2::economics, fillContainer = TRUE,
      options = if (large) list() else list(dom = "t")
    )
  })

  output$dt3 <- DT::renderDataTable({
    datatable(ggplot2::economics, fillContainer = TRUE, options = list(dom = 't'))

  })

}

shinyApp(ui, server)
