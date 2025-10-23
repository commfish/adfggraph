# adfggraph

A ggplot2 theme for reproducible figures in R in a uniform Alaska Department of Fish and Game (ADF\&G) style.



This theme creates a graph template for ADF\&G biologists, biometricians, and 
scientists to create a uniform graph output style that conforms with ADF\&G 
publication standards. The theme contains one function: theme_adfg, which can be 
added to a ggplot object to set the theme. This theme was created in 
collaboration with the ADF\&G reproducibility crew and publication team, to 
create uniform and professional ADF\&G figures. This work is heavily based on 
Andrew Padilla's theme\_adfg draft code and theme\_crisp by Justin Priest. 
The majority of this code was written by Padilla and Priest.

This theme is still under review.

## Installing adfggraph
`adfggraph` can be installed from GitHub with `remotes`

```
install.packages("remotes")
remotes::install_github("commfish/adfggraph")
library(adfggraph)
```

## Examples
The dataset "iris" is from the R package 
[datasets](https://www.rdocumentation.org/packages/datasets/versions/3.6.2) 
and was used for the examples.

### Black and White Figures
Basic scatterplot:

```
library(ggplot2)
ggplot(iris) + aes(x = Petal.Length, y = Petal.Width) + geom_point() +
  labs(x = "Petal length", y = "Petal width") + 
  theme_adfg(box = "yes")
```

![basic plot](/example_figures/base_plot.png)

Basic multipanel plot:

```
library(ggplot2)
ggplot(iris) + aes(x = Petal.Length, y = Petal.Width) + geom_point() +
  labs(x = "Petal length", y = "Petal width") + 
  theme_adfg(box = "yes", font_size = 14) + 
  facet_wrap(~Species, scales = "free") +
  guides(color = "none")
```

![facet plot](/example_figures/facet_plot_nocolor.png)

Violin plot:

```
library(ggplot2)
ggplot(iris) + aes(x = Species, y= Petal.Length, fill = Species) + geom_violin() +
  labs(x = "Species", y = "Frequency") + 
  theme_adfg(legend.position.set = c(0.9, 0.25), box = "yes") + # move legend to a good spot
  scale_fill_grey(start = 0, end = 1)
```

![violin plot](/example_figures/fill_plot_grey.png)



### Color Figures
While color use is cautioned in official ADF\&G publications, adding a color 
palette to a graph can greatly improve the impact, especially for posters and 
presentations. The theme itself is black and white, but colors can be added with 
[adfg_colors](https://github.com/justinpriest/adfgcolors), or any other R color 
palette of choice. The function adfg\_colors has some ADF\&G and Alaska-based 
color palettes.
```
remotes::install_github("justinpriest/adfgcolors")
library(adfgcolors)
```
Basic scatterplot:

```
library(ggplot2)
ggplot(iris) + aes(x = Petal.Length, y = Petal.Width, color = Species) + geom_point() +
  labs(x = "Petal length", y = "Petal width") + 
  theme_adfg(legend.position.set = c(0.9, 0.25), #move legend to a good spot
             box ="yes") + # add a border
  scale_color_adfg(palette = "bristolbay", discrete = TRUE, useexact = TRUE)
```

![basic plot](/example_figures/color_plot.png)

Basic multipanel plot:

```
library(ggplot2)
ggplot(iris) + aes(x = Petal.Length, y= Petal.Width, color = Species) + geom_point() +
  labs(x = "Petal length", y = "Petal width") + 
  theme_adfg(box = "yes", font_size = 14) +
  scale_color_adfg(palette = "bristolbay", discrete = TRUE, useexact = TRUE)+
  facet_wrap(~Species, scales = "free")+
  guides(color = "none") # turn off legend
```

![facet plot](/example_figures/facet_plot.png)


Violin plot:

```
library(ggplot2)
ggplot(iris) + aes(x = Species, y = Petal.Length, fill = Species) + geom_violin() +
  labs(x = "Species", y = "Frequency") + 
  theme_adfg(legend.position.set = c(0.9, 0.25), box = "yes")+ # move legend to a good spot
  scale_fill_adfg(palette = "bristolbay", discrete = TRUE, useexact = TRUE)
```

![violin plot](/example_figures/fill_plot.png)


##Arguments and defaults

### font_size
The font size. The default is 18.

### font_family
The font family. The default is "Times New Roman," in accordance with ADF&G publication recommendations.

### rel_small
The font size for the legend. The default is 0.86*font_size.

### rel_tiny
The font size for the caption, if one is included. The default is 0.79*font_size.

### rel_large
The font size for the title. The default is 1.15*font_size.

### legend.position.set
The coordinates inside the plot panel where the legend is placed. The default is 
c(0.8,0.9). This can be changed to different coordinates or "left", "right", 
"top", or "bottom".

### legend.justification
The anchor point where the legend is set. The default is "center". This can be 
changed to "left", "right", "top", or "bottom".

### strip.placement
Where the title is placed relative to the plot panels. The default is "outside", 
this could be changed to "inside".

### strip.text.y
How the y-axis is drawn. The default is element_text(angle=-90), which puts the 
y-axis text at 90 degrees.

### box
A box is drawn around the plot to comply with ADF&G publication standards. To 
turn this off, use box = "no". The default is box = "yes".


