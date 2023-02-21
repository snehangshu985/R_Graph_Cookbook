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

#----------------------------------------------------------------------------
# 4.3 Making a Line Graph with Multiple Lines
#----------------------------------------------------------------------------

# want to make a line graph with more than one line
# the data set is toothgrow dataset in gcookbook as tg
# graph of the total data set
ggplot(tg, aes(x = dose, y = length)) + geom_line()
# but there are two types of supplements, OJ and VC
# OJ is orange juice and VC is vitamin C
# so checking the lenght vs dose for these two suppliments

ggplot(tg, aes(x = dose, y = length, color = supp)) + geom_line()

# the dose is a factor variable not continuous
df <- tg
df$dose <- as.factor(df$dose)
# in ggplot the argument , group need to used in this case
ggplot(df, aes(x = dose, y = length, color = supp, group = supp)) + geom_line()

# we can add points in the line graph
ggplot(df, aes(x = dose, y = length, color = supp, group = supp, fill = supp)) + 
    geom_line() + geom_point(size = 3, shape = 21)

# ------------------------------------------------------------------------------
# 4.4 Changing the Appearance of Lines
# ------------------------------------------------------------------------------

# The type of line (solid, dashed, dotted, etc.) is set with linetype
#  the thickness (in mm) with size
# and the color of the line with colour (or color)

ggplot(BOD, aes(x = Time, y = demand)) +
    geom_line(linetype = "dashed", size = 1, colour = "blue")

# another example
ggplot(tg, aes(x = dose, y = length, group = supp)) +
    geom_line(colour = "darkgreen", size = 1.5)

# ------------------------------------------------------------------------------
# 4.5 Changing the Appearance of Points
# ------------------------------------------------------------------------------

# In geom_point(), set the size, shape, color, and/or fill outside of aes()

# Example ....

ggplot(BOD, aes(x = Time, y = demand)) +
    geom_line(size = 1.2, color = "blue") +
    geom_point(size = 4, shape = 22, colour = "darkred", fill = "pink")


# ------------------------------------------------------------------------------
# 4.6 Making a Graph with a Shaded Area
# ------------------------------------------------------------------------------

# make a graph with a shaded area.
# Use geom_area() to get a shaded area
# Convert the sunspot.year data set into a data frame for this example
sunspotyear <- data.frame(
    Year     = as.numeric(time(sunspot.year)),
    Sunspots = as.numeric(sunspot.year)
)




ggplot(sunspotyear, aes(x = Year, y = Sunspots)) +
    geom_area()

# Graph with a semitransparent shaded area and an outline
ggplot(sunspotyear, aes(x = Year, y = Sunspots)) +
    geom_area(colour = "black", fill = "blue", alpha = .2)

# Line graph with a line just on top, using geom_line()

ggplot(sunspotyear, aes(x = Year, y = Sunspots)) +
    geom_area(fill = "blue", alpha = .2) +
    geom_line()


# ------------------------------------------------------------------------------
# 4.7 Making a Graph with a Shaded Area
# ------------------------------------------------------------------------------
# make a stacked area graph.

# Use geom_area() and map a factor to fill 

ggplot(uspopage, aes(x = Year, y = Thousands, fill = AgeGroup)) +
    geom_area()


# ------------------------------------------------------------------------------
# 4.8 Making a Proportional Stacked Area Graph
# ------------------------------------------------------------------------------

ggplot(uspopage, aes(x = Year, y = Thousands, fill = AgeGroup)) +
    geom_area(position = "fill", colour = "black", size = .2, alpha = .4) + 
    scale_y_continuous(labels = scales::percent)











