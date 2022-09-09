#=============================================================================
                            # R- Graphics COOKBOOK
                            # Chapter 4 Line Graphs
#=============================================================================

library(ggplot2)
library(dplyr)
library(gcookbook)

#----------------------------------------------------------------------------
# 4.1 Making a Basic Line Graph
#----------------------------------------------------------------------------

# data set used is BOD, time vs demand table
# geom_line is function for the line graph

ggplot(BOD, aes(x = Time, y = demand)) +
    geom_line()


#----------------------------------------------------------------------------
# 4.2 Adding Points to a Line Graph
#----------------------------------------------------------------------------
# to add points to a line graph use geom_point()

ggplot(BOD, aes(x = Time, y = demand)) +
    geom_line() +
    geom_point()


# another plot

ggplot(worldpop, aes(x = Year, y = Population)) +
    geom_line() +
    geom_point()
# for large set when convenient log y scale can be used
ggplot(worldpop, aes(x = Year, y = Population)) +
    geom_line() +
    geom_point() +
    scale_y_log10()











