#============================================================================
#                        Chapter 12 Using Colors in Plots
#============================================================================
# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

library(ggplot2)
library(dplyr)
library(tidyr)
library(gcookbook)

#============================================================================
# 12.1 Setting the Colors of Objects
#============================================================================
# In the call to the geom, set the values of colour or fill .

library(MASS)

ggplot(birthwt, aes(x = bwt)) +
    geom_histogram(fill = "red", colour = "black")

ggplot(mtcars, aes(x = wt, y = mpg)) +
    geom_point(colour = "red")

#============================================================================
# 12.2 Representing Variables with Colors
#============================================================================
# to use a variable to control the color of plots use aes()

# These both have the same effect
ggplot(cabbage_exp, aes(x = Date, y = Weight, fill = Cultivar)) +
    geom_col(colour = "black", position = "dodge")

ggplot(cabbage_exp, aes(x = Date, y = Weight)) +
    geom_col(aes(fill = Cultivar), colour = "black", position = "dodge")

# These both have the same effect
ggplot(mtcars, aes(x = wt, y = mpg, colour = cyl)) +
    geom_point()

ggplot(mtcars, aes(x = wt, y = mpg)) +
    geom_point(aes(colour = cyl))
# in mtcars the cyl is 4 cylinder, 6 or 8
# but ggplot treat this as numerical continuous
# to tackle this in aes(), set color as factor(cyl)

ggplot(mtcars, aes(x = wt, y = mpg, colour = factor(cyl))) +
    geom_point()
















