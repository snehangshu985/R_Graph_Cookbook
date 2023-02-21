

#===============================================================================
#                               Chapter 6 
#                      Summarized Data Distributions
#===============================================================================
# This chapter explores how to visualize summarized distributions of data.
library(dplyr)
library(tidyr)
library(ggplot2)
library(gcookbook)

#===============================================================================
# 6.1 Making a Basic Histogram
#===============================================================================
# Use geom_histogram() and map a continuous variable to x

ggplot(faithful, aes(x = waiting)) +
    geom_histogram()

# ggplot takes data.frames as input data...
# if data is not inform of data frames.. pass NULL as data, and .....
# put variable in aes()

waiting <- faithful$waiting

ggplot(data = NULL, aes(x=waiting)) + geom_histogram()

# change bin size, deafual is 30
ggplot(faithful, aes(x = waiting)) +
    geom_histogram(bins = 15)

# change bins width 

ggplot(faithful, aes(x = waiting)) +
    geom_histogram(binwidth = 5)

#===============================================================================
# 6.2 Making Multiple Histograms from Grouped Data
#===============================================================================
# Use geom_histogram() and use facets for each group

library(MASS) # Load MASS for the birthwt data set

# Use smoke as the faceting variable

ggplot(birthwt, aes(x = bwt)) +
    geom_histogram(fill = "white", colour = "black") +
    facet_grid(smoke ~ .) 


ggplot(birthwt, aes(x = bwt)) +
    geom_histogram(fill = "white", colour = "black") +
    facet_grid(. ~ smoke) # column wise . ~ smoke

# another approach is fill by the groupig variable
# Map smoke to fill, make the bars NOT stacked, and make them semitransparent

birthwt_mod <- birthwt
# Convert smoke to a factor and reassign new names
birthwt_mod$smoke <- recode_factor(birthwt_mod$smoke, '0' = 'No Smoke', '1' = 'Smoke')

ggplot(birthwt_mod, aes(x = bwt, fill = smoke)) +
    geom_histogram(position = "identity", alpha = 0.4)


#===============================================================================
# 6.3 Making a Density Curve
#===============================================================================
# Use geom_density()
ggplot(faithful, aes(x = waiting)) + 
    geom_density()

# second method of using geom_line(stat = "density")

# expand_limits() increases the y range to include the value 0
ggplot(faithful, aes(x = waiting)) +
    geom_line(stat = "density") 

# Overlay histogram with density ..........
# use ggplot(data, aes(x = vec, y = ..density..))

ggplot(faithful, aes(x = waiting, y = ..density..)) + 
geom_histogram(bins = 15,  fill = "white", colour = "magenta", size = .6) + 
geom_line(stat = "density", size = .8, colour = 'blue', linetype = "dashed") + 
    theme_minimal()


#===============================================================================
# 6.4 Making Multiple Density Curves from Grouped Data
#===============================================================================
# map the grouping variable to an aesthetic like colour or fill

library(MASS) # Load MASS for the birthwt data set

birthwt_mod <- birthwt %>%
    mutate(smoke = as.factor(smoke)) # Convert smoke to a factor

# Map smoke to colour
ggplot(birthwt_mod, aes(x = bwt, colour = smoke)) +
    geom_density()

# Map smoke to fill and make the fill semitransparent by setting alpha
ggplot(birthwt_mod, aes(x = bwt, fill = smoke)) +
    geom_density(alpha = .3)

# recoding smoking instead of 0 & 1

birthwt_mod$smoke <- recode(birthwt_mod$smoke, '0' = 'No Smoke', '1' = 'Smoke')

ggplot(birthwt_mod, aes(x = bwt, fill = smoke)) +
    geom_density(alpha = .3)


# faceting the density and histogram
ggplot(birthwt_mod, aes(x = bwt, y = ..density..)) + 
    geom_histogram(bins = 20, fill = "white", colour = "magenta", size = .2) +
    geom_density(colour = "blue", linetype = "dashed") + 
    facet_grid(smoke ~ .)

#===============================================================================
# 6.5 Making a Frequency Polygon
#===============================================================================

# Use geom_freqpoly()

ggplot(faithful, aes(x=waiting)) +
    geom_freqpoly()
# adjust bins or binwidth for smoothing the polygon

ggplot(faithful, aes(x = waiting)) +
    geom_freqpoly(binwidth = 4)

#===============================================================================
# 6.6 Making a Basic Box Plot
#===============================================================================
# Use geom_boxplot()
library(MASS) # Load MASS for the birthwt data set

# Use factor() to convert a numeric variable into a discrete variable
ggplot(birthwt, aes(x = factor(race), y = bwt)) +
    geom_boxplot()

# to arrange ascending order... fct_reorder is used

library(forcats)
birthwt_mod$race <- recode(birthwt_mod$race, "1" = "White", "2"="Black", "3" = "Others")
ggplot(birthwt_mod, aes(x = fct_reorder(factor(race), bwt, .desc = F), y = bwt)) +
    geom_boxplot(aes(fill = factor(race))) + 
    xlab("Race") + ylab("Birth Weight")


    
#===============================================================================
# 6.7 Adding Notches to a Box Plot
#===============================================================================
# Use geom_boxplot() and set notch = TRUE

ggplot(birthwt, aes(x = factor(race), y = bwt)) +
    geom_boxplot(notch = T)


#===============================================================================
# 6.8 Adding Means to a Box Plot
#===============================================================================
# Use stat_summary()
# library(MASS) # Load MASS for the birthwt data set

ggplot(birthwt, aes(x = factor(race), y = bwt)) +
    geom_point(position = position_jitter(width = .3), colour = "blue", alpha = 0.25) + 
    geom_boxplot(alpha = 0.5) + 
    stat_summary(fun = "mean", geom = "point", shape = 21, size = 3, fill = "red")
# Warning: The `fun.y` argument of `stat_summary()` is.....
# #  deprecated as of ggplot2 3.3.0.
#  Please use the `fun` argument instead.


#===============================================================================
# 6.9 Making a Violin Plot
#===============================================================================
# Load gcookbook for the heightweight data set

# Create a base plot using the heightweight data set
hw_p <- ggplot(heightweight, aes(x = sex, y = heightIn))

hw_p +
    geom_violin()

# use adjust parameters for smoothin the violin plot
hw_p +
    geom_violin(adjust = .5)

hw_p +
    geom_violin(adjust = 2) # more adjust more smooth

# add boxplot within violin


hw_p +
    geom_violin(adjust = 0.5) + 
    geom_boxplot(width = 0.1, fill = "black", outlier.colour = NA) + 
    stat_summary(fun = median, geom = "point", fill = "white", shape=21, size = 3)









