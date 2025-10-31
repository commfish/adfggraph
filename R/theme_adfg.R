#' Format a Graph to ADF&G Publication Standards
#'
#' This function can be added to a ggplot to format the graph
#' to ADF&G formatting standards.
#' @title Format a Graph to ADF&G Publication Standards
#' @description \code{theme_adfg} creates a ggplot theme that is consistent with ADF&G publication guidelines.
#'
#' @param font_size Size in points for font. Default is 18.
#' @param font_family Sets which font family you want to use. Default is
#' Times New Roman.
#' @param box TRUE/FALSE selection for whether to outline the plot in a box
#' @param ... Other arguments that are standard to ggplot \code{theme()}
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
                      font_family = "Times New Roman", #"sans", #times new roman is recommended by the ADF&G publication guidelines
                      font_size_title = 1.15 , #font size for the title
                      font_size_legend = 0.86, #font size for the legend
                      font_size_caption = 0.79, #font size for the caption
                      # JTP comments: The code before didn't rely on font size so that needs to be set.
                      #               It multiplied then divided by font_size.... #AGR flag
                      # JTP 10/29: Renamed variables. Not convinced we need 3 parameters for font sizing
                      #            but it's not the worst thing. Suggest keeping as is for now and deciding as a group.
                      #            I'm guessing the best solution will be to hard code these (not variables) but allow people to
                      #            manually change these as they line.
                       box = TRUE, #if box = TRUE, black rectangle border
                       base_line_size = font_size / 22, #JTP added based on code from ggplot
                      # JTP 10/29: Will need to decide as a group if having a variable to change the line size is important
                      ...
)
{

  ### cowplot STYLE only changed font to serif and legend position
  half_line <- font_size / 2
  qtr_line <- font_size / 4
  small_size <- font_size_legend * font_size

  #conditional do-I-want-a-box?
  plot_background_box <- if(box == TRUE) {
    element_rect(color = "black", fill = "white", linewidth = 0.5)
  } else {
    element_rect(fill="white", color = NA)
  }

  on.exit({
    if (!font_family %in% extrafont::fonts()) {
      message(
        sprintf("\nFont '%s' not found. \nPlease run extrafont::font_import() once to register system fonts.
                \nNote that this will take several minutes to install.\n", font_family))
    }
  }, add = TRUE)

  #the main theme adjustment
  default_adfg_theme <- theme_gray(base_size = font_size, base_family = font_family) + #%+replace%
    theme(
      strip.background = element_rect(fill = NA, color = NA),
      line = element_line(
        color = "black",
        linewidth = base_line_size
      ),
      rect = element_rect(
        fill = NA, color = NA,
        linewidth = base_line_size
      ),
      text = element_text(
        family = font_family,
        color = "black",
        size = font_size
      ),
      axis.line = element_line(
        color = "black",
        lineend = "square"
      ),

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
                                ),
      axis.ticks.length = unit(qtr_line, "pt"), #JTP: explore how this is different than default rel(0.5)
      axis.title.x = element_text(margin = margin(t = qtr_line), vjust = -0.75), #default vjust = 1
      axis.title.x.top = element_text(margin = margin(b = qtr_line), vjust = -0.75),
      axis.title.y = element_text(
        angle = 90,
        margin = margin(r = qtr_line),
        vjust = 3
      ),
      axis.title.y.right = element_text(
        margin = margin(l = qtr_line),
        vjust = 0 # default vjust = 1
      ),
      #legend.background = element_blank(), # I think that this does nothing #agr test off
      legend.spacing = unit(font_size, "pt"), # default rel(2)
      legend.margin = margin(0, 0, 0, 0),
      legend.key = element_blank(), # default is NULL
      legend.key.size = unit(1.1 * font_size, "pt"),
      legend.text = element_text(size = rel(font_size_legend)),
      legend.text.align = NULL,
      legend.title = element_text(hjust = 0), #edit this to correct for the legend.title.align depreciating, if needed
      legend.direction = NULL,
      legend.box.margin = margin(0, 0, 0, 0),
      legend.box.spacing = unit(font_size, "pt"),
      panel.background = element_blank(),
      panel.grid = element_blank(),
      panel.grid.major = NULL,
      panel.grid.minor = NULL,
      panel.grid.major.x = NULL,
      panel.grid.major.y = NULL,
      panel.grid.minor.x = NULL,
      panel.grid.minor.y = NULL,
      panel.spacing = unit(half_line, "pt"),
      strip.text = element_text(
        size = rel(font_size_legend),
        margin = margin(qtr_line, qtr_line, qtr_line, qtr_line)
      ),
      strip.switch.pad.grid = unit(qtr_line, "pt"),
      strip.switch.pad.wrap = unit(qtr_line, "pt"),
      plot.background = plot_background_box,
      plot.title = element_text(
        face = "bold",
        size = rel(font_size_title),
       # margin = margin(b = half_line) # I think this changes nothing as it's the default but not sure #agr test off
      ),
      plot.subtitle = element_text(
        size = rel(font_size_legend),
        #margin = margin(b = half_line) # I think this changes nothing as it's the default but not sure #agr test off
      ),
      plot.caption = element_text(
        size = rel(font_size_caption),
        #margin = margin(t = half_line) # I think this changes nothing as it's the default but not sure #agr test off
      ),
      plot.tag = element_text(
        face = "bold",
        hjust = 0,
        vjust = 0.7 #defaults for this are 0.5, 0.5
      ),
      #plot.tag.position = c(0, 1), # default is topleft which I believe is the exact same as this #agr test off
      plot.margin = margin(20, 20, 20, 25) #was half_line x 4
    )

  # Allow for users to supply custom ggplot theme modifications
  user_theme <- do.call(ggplot2::theme, list(...))

  # Combine the default and custom modifications
  default_adfg_theme + user_theme

}

