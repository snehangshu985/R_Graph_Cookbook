#==============================================================================
#                               Chapter 11 Facets
#==============================================================================
# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

library(ggplot2)
library(dplyr)
library(tidyr)
library(gcookbook)


#=============================================================================
# 11.1 Splitting Data into Subplots with Facets
#=============================================================================
# use facet_grid() or facet_wrap(),.....
#  and specify the variables on which to split

# Create the base plot
mpg_plot <- ggplot(mpg, aes(x = displ, y = hwy)) +
    geom_point()

# Faceted by cyl, in horizontally arranged subpanels
mpg_plot +
    facet_grid(. ~ cyl)


# Faceted by drv, in vertically arranged subpanels
mpg_plot +
    facet_grid(drv ~ .)

# Split by drv (vertical) and cyl (horizontal)
mpg_plot +
    facet_grid(drv ~ cyl)

# With facet_wrap(), the subplots are laid out horizontally 

# Facet on class
# Note that there is nothing before the tilde
mpg_plot +
    facet_wrap( ~ class)

# With facet_wrap(), the default is to use .... 
# the same number of rows and columns
# there were seven facets, and they fit into a 3×3 square
# o change this, you can pass a value for nrow or ncol
# example ......
mpg_plot +
    facet_wrap( ~ class, nrow = 2)

mpg_plot +
    facet_wrap( ~ class, ncol = 4)



#=============================================================================
# 11.2 Using Facets with Different Axes
#=============================================================================
# all the faceting panels have same range for X and Y axis
# to use different ranges for different panels
# Set the scales to "free_x", "free_y", or "free"

# Create the base plot
mpg_plot <- ggplot(mpg, aes(x = displ, y = hwy)) +
    geom_point()

# With free y scales
mpg_plot +
    facet_grid(drv ~ cyl, scales = "free_y")


# With free x scales
mpg_plot +
    facet_grid(drv ~ cyl, scales = "free_x")

# With free x and y scales
mpg_plot +
    facet_grid(drv ~ cyl, scales = "free")




















