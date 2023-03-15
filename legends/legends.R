#===============================================================================
#                               Chapter 10 -- LEGENDS
#===============================================================================
# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

library(ggplot2)
library(dplyr)
library(tidyr)
library(gcookbook)

#===============================================================================
# 10.1 Removing the Legend
#===============================================================================
# use guides(), and specify the scale that should have its legend removed

# Create the base plot (with legend)
pg_plot <- ggplot(PlantGrowth, aes(x = group, y = weight, fill = group)) +
    geom_boxplot()

# Remove the legend for fill using guide() function
pg_plot +
    guides(fill = FALSE)

#===============================================================================
# 10.2 Changing the Position of a Legend
#===============================================================================
# use theme(legend.position = ...) to place legends

pg_plot <- ggplot(PlantGrowth, aes(x = group, y = weight, fill = group)) +
    geom_boxplot()

# palcing legends at top
pg_plot + theme(legend.position = "top")

# placing legends at any position
pg_plot +
    theme(legend.position = c(.85, .2))
# removing back ground of legends

pg_plot +
    theme(legend.position = c(.85, .2)) +
    theme(legend.background = element_blank())

#===============================================================================
# 10.3 Changing the Order of Items in a Legend
#===============================================================================
# Create the base plot
pg_plot <- ggplot(PlantGrowth, aes(x = group, y = weight, fill = group)) +
    geom_boxplot()

# Change the order of items

pg_plot +
    scale_fill_discrete(limits = c("trt1", "trt2", "ctrl"))

#===============================================================================
# 10.4 Reversing the Order of Items in a Legend
#===============================================================================
# Add guides (fill = guide_legend(reverse = TRUE)) ...
# to reverse the order of the legend

# Create the base plot
pg_plot <- ggplot(PlantGrowth, aes(x = group, y = weight, fill = group)) +
    geom_boxplot()

pg_plot + guides(fill = guide_legend(reverse = TRUE))


#===============================================================================
# 10.5 Changing a Legend Title
#===============================================================================

# Use labs() and set the value of fill, colour etc ....

# Create the base plot
pg_plot <- ggplot(PlantGrowth, aes(x = group, y = weight, fill = group)) +
    geom_boxplot()

# Set the legend title to "Condition"

pg_plot + labs(fill = "Conditions") +
    scale_x_discrete(labels = c("Control", "TRT1", "TRT2"))


# another example in cotinuous X axis

# Load gcookbook for the heightweight data set
hw_plot <- ggplot(heightweight, 
                  aes(x = ageYear, y = heightIn, colour = sex)) +
    geom_point(aes(size = weightLb), alpha = 0.75)

hw_plot + xlab("Age in Year") +
    ylab("Height in Inches") +
    labs(colour = "Gender",
         size = "Weight \n(Pound)") +
    theme(axis.title.x = element_text(face = "bold"),
          axis.title.y = element_text(face= "bold")) +
    geom_smooth(method = "lm", se =F) +
    theme_light()

#===============================================================================
# 10.6 Changing the Appearance of a Legend Title
#===============================================================================
# Use theme(legend.title = element_text()) 

#basic bloxlot
pg_plot <- ggplot(PlantGrowth, aes(x = group, y = weight, fill = group)) +
    geom_boxplot()

pg_plot +
    theme(legend.title = element_text(
        face = "italic",
        colour = "red",
        size = 14)
    )

#===============================================================================
# 10.7 Removing a Legend Title
#===============================================================================
# Add guides(fill = guide_legend(title = NULL)) ...
# to remove the title from a legend

ggplot(PlantGrowth, aes(x = group, y = weight, fill = group)) +
    geom_boxplot() +
    guides(fill = guide_legend(title = NULL))

# another method to hide the legend title ...
pg_plot <- ggplot(PlantGrowth, aes(x = group, y = weight, fill = group)) +
    geom_boxplot()

pg_plot +
    theme(legend.title = element_blank())


#===============================================================================
# 10.8 Changing the Labels in a Legend
#===============================================================================
# Set the labels in the scale ... in scale_fill_discrete()

# The base plot
pg_plot <- ggplot(PlantGrowth, aes(x = group, y = weight, fill = group)) +
    geom_boxplot()

# changing legends title in scale_fill_discrete ()
# changing x tick labels in scale_x_discrete ()
# changing the legen title in labs()

pg_plot + scale_fill_discrete(labels = c("Control", 
                                         "Treatment1", 
                                         "Treatment 2")) +
    scale_x_discrete(labels = c("Contrl", 
                                "Treatment1", 
                                "Treatment 2")) +
    labs(fill = "Treatment Type")


#===============================================================================
# 10.9 Changing the Appearance of Legend Labels
#===============================================================================
# Use theme(legend.text=element_text())

# Create the base plot
pg_plot <- ggplot(PlantGrowth, aes(x = group, y = weight, fill = group)) +
    geom_boxplot()

pg_plot +
    theme(legend.text = element_text(
        face = "italic",
        colour = "red",
        size = 14)
    )






















