#===============================================================================
#@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

#            Chapter 9 Controlling the Overall Appearance of Graphs

# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
#===============================================================================
library(ggplot2)
library(dplyr)
library(tidyr)
library(gcookbook)

#===============================================================================
# 9.1 Setting the Title of a Graph
#===============================================================================
# Use ggtitle() to add a title

hw_plot <- ggplot(heightweight, aes(x = ageYear, y = heightIn)) +
    geom_point()

hw_plot +
    ggtitle("Age and Height of Schoolchildren")

# Use \n for a newline
hw_plot +
    ggtitle("Age and Height\nof Schoolchildren")


# ggtitle() is equivalent to using labs(title = "Title text"


#===============================================================================
# 9.2 Changing the Appearance of Text
#===============================================================================
#  use theme() and set the item with element_text()
# example, axis.title.x controls the appearance of the x-axis label
# and plot.title controls the appearance of the title text 

hw_plot <- ggplot(heightweight, aes(x = ageYear, y = heightIn)) +
    geom_point()


hw_plot +
    theme(axis.title.x = element_text(size = 16, lineheight = .9,
        family = windowsFont("Times"), face = "bold.italic", colour = "red"))

#===============================================================================
# 9.3 Using Themes
#===============================================================================
# many premade themes that are already included in ggplot2
# default ggplot2 theme is theme_grey()
# other examples theme_bw(), theme_minimal(), and theme_classic()

hw_plot <- ggplot(heightweight, aes(x = ageYear, y = heightIn)) +
    geom_point()

# Black-and-white theme
hw_plot +
    theme_bw()

# Minimal theme without background annotations
hw_plot +
    theme_minimal()

# Classic theme, with axis lines but no gridlines
hw_plot +
    theme_classic()

#===============================================================================
# 9.4 Changing the Appearance of Theme Elements
#===============================================================================

library(gcookbook)  # Load gcookbook for the heightweight data set

# Create the base plot
hw_plot <- ggplot(heightweight, aes(x = ageYear, y = heightIn, colour = sex)) +
    geom_point()

# Options for the plotting area
hw_plot +
    theme(
        panel.grid.major = element_line(colour = "red"),
        panel.grid.minor = element_line(colour = "red", linetype = "dashed", size = 0.2),
        panel.background = element_rect(fill = "lightblue"),
        panel.border = element_rect(colour = "blue", fill = NA, size = 2)
    )
#> Warning: The `size` argument of `element_rect()` is deprecated as of ggplot2 3.4.0.
#> ℹ Please use the `linewidth` argument instead.

# Options for the legend
hw_plot +
    theme(
        legend.background = element_rect(fill = "grey85", colour = "red", size = 1),
        legend.title = element_text(colour = "blue", face = "bold", size = 14),
        legend.text = element_text(colour = "red"),
        legend.key = element_rect(colour = "blue", size = 0.25)
    )

# Options for text items
hw_plot +
    ggtitle("Plot title here") +
    theme(
        axis.title.x = element_text(colour = "red", size = 14),
        axis.text.x  = element_text(colour = "blue"),
        axis.title.y = element_text(colour = "red", size = 14, angle = 90),
        axis.text.y  = element_text(colour = "blue"),
        plot.title = element_text(colour = "red", size = 20, face = "bold")
    )

# Options for facets
hw_plot +
    facet_grid(sex ~ .) +
    theme(
        strip.background = element_rect(fill = "pink"),
        strip.text.y = element_text(size = 14, angle = -90, face = "bold")
    )  # strip.text.x is the same, but for horizontal facets














