---
output:
  word_document: default
  html_document: default
  pdf_document: default
---
# adfggraph

A ggplot2 theme for reproducible figures in R in a uniform Alaska Department of Fish and Game (ADF\&G) style.



This theme creates a graph template for ADF\&G biologists, biometricians, and scientists to create a uniform graph output style that conforms with ADF\&G publication standards. The theme contains one function: theme_adfg, which can be added to a ggplot object to set the theme. This theme was created in collaboration with the ADF\&G reproducibility crew and publication team, to create uniform and professional ADF\&G figures. This work is heavily based on Andrew Padilla's theme\_adfg draft code (I even stole the name) and theme\_crisp by Justin Priest. The majority of this code was written by Padilla and Priest, and my contribution was just minor edits and finalizations.

This theme is still under review.

### Installing adfggraph
`adfggraph` can be installed from GitHub with `remotes`

```
install.packages("remotes")
remotes::install_github("commfish/adfggraph")
library(adfggraph)
```
While frowned upon in official ADF\&G publications, adding a color palette to a graph can greatly improve the impact, especially for posters and presentations. The theme itself is black and white, but colors can be added with [adfg_colors](https://github.com/justinpriest/adfgcolors), or any other R color palette of choice. adfg\_colors has some ADF\&G and Alaska-based color palettes.
```
remotes::install_github("justinpriest/adfgcolors")
library(adfgcolors)
```
### Examples
The dataset "iris" is from the R package [datasets](https://www.rdocumentation.org/packages/datasets/versions/3.6.2) and was used for the examples.

Basic scatterplot:

```
library(ggplot2)
ggplot(iris) + aes(x = Petal.Length, y = Petal.Width) + geom_point() +
    labs(x = "Petal length", y ="Petal width") + 
    theme_adfg(box = "yes")
```

![basic plot](/example_figures/base_plot.png)

Basic multipanel plot:

```
library(ggplot2)
ggplot(iris) + aes(x = Petal.Length, y = Petal.Width) + geom_point() +
    labs(x = "Petal length", y = "Petal width") + 
    theme_adfg(box = "yes") + 
    facet_wrap(~Species, scales = "free") +
    guides(color = "none")
```

![facet plot](/example_figures/facet_plot_nocolor.png)

Violin plot:

```
library(ggplot2)
ggplot(iris) + aes(x = Species, y= Petal.Length, fill = Species) + geom_violin() +
    labs(x = "Species", y = "Frequency") + 
    theme_adfg(legend.position.set = c(0.9, 0.2), box = "yes") + # move legend to a good spot
    scale_fill_adfg(palette = "bristolbay", discrete = TRUE, useexact = TRUE)
```

![violin plot](/example_figures/fill_plot_grey.png)



### Color Plots

Basic scatterplot:

```
library(ggplot2)
ggplot(iris) + aes(x = Petal.Length, y = Petal.Width, color = Species) + geom_point() +
    labs(x = "Petal length", y = "Petal width") + 
    theme_adfg(legend.position.set = c(0.9, 0.18), #move legend to a good spot
                 box ="yes") + # add a border
    scale_color_adfg(palette = "bristolbay", discrete = TRUE, useexact = TRUE)
```

![basic plot](/example_figures/color_plot.png)

Basic multipanel plot:

```
library(ggplot2)
ggplot(iris) + aes(x = Petal.Length, y= Petal.Width, color = Species) + geom_point() +
    labs(x = "Petal length", y = "Petal width") + 
    theme_adfg(box = "yes")+ 
    scale_color_adfg(palette = "bristolbay", discrete = TRUE, useexact = TRUE)+
    facet_wrap(~Species, scales = "free")+
    guides(color = "none") # turn off legend, not needed here
```

![facet plot](/example_figures/facet_plot.png)


Violin plot:

```
library(ggplot2)
ggplot(iris) + aes(x = Species, y = Petal.Length, fill = Species) + geom_violin() +
    labs(x = "Species", y = "Frequency") + 
    theme_adfg(legend.position.set = c(0.9, 0.2), box = "yes")+ #move legend to a good spot
    scale_fill_adfg(palette = "bristolbay", discrete = TRUE, useexact = TRUE)
```

![violin plot](/example_figures/fill_plot.png)


### Box
Use the argument box = "no" to turn off the box that surrounds the plot. This box was added to comply with ADF&G publication standards, but may not make sense for presentations or multi-panel plots.


