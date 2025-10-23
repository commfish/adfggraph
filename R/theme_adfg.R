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
                      font_family = "Times New Roman", #"sans", #times new roman is recommended
                      # JTP comments: rel_small, rel_tiny need to be renamed as they're not intuitive. A good argument
                      #               name should be self explanatory, not require code comments
                      rel_small = 0.86, #font size for the legend
                      rel_tiny = 0.79, #font size for the caption
                      rel_large = 1.15 , #font size for the title
                      # JTP comments: The code before didn't rely on font size so that needs to be set.
                      #               It multiplied then divided by font_size....
                      #legend.position.set = c(0.8, 0.9), #"left", "right", "bottom", "top";
                      # sets where the legend is placed inside the plot panel
                      #legend.justification = "center", #the anchor point where the legend is set
                       # JTP comments: legend.justification should be renamed. Don't use arguments that are
                       #               the same name as an existing argument/function/parameter.
                       #               Come to think of it, I'm not sure what this adds since it already exists
                       #               in regular ggplot so we don't need to add it here I don't think.
                       #strip.placement = "outside", #where labels are placed relative to the plot panels (ex: "outside"; "inside")
                       # JTP comments: Same comments as above, rename or exclude.
                       #strip.text.y = element_text(angle = -90), #how the y-axis are drawn. Here, it is at a 90 degree angle
                       # JTP: the strip.text.y was already defaulted to -90. It can still be modified.
                       box = TRUE, #if box = TRUE, black rectangle border
                       base_line_size = font_size / 22, #JTP added based on code from ggplot
                       # JTP comments: Changed box to TRUE rather than "yes". Use T/F instead so that "Yes" or "YES" doesn't confuse
                      ...
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

  on.exit({
    if (!font_family %in% extrafont::fonts()) {
      # message("\nFont 'Times New Roman' not found.\nPlease run: extrafont::font_import()
      #         \nNote that this will take several minutes to install\n")
      message(
        sprintf("\nFont '%s' not found. \nPlease run extrafont::font_import() once to register system fonts.
                \nNote that this will take several minutes to install.\n", font_family))
    }
  }, add = TRUE)

  #the main theme adjustment
  default_adfg_theme <- theme_gray(base_size = font_size, base_family = font_family) + #%+replace%
    theme(
      strip.background = element_rect(fill = NA, color = NA), #AGR added
      #linewidth = line_size, #Agr added 8/4/25, untested
      line = element_line(
        color = "black",
       # size = line_size, obsolete, use linewidth instead
        linewidth = base_line_size,
        #linetype = 1,
        #lineend = "butt" # FLAG for deletion. Redundant to theme_gray()
      ),
      rect = element_rect(
        fill = NA, color = NA,
        linewidth = base_line_size,
      ),
      text = element_text(
        family = font_family,
        color = "black",
        size = font_size,
        #hjust = 0.5, # FLAG for deletion. All the following are redundant to theme_gray()
        #vjust = 0.5,
        #angle = 0,
        #lineheight = 0.9,
        #margin = margin(),
        #debug = FALSE
      ),
      axis.line = element_line(
        color = "black",
        #size = line_size, #agr turned off
        lineend = "square"
      ),
      #axis.line.x = NULL, # FLAG for deletion. All the following are redundant to theme_gray()
      #axis.line.y = NULL, # FLAG for deletion. All the following are redundant to theme_gray()
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
      axis.ticks.length = unit(qtr_line, "pt"), #JTP: explore how this is different than default rel(0.5)
      axis.title.x = element_text(margin = margin(t = qtr_line), vjust = -0.75), #default vjust = 1
      axis.title.x.top = element_text(margin = margin(b = qtr_line), vjust = -0.75),
      axis.title.y = element_text(
        angle = 90,
        margin = margin(r = qtr_line),
        vjust = 3
      ),
      axis.title.y.right = element_text(
        #angle = -90, # FLAG for deletion. redundant to theme_gray()
        margin = margin(l = qtr_line),
        vjust = 0 # default vjust = 1
      ),
      legend.background = element_blank(), # I think that this does nothing
      legend.spacing = unit(font_size, "pt"), # default rel(2)
      #legend.spacing.x = NULL, # FLAG for deletion. redundant to theme_gray()
      #legend.spacing.y = NULL, # FLAG for deletion. redundant to theme_gray()
      legend.margin = margin(0, 0, 0, 0),
      legend.key = element_blank(), # default is NULL
      legend.key.size = unit(1.1 * font_size, "pt"),
      #legend.key.height = NULL, # FLAG for deletion. redundant to theme_gray()
      #legend.key.width = NULL, # FLAG for deletion. redundant to theme_gray()
      legend.text = element_text(size = rel(rel_small)),
      legend.text.align = NULL,
      legend.title = element_text(hjust = 0), #edit this to correct for the legend.title.align depreciating, if needed
      #legend.title.align = 0.5, DEPRECATED!
      # legend.position = "bottom",
      # legend.position = legend.position, DEPRECATED
      #legend.position.inside = legend.position, #correcting for depreciation; moving this elsewhere
      legend.direction = NULL,
      #legend.justification = legend.justification, # JTP: I turned this off. It changes nothing
      #legend.box = NULL, # FLAG for deletion. redundant to theme_gray()
      legend.box.margin = margin(0, 0, 0, 0),
      #legend.box.background = element_blank(), # FLAG for deletion. redundant to theme_gray()
      legend.box.spacing = unit(font_size, "pt"),
      panel.background = element_blank(),
      #panel.border = element_blank(), # FLAG for deletion. redundant to theme_gray()
      panel.grid = element_blank(),
      panel.grid.major = NULL,
      panel.grid.minor = NULL,
      panel.grid.major.x = NULL,
      panel.grid.major.y = NULL,
      panel.grid.minor.x = NULL,
      panel.grid.minor.y = NULL,
      panel.spacing = unit(half_line, "pt"),
      #panel.spacing.x = NULL, # FLAG for deletion. redundant to theme_gray()
      #panel.spacing.y = NULL, # FLAG for deletion. redundant to theme_gray()
      #panel.ontop = FALSE, # FLAG for deletion. redundant to theme_gray()
      # strip.background = strip.background, idk what this was doing AGR
      strip.text = element_text(
        size = rel(rel_small),
        margin = margin(qtr_line, qtr_line, qtr_line, qtr_line)
      ),
      #strip.text.x = NULL, # FLAG for deletion. redundant to theme_gray()
      #strip.text.y = strip.text.y,
      #strip.placement = strip.placement,# changed from "inside"
      #strip.placement.x = NULL, # FLAG for deletion. redundant to theme_gray()
      #strip.placement.y = NULL, # FLAG for deletion. redundant to theme_gray()
      strip.switch.pad.grid = unit(qtr_line, "pt"),
      strip.switch.pad.wrap = unit(qtr_line, "pt"),
      #plot.background = element_blank(),
      plot.background = plot_background_box, #agr added
      plot.title = element_text(
        face = "bold",
        size = rel(rel_large),
        margin = margin(b = half_line) # I think this changes nothing as it's the default but not sure
      ),
      plot.subtitle = element_text(
        size = rel(rel_small),
        margin = margin(b = half_line) # I think this changes nothing as it's the default but not sure
      ),
      plot.caption = element_text(
        size = rel(rel_tiny),
        margin = margin(t = half_line) # I think this changes nothing as it's the default but not sure
      ),
      plot.tag = element_text(
        face = "bold",
        hjust = 0,
        vjust = 0.7 #defaults for this are 0.5, 0.5
      ),
      plot.tag.position = c(0, 1), # default is topleft which I believe is the exact same as this
      plot.margin = margin(20, 20, 20, 25) #was half_line x 4
      #complete = TRUE # FLAG for deletion. redundant to theme_gray()
      #legend.position = "inside",
      #legend.position.inside = legend.position.set #agr changed
    )

  # Allow for users to supply custom ggplot theme modifications
  user_theme <- do.call(ggplot2::theme, list(...))

  # Combine the default and custom modifications
  default_adfg_theme + user_theme

}

