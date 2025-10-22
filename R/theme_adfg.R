#' Format a Graph to ADF&G Publication Standards
#'
#' This function can be added to a ggplot to format the graph
#' to ADF&G formatting standards.
#' @title Format a Graph to ADF&G Publication Standards
#' @description \code{theme_adfg} creates a ggplot theme consistent for ADF&G publications.
#'
#' @param font_size Size in points for font. Default is 18.
#' @param font_family Sets which font family you want to use. Default is
#' Times New Roman.
#'
#' @return The output returned will be either an object of \code{theme_adfg()},
#'
#' @import extrafont
#' @importFrom ggplot2 ggplot theme_grey theme element_blank
#' element_rect element_text element_line
#'
#' @examples
#' library(ggplot2)
#' ggplot(mtcars, aes(x = wt, y = mpg)) + geom_point() + theme_adfg()
#'
#' @export
theme_adfg = function(font_size = 18,
                      font_family = "Times New Roman", #"sans", #times new roman is recommended
                      # JTP comments: rel_small, rel_tiny need to be renamed as they're not intuitive. A good argument
                      #               name should be self explanatory, not require code comments
                      rel_small = 0.86 * font_size/font_size, #font size for the legend
                      rel_tiny = 0.79 * font_size/font_size, #font size for the caption
                      rel_large = 1.15 * font_size/font_size, #font size for the title
                      legend.position.set= c(0.8, 0.9), #"left", "right", "bottom", "top";
                      # sets where the legend is placed inside the plot panel
                      legend.justification = "center", #the anchor point where the legend is set
                       # JTP comments: legend.justification should be renamed. Don't use arguments that are
                       #               the same name as an existing argument/function/parameter.
                       #               Come to think of it, I'm not sure what this adds since it already exists
                       #               in regular ggplot so we don't need to add it here I don't think.
                       strip.placement = "outside", #where labels are placed relative to the plot panels (ex: "outside"; "inside")
                       # JTP comments: Same comments as above, rename or exclude.
                       strip.text.y = element_text(angle = -90), #how the y-axis are drawn. Here, it is at a 90 degree angle
                       box = TRUE #if box = TRUE, black rectangle border
                       # JTP comments: Changed box to TRUE rather than "yes". Use T/F instead so that "Yes" or "YES" doesn't confuse
)
{

  ### cowplot STYLE only changed font to serif and legend position
  half_line <- font_size / 2
  qtr_line <- font_size / 4
  small_size <- rel_small * font_size

  #conditional do-I-want-a-box?
  plot_background_box <- if(box == TRUE) {
    element_rect(color = "black", fill = "white", linewidth = 0.5)
  } else {
    element_rect(fill="white", color = NA)
  }

  #the main theme adjustment
  theme_grey(base_size = font_size, base_family = font_family) %+replace%
    theme(
      strip.background = element_rect(fill = NA, color = NA), #AGR added
      #linewidth = line_size, #Agr added 8/4/25, untested
      line = element_line(
        color = "black",
       # size = line_size, obsolete, use linewidth instead
        linetype = 1,
        lineend = "butt"
      ),
      rect = element_rect(
        fill = NA,
        color = NA,
        #size = line_size, depreciated
        linetype = 1
      ),
      text = element_text(
        family = font_family,
        face = "plain",
        color = "black",
        size = font_size,
        hjust = 0.5,
        vjust = 0.5,
        angle = 0,
        lineheight = 0.9,
        margin = margin(),
        debug = FALSE
      ),
      axis.line = element_line(
        color = "black",
        #size = line_size, #agr turned off
        lineend = "square"
      ),
      axis.line.x = NULL,
      axis.line.y = NULL,
      axis.text = element_text(color = "black",
                               size = small_size),
      axis.text.x = element_text(margin = margin(t = small_size / 4),
                                 vjust = 1),
      axis.text.x.top = element_text(margin = margin(b = small_size / 4),
                                     vjust = 0),
      axis.text.y = element_text(margin = margin(r = small_size / 4),
                                 hjust = 1),
      axis.text.y.right = element_text(margin = margin(l = small_size / 4),
                                       hjust = 0),
      axis.ticks = element_line(color = "black",
                                #size = line_size
                                ),
      axis.ticks.length = unit(qtr_line, "pt"),
      axis.title.x = element_text(margin = margin(t = qtr_line), vjust = -0.75),
      axis.title.x.top = element_text(margin = margin(b = qtr_line), vjust = -0.75),
      axis.title.y = element_text(
        angle = 90,
        margin = margin(r = qtr_line),
        vjust = 3
      ),
      axis.title.y.right = element_text(
        angle = -90,
        margin = margin(l = qtr_line),
        vjust = 0
      ),
      legend.background = element_blank(),
      legend.spacing = unit(font_size, "pt"),
      legend.spacing.x = NULL,
      legend.spacing.y = NULL,
      legend.margin = margin(0, 0, 0, 0),
      legend.key = element_blank(),
      legend.key.size = unit(1.1 * font_size, "pt"),
      legend.key.height = NULL,
      legend.key.width = NULL,
      legend.text = element_text(size = rel(rel_small)),
      legend.text.align = NULL,
      legend.title = element_text(hjust = 0), #edit this to correct for the legend.title.align depreciating, if needed
      #legend.title.align = 0.5, DEPRECATED!
      # legend.position = "bottom",
      # legend.position = legend.position, DEPRECATED
      #legend.position.inside = legend.position, #correcting for depreciation; moving this elsewhere
      legend.direction = NULL,
      legend.justification = legend.justification,
      legend.box = NULL,
      legend.box.margin = margin(0, 0, 0, 0),
      legend.box.background = element_blank(),
      legend.box.spacing = unit(font_size, "pt"),
      panel.background = element_blank(),
      panel.border = element_blank(),
      panel.grid = element_blank(),
      panel.grid.major = NULL,
      panel.grid.minor = NULL,
      panel.grid.major.x = NULL,
      panel.grid.major.y = NULL,
      panel.grid.minor.x = NULL,
      panel.grid.minor.y = NULL,
      panel.spacing = unit(half_line, "pt"),
      panel.spacing.x = NULL,
      panel.spacing.y = NULL,
      panel.ontop = FALSE,
      # strip.background = strip.background, idk what this was doing AGR
      strip.text = element_text(
        size = rel(rel_small),
        margin = margin(qtr_line, qtr_line, qtr_line, qtr_line)
      ),
      strip.text.x = NULL,
      strip.text.y = strip.text.y,
      strip.placement = strip.placement,# changed from "inside"
      strip.placement.x = NULL,
      strip.placement.y = NULL,
      strip.switch.pad.grid = unit(qtr_line, "pt"),
      strip.switch.pad.wrap = unit(qtr_line, "pt"),
      #plot.background = element_blank(),
      plot.background = plot_background_box, #agr added
      plot.title = element_text(
        face = "bold",
        size = rel(rel_large),
        hjust = 0,
        vjust = 1,
        margin = margin(b = half_line)
      ),
      plot.subtitle = element_text(
        size = rel(rel_small),
        hjust = 0,
        vjust = 1,
        margin = margin(b = half_line)
      ),
      plot.caption = element_text(
        size = rel(rel_tiny),
        hjust = 1,
        vjust = 1,
        margin = margin(t = half_line)
      ),
      plot.tag = element_text(
        face = "bold",
        hjust = 0,
        vjust = 0.7
      ),
      plot.tag.position = c(0, 1),
      plot.margin = margin(20, 20, 20, 25), #was half_line x 4
      complete = TRUE,
      legend.position = "inside",
      legend.position.inside = legend.position.set #agr changed
    )

}


