#===============================================================================
#                               Chapter 8 Axes
#===============================================================================
library(ggplot2)
library(dplyr)
library(tidyr)
library(gcookbook)

#===============================================================================
# 8.1 Swapping X- and Y-Axes
#===============================================================================
# Use coord_flip() to flip the axes 
library(forcats)
ggplot(PlantGrowth, aes(x = fct_reorder(group, weight,), y = weight)) +
    geom_boxplot() + 
    coord_flip() + 
    xlab("Group")

ggplot(PlantGrowth, aes(x = group, y = weight)) +
    geom_boxplot() +
    coord_flip()

#===============================================================================
# 8.2 Setting the Range of a Continuous Axis
#===============================================================================
# use xlim() or ylim() to set the minimum and maximum values

pg_plot <- ggplot(PlantGrowth, aes(x = group, y = weight)) +
    geom_boxplot()

# Display the basic graph
pg_plot

pg_plot +
    ylim(0, max(PlantGrowth$weight))

# ylim() is shorthand for setting the limits with scale_y_continuous()

# ylim(0, 10) and scale_y_continuous(limits = c(0, 10)) is same

# WARNING xlim and ylim clipped the data , example

pg_plot + ylim(5, 6.5) # check the warning massage

# instead zooming into the plot
pg_plot +
    coord_cartesian(ylim = c(5, 6.5))


# plane ylim filter the data where wight is between 5 to 6.5
# and then draw the boxplot in the filtered data
# where as the coord_cartesian zoom into 5 to 6.5 in the the whole data

#===============================================================================
# 8.3 Reversing a Continuous Axis
#===============================================================================
# Use scale_y_reverse() or scale_x_reverse()

ggplot(PlantGrowth, aes(x = group, y = weight)) +
    geom_boxplot() +
    scale_y_reverse()

# Similar effect by specifying limits in reversed order
ggplot(PlantGrowth, aes(x = group, y = weight)) +
    geom_boxplot() +
    ylim(6.5, 3.5)

# important point .........
# scale_y_reverse() does not work with ylim()
#  If you want to reverse an axis and set its range, .....
#  you must do it within the scale_y_reverse()
# example
ggplot(PlantGrowth, aes(x = group, y = weight)) +
    geom_boxplot() +
    scale_y_reverse(limits = c(8, 0))


#===============================================================================
# 8.4 Changing the Order of Items on a Categorical Axis
#===============================================================================

# can be changed by setting limits in scale_x_discrete()

pg_plot <- ggplot(PlantGrowth, aes(x = group, y = weight)) +
    geom_boxplot()


pg_plot +
    scale_x_discrete(limits = c("trt1", "ctrl", "trt2"))


#===============================================================================
#  8.5 Setting the Scaling Ratio of the X- and Y-Axes
#===============================================================================

# to set the ratio at which the x- and y-axes are scaled use coord_fixed()
m_plot <- ggplot(marathon, aes(x = Half,y = Full)) +
    geom_point()

m_plot + coord_fixed()

# setting major tick in 30 interval
m_plot +
    coord_fixed() +
    scale_y_continuous(breaks = seq(0, 420, 30)) +
    scale_x_continuous(breaks = seq(0, 420, 30))
# Instead of equal ratio maintain an fixed ration say 1/2

m_plot +
    coord_fixed(ratio = 1/2) +
    scale_y_continuous(breaks = seq(0, 420, 30)) +
    scale_x_continuous(breaks = seq(0, 420, 15))


#===============================================================================
#  8.6 Setting the Positions of Tick Marks
#===============================================================================

# to set where the tick marks appear on the axis set breaks in the scale

ggplot(PlantGrowth, aes(x = group, y = weight)) +
    geom_boxplot()

ggplot(PlantGrowth, aes(x = group, y = weight)) +
    geom_boxplot() +
    scale_y_continuous(breaks = c(4, 4.25, 4.5, 5, 6, 8))


#===============================================================================
#  8.7 Removing Tick Marks and Labels
#===============================================================================
# To remove just the tick labels use theme(axis.text.y = element_blank()

pg_plot <- ggplot(PlantGrowth, aes(x = group, y = weight)) +
    geom_boxplot()

pg_plot +
    theme(axis.text.y = element_blank(), 
          axis.text.x = element_blank())

# To remove the tick marks, the labels, and the grid lines, set breaks to NULL

pg_plot +
    scale_y_continuous(breaks = NULL)


#===============================================================================
#  8.8 Changing the Text of Tick Labels
#===============================================================================
# general ticks .....
hw_plot <- ggplot(heightweight, aes(x = ageYear, y = heightIn)) +
    geom_point()

hw_plot

# custom tick mark ...
# To set arbitrary labels pass values to breaks and labels in the scale

hw_plot +
    scale_y_continuous(
        breaks = c(50, 56, 60, 66, 72),
        labels = c("Tiny", "Really\nshort", "Short", "Medium", "Tallish")
    )

#===============================================================================
#  8.9 Changing the Appearance of Tick Labels
#===============================================================================

# to change the appearance of tick labels .... 
# manually set the labels to be long-long enough that they overlap
pg_plot <- ggplot(PlantGrowth, aes(x = group, y = weight)) +
    geom_boxplot() + 
    scale_x_discrete(
        breaks = c("ctrl", "trt1", "trt2"),
        labels = c("Control", "Treatment 1", "Treatment 2")
    )

# rotate the text 90 degrees use theme(axis.text.x = element_text(angle = 90 ....

pg_plot +
    theme(axis.text.x = element_text(angle = 90 , hjust = 1, vjust = 1))
    
#===============================================================================
#  8.10 Changing the Text of Axis Labels
#===============================================================================
# to change the text of axis labels use xlab() or ylab()

hw_plot <- ggplot(heightweight, aes(x = ageYear, y = heightIn, colour = sex)) +
    geom_point()

hw_plot +
    xlab("Age in years") +
    ylab("Height in inches")

#===============================================================================
#  8.11 Removing Axis Labels
#===============================================================================
# to remove the label on an axis use xlab(NULL) or ylab(NULL)

pg_plot <- ggplot(PlantGrowth, aes(x = group, y = weight)) +
    geom_boxplot()

pg_plot +
    xlab(NULL)


# another way is 

pg_plot + 
    theme(axis.title.x = element_blank() )

# If use xlab("")

pg_plot +
    xlab("") # the axis label is blank but not removed

pg_plot + 
    theme(axis.title.x = element_blank() )

#===============================================================================
#  8.12 Changing the Appearance of Axis Labels
#===============================================================================
# change font colour attribute of the axes by- title axis.title.x = element_text

hw_plot <- ggplot(heightweight, aes(x = ageYear, y = heightIn)) +
    geom_point()
hw_plot + 
    theme(axis.title.x = element_text(face = "bold", colour= "blue", size = 14),
          axis.text.x = element_text(face = "italic", color = "red", size =11))

#===============================================================================
#  8.13 Showing Lines Along the Axes
#===============================================================================
# in themes, use axis.line.. 

hw_plot <- ggplot(heightweight, aes(x = ageYear, y = heightIn)) +
    geom_point()


hw_plot + 
    theme(axis.line = element_line(colour = "black"))

# some arrangement in themes ...

g <- hw_plot +
    xlab("Age (Year)") + 
    ylab("Height \n(Inches)") + 
    theme(axis.title = element_text(face = "bold", size = 14)) + 
    theme(axis.title.y = element_text(angle = 0)) + 
    theme(axis.line = element_line(colour = "black"))


#===============================================================================
#  8.14 Using a Logarithmic Axis
#===============================================================================
# use scale_x_log10() or similar for y
library(MASS)
library(ggrepel)
animals_plot <- ggplot(Animals, aes(x = body, y = brain)) +
    geom_point(color = "red") +
    scale_x_log10() +
    scale_y_log10() +
    geom_text_repel(label = rownames(Animals)) + 
    annotation_logticks() 


#===============================================================================
#  8.15 Adding Ticks for a Logarithmic Axis
#===============================================================================
# Use annotation_logticks()


animals_plot <- ggplot(Animals, aes(x = body, y = brain)) +
    geom_point(color = "red") +
    scale_x_log10() +
    scale_y_log10() +
    geom_text_repel(label = rownames(Animals)) + 
    annotation_logticks() 

#===============================================================================
#  8.16 Making a Circular Plot
#===============================================================================
ggplot(wind, aes(x = DirCat, fill = SpeedCat)) +
    geom_histogram(binwidth = 15, boundary = -7.5) +
    coord_polar() +
    scale_x_continuous(limits = c(0,360))













