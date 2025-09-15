#' Format a Graph to ADF&G Publication Standards
#'
#' This function can be added to a ggplot to format the graph
#' to ADF&G formatting standards.
#'
#' @export
theme_adfg = function (font_size = 18,
                         font_family = "Times New Roman", #"sans", #times new roman is recommended
                         #line_size = 0.5,
                         rel_small = 0.86 * font_size/font_size,
                         rel_tiny = 0.79 * font_size/font_size,
                         rel_large = 1.15 * font_size/font_size,
                         legend.position.set= c(0.8,0.9), #"left", "right", "bottom", "top"
                         legend.justification = c("center"),
                         strip.background = element_rect(fill = "grey80", color=NA),
                         strip.placement = "outside",
                         strip.text.y = element_text(angle = -90),
                         box = "yes" #if box = "yes", black rectangle boarder

)
{

  ### cowplot STYLE only changed font to serif and legend position
  half_line <- font_size / 2
  small_size <- rel_small * font_size

  #conditional do-I-want-a-box?
  plot_background_box <- if (box == "yes") {
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
      axis.ticks.length = unit(half_line / 2,
                               "pt"),
      axis.title.x = element_text(margin = margin(t = half_line / 2),
                                  vjust = -0.75),
      axis.title.x.top = element_text(margin = margin(b = half_line / 2),
                                      vjust = -0.75),
      axis.title.y = element_text(
        angle = 90,
        margin = margin(r = half_line /
                          2),
        vjust = 3
      ),
      axis.title.y.right = element_text(
        angle = -90,
        margin = margin(l = half_line / 2),
        vjust = 0
      ),
      legend.background = element_blank(),
      legend.spacing = unit(font_size, "pt"),
      legend.spacing.x = NULL,
      legend.spacing.y = NULL,
      legend.margin = margin(0,
                             0, 0, 0),
      legend.key = element_blank(),
      legend.key.size = unit(1.1 *
                               font_size, "pt"),
      legend.key.height = NULL,
      legend.key.width = NULL,
      legend.text = element_text(size = rel(rel_small)),
      legend.text.align = NULL,
      legend.title = element_text(hjust = 0), #edit this to correct for the legend.title.align depreciating, if needed
      #legend.title.align = 0.5, DEPRECIATED!
      # legend.position = "bottom",
      # legend.position = legend.position, DEPRECIATED
      #legend.position.inside = legend.position, #correcting for depreciation; moving this elsewhere
      legend.direction = NULL,
      legend.justification = legend.justification,
      legend.box = NULL,
      legend.box.margin = margin(0,
                                 0, 0, 0),
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
        margin = margin(half_line / 2, half_line /
                          2, half_line / 2,
                        half_line / 2)
      ),
      strip.text.x = NULL,
      strip.text.y = strip.text.y,
      strip.placement = strip.placement,# changed from "inside"
      strip.placement.x = NULL,
      strip.placement.y = NULL,
      strip.switch.pad.grid = unit(half_line / 2,
                                   "pt"),
      strip.switch.pad.wrap = unit(half_line / 2,
                                   "pt"),
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
      plot.margin = margin(20,
                           20, 20, 25), #was half_line x 4
      complete = TRUE,
      legend.position = "inside",
      legend.position.inside = legend.position.set #agr changed
    )

}

