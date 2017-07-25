sphereAddin <- function(inputValue1, inputValue2) {

  library(shiny)
  library(miniUI)
  
  mc_connect("34.210.234.34")
  
  sphere <- function(
    radius = 15,           # Size of the sphere
    blockid = 20,          # Block id (1 = stone; 2 = grass; 20 = glass)
    styleid = 0,           # Block style id
    fill = FALSE,          # Set to true if you want a solid sphere
    offset = c(0, 0, 0),   # offset from the sphere origin
    pos = getPlayerPos(tail(getPlayerIds(), 1), tile = TRUE), # sphere origin
    xlim, ylim, zlim       # plotting limits for sphere truncation
  ){
    
    # Create a stack of rings
    rings <- array(0, c(x = 2 * radius + 1, y = radius + 1, z = 2 * radius + 1))
    for(y in 0:radius){
      for(theta in seq(0, 2 * pi, len = 10 * radius)){
        xind <- sqrt(radius ^ 2 - y ^ 2) * cos(theta) + radius
        zind <- sqrt(radius ^ 2 - y ^ 2) * sin(theta) + radius
        rings[round(xind) + 1, y + 1, round(zind) + 1] <- 1
      }
    }
    
    # Create a solid dome
    fillrow <- function(x){
      ind <- which(x == 1)
      if(length(ind) == 0) ind <- 0 
      rng <- range(ind)
      idx <- seq_along(x)
      fill <- idx >= min(rng) & idx <= max(rng)
      fill * 1
    }
    dome <- aperm(apply(rings, 1:2, fillrow), c(2, 3, 1))
    
    # Hollow out the dome
    if(!fill){
      for(y in 1:radius){
        disk <- (dome[, y, ] - dome[, y + 1, ]) == 1
        ring <- rings[, y, ] == 1
        dome[, y, ] <- (disk | ring) * 1
      }
    }
    
    # Create a sphere
    yind <- abs(seq(-radius, radius)) + 1
    sphere <- dome[, yind, ,drop = FALSE]
    
    # Define plot dimensions  
    if(missing(xlim)) xlim <- c(-radius, radius)
    if(missing(ylim)) ylim <- c(-radius, radius)
    if(missing(zlim)) zlim <- c(-radius, radius)
    xx <- seq(xlim[1], xlim[2]) + radius + 1
    yy <- seq(ylim[1], ylim[2]) + radius + 1
    zz <- seq(zlim[1], zlim[2]) + radius + 1
    
    # Place blocks to create the sphere
    p <- pos + offset - c(radius + 1, radius + 1, radius + 1)
    for(x in xx){
      for(y in yy){
        for(z in zz){
          if(sphere[x, y, z] == 1){
            setBlock(x + p[1], y + p[2], z + p[3], blockid, styleid)
          }
        }
      }
    }
    pos
  }
  
    
  ui <- miniPage(
    gadgetTitleBar("Make a sphere"),
    miniTabstripPanel(
      miniTabPanel("Build", icon = icon("dot-circle-o"), 
        miniContentPanel(
          scrollable = FALSE,
          fillCol(
            fillRow(
              numericInput("blockid", "Block ID", 20, 0),
              selectInput("styleid", "Style ID", 0:15, 0)
            ),
            fillRow(
              numericInput("radius", "Radius", 15, 1),
              selectInput("fill", "Fill Type", c("Hollow", "Solid"), "Hollow")
            ),
            fillRow(
              numericInput("offx", "Offset (X)", 0),
              numericInput("offy", "Offset (Y)", 0),
              numericInput("offz", "Offset (Z)", 0)
            ),
            fillRow(
              actionButton("build", "Build Sphere", width = "100%", style="background-color: #D3D3D3")
            )
          )
        )
      ),
      miniTabPanel("Position", icon = icon("arrows-alt"), 
        miniContentPanel(
          fillCol(
            fillRow(
              numericInput("posx", "Origin (X)", NULL),
              numericInput("posy", "Origin (Y)", NULL),
              numericInput("posz", "Origin (Z)", NULL)
            )
          )
        )
      ),
      miniTabPanel("Truncate", icon = icon("scissors"), 
        miniContentPanel(
          fillCol(
            fillRow(
              numericInput("xlimhi", "X (hi)", NULL),
              numericInput("xlimlo", "X (lo)", NULL)
            ),
            fillRow(
              numericInput("ylimhi", "Y (hi)", NULL),
              numericInput("ylimlo", "Y (lo)", NULL)
            ),
            fillRow(
              numericInput("zlimhi", "Z (hi)", NULL),
              numericInput("zlimlo", "Z (lo)", NULL)
            )
          )
        )
      )
    )
  )
  
  
  server <- function(input, output, session) {
    
    fill <- reactive({
      input$fill == "Solid"
    })
    
    offset <- reactive({
      c(input$offx, input$offy, input$offz)
    })
    
    observeEvent(input$build, {
      sphere(input$radius, input$blockid, input$styleid, fill(), offset())
    })

    observeEvent(input$done, {
      returnValue <- offset()
      stopApp(returnValue)
    })
    
    observeEvent(input$cancel, {
      invisible(stopApp())
    })
    
  }
  
  runGadget(ui, server, viewer = dialogViewer("Make a sphere"))
}
