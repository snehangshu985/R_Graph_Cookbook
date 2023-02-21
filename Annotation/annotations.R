#===============================================================================
#                               Chapter 7 Annotations
#===============================================================================

library(ggplot2)
library(dplyr)
library(tidyr)
library(gcookbook)

#===============================================================================
# 7.1 Adding Text Annotations
#===============================================================================
# Use annotate() and a text geom

p <- ggplot(faithful, aes(x = eruptions, y = waiting)) +
    geom_point()

p + annotate("text", x = 3, y = 48, label = "Group 1") + 
    annotate("text", x = 4.5, y = 66, label = "Group 2")


#===============================================================================
# 7.2 Using Mathematical Expressions in Annotations
#===============================================================================

# Use annotate(geom = "text") with parse = TRUE

# A normal curve
p <- ggplot(data.frame(x = c(-3,3)), aes(x = x)) +
    stat_function(fun = dnorm)

p +
    annotate("text", x = 0, y = 0.05, parse = TRUE,
             label = "frac(1, sqrt(2 * pi)) * e ^ {-x^2 / 2}")


#===============================================================================
# 7.3 Adding Lines
#===============================================================================

# For horizontal and vertical lines, use geom_hline()
# for angled lines, use geom_abline()

hw_plot <- ggplot(heightweight, aes(x = ageYear, y = heightIn, colour = sex)) +
    geom_point()


# Add horizontal and vertical lines
hw_plot +
    geom_hline(yintercept = 60) +
    geom_vline(xintercept = 14)


# Add angled line
hw_plot +
    geom_abline(intercept = 37.4, slope = 1.75)

# adding a mean reference line

hw_plot + geom_hline(yintercept = mean(heightweight$heightIn))

# adding mean line for different groups in data
# here gruping by gender
hw_mean <- heightweight %>% group_by(sex)  %>% summarise(avheight = mean(heightIn))


hw_plot + 
    geom_hline(data = hw_mean, 
               aes(yintercept = avheight, color = sex), 
                   size = 0.8, linetype = "dashed") + 
    geom_smooth(method = "lm", se = F)



pg_plot <- ggplot(PlantGrowth, aes(x = group, y = weight)) +
    geom_point()

# for vertical line use geom_vline()
pg_plot +
    geom_vline(xintercept = 2)

# another way to xitercept for catergogical variable .....
pg_plot +
    geom_vline(xintercept = which(levels(PlantGrowth$group) == "ctrl"))


#===============================================================================
# 7.4 Adding Line Segments 
#===============================================================================
# Use annotate("segment")

p <- ggplot(filter(climate, Source == "Berkeley"), aes(x = Year, y = Anomaly10y)) +
    geom_line()

p +
    annotate("segment", x = 1950, xend = 1980, y = -.25, yend = -.25)

p + annotate("segment", x = 1950, xend = 1950, 
             y = -.25, yend = .25, color = "blue") + 
    annotate("segment", x = 1980, xend = 1980, 
             y = -.25, yend = .25, color = "blue")

# p + coord_cartesian(xlim = c(1950, 1980))


#===============================================================================
# 7.5 Adding a Shaded Rectangle
#===============================================================================
# Use annotate("rect")

df <- climate %>% filter(Source == "Berkeley")

p <- ggplot(df, aes(x = Year, y = Anomaly10y)) + geom_line()

p + annotate("rect", xmin = 1950, xmax = 1980,
             ymin = min(df$Anomaly10y), ymax = max(df$Anomaly10y),
             alpha = .2, fill = "blue")


#===============================================================================
# 7.7 Adding Error Bars
#===============================================================================
# Use geom_errorbar() and map variables to the values for ymin and ymax

# Take a subset of the cabbage_exp data for this example
ce_mod <- cabbage_exp %>%
    filter(Cultivar == "c39")
# With a bar graph
ggplot(ce_mod, aes(x = Date, y = Weight)) +
    geom_col(fill = "white", colour = "black") +
    geom_errorbar(aes(ymin = Weight - se, ymax = Weight + se), width = .2)


# With a line graph
ggplot(ce_mod, aes(x = Date, y = Weight)) +
    geom_line(aes(group = 1)) +
    geom_point(size = 4) +
    geom_errorbar(aes(ymin = Weight - se, ymax = Weight + se), width = .2)


#===============================================================================
# 7.8 Adding Annotations to Individual Facets
#===============================================================================
# Create a new data frame with the faceting variable(s), and .........
# and a value to use in each facet. 
# Then use geom_text() with the new data frame

# Create the base plot
mpg_plot <- ggplot(mpg, aes(x = displ, y = hwy)) +
    geom_point() +
    facet_grid(. ~ drv)

# A data frame with labels for each facet
f_labels <- data.frame(drv = c("4", "f", "r"), label = c("4wd", "Front", "Rear"))

mpg_plot +
    geom_text(x = 6, y = 40, aes(label = label), data = f_labels)












