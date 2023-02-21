library(ggplot2)
library(dplyr)
library(gcookbook)

#===============================================================================
#                               Scatter Plot
#===============================================================================

# 5.1 Making a Basic Scatter Plot
# make a scatter plot using two continuous variables
# Use geom_point(), and map one variable to x and one variable to y

# data is heightweight {gcookbook} Height and weight of schoolchildren
# data is 236 row of 5 variables
# variable ... "sex"  "ageYear"  "ageMonth" "heightIn" "weightLb"


    ggplot(heightweight, aes(x = ageYear, y = heightIn)) +
        geom_point()

#===============================================================================
# 5.2 Grouping Points Together using Shapes or Colors
#===============================================================================

# visually group points by some variable (the grouping variable), ....
# using different shapes or colors.

ggplot(heightweight, aes(x = ageYear, y = heightIn )) +
    geom_point(aes(colour = sex, shape = sex))


#===============================================================================
# 5.3 manually Using Different Point Shape
#===============================================================================
# mapping a variable using shape in aes()
# scale_shape_manual () with valus c(1,2) etc.....

ggplot(heightweight, aes(x = ageYear, y = heightIn, shape = sex)) +
    geom_point(size = 3) +
    scale_shape_manual(values = c(1, 4))

#===============================================================================
# 5.4 Mapping a Continuous Variable to Color or Size
#===============================================================================

# for colour ........
ggplot(heightweight, aes(x = ageYear, y = heightIn, colour = weightLb)) +
    geom_point()

# for size ........
ggplot(heightweight, aes(x = ageYear, y = heightIn, size = weightLb)) +
    geom_point(colour = "red", alpha = 0.25, fill = "red")


#===============================================================================
# 5.5 Dealing with Overplotting
#===============================================================================

# Problem : many points that overlap and obscure each other when plotted
# possible remedies - Make the points semi-transparent

g1 <- ggplot(diamonds, aes(x = carat, y = price)) + geom_point(alpha = 0.2)


# Another way is to divided the data into some bins
# stat_bin2d() is the function

g2 <- ggplot(diamonds, aes(x = carat, y = price)) + stat_bin2d()

# default bin is 30, can be specified as stat_bin2d(bins = 50)
# scale_fill_gradient to use custom colour

g3 <- ggplot(diamonds, aes(x = carat, y = price)) + stat_bin2d(bins = 50) + 
    scale_fill_gradient(low = "green", high = "red")

#===============================================================================
# 5.6 Adding Fitted Regression Model Lines
#===============================================================================

# We'll use the heightweight data set and ......
# create a base plot called `hw_sp` (for heighweight scatter plot)

hw_sp <- ggplot(heightweight, aes(x = ageYear, y = heightIn))

hw_sp + geom_point() + stat_smooth(method = lm)

# By default, stat_smooth() also adds a 95% confidence region 
# it can be disabled with se = FALSE
# Or can be specified such as as level = 0.99

# 99% confidence region
hw_sp +
    geom_point() +
    stat_smooth(method = lm, level = 0.99)

# No confidence region
hw_sp +
    geom_point() +
    stat_smooth(method = lm, se = FALSE)

# The default color of the fit line is blue
# This can be change by setting colour
hw_sp + geom_point(colour = "blue") +
    stat_smooth(method = lm, se = FALSE, colour = "red")


# If two different groups are there in the data and we want...
# two regression lines

hw_sp <- ggplot(heightweight, aes(ageYear,heightIn, colour = sex)) +
    geom_point() + scale_colour_brewer(palette = "Set1")


hw_sp  + stat_smooth(method = lm, se =F)

# faceting the variables


hw_sp + facet_grid(cols = vars(sex)) + stat_smooth(method = lm, se =F)


#===============================================================================
# 5.7 Adding Fitted Lines from an Existing Model
#===============================================================================


library(caret)
# creating a model from heightweight data
splitter <- createDataPartition(heightweight$heightIn, p = .6, list = F)

traindata <- heightweight[splitter,]
testdata <- heightweight[-splitter,]

fit_lm <- lm(formula = heightIn ~ ageMonth, data = traindata)
# predicting the 
y_pred <- predict(fit_lm, newdata = testdata)

df2 <- data.frame(testdata, pred_height = y_pred)

ggplot(df2, aes(ageMonth, heightIn)) + geom_point() + 
    stat_smooth(method = lm) + geom_line(aes(ageMonth, pred_height), colour = "red")


#===============================================================================
# 5.10 Adding Marginal Rugs to a Scatter Plot
#===============================================================================

# To add marginal rugs to a scatter plot Use geom_rug()

ggplot(faithful, aes(x = eruptions, y = waiting)) +
    geom_point() +
    geom_rug()

# the waiting time looks equally spaced but there is over plotting
# to overcome this need to add some jitter

ggplot(faithful, aes(x = eruptions, y = waiting)) +
    geom_point() +
    geom_rug(position = "jitter", size = 0.2)


#===============================================================================
# 5.11 Labeling Points in a Scatter Plot
#===============================================================================
# use annotate() or geom_text()

# using the countries data set from gcookbook
# using only year 2009 data 

countries_sub <- countries %>% filter(Year == 2009 & healthexp > 2000)

# manually add text

countries_sp <- ggplot(countries_sub, aes(x = healthexp, y = infmortality)) +
    geom_point()

countries_sp +
    annotate("text", x = 4350, y = 5.4, label = "Canada") +
    annotate("text", x = 7400, y = 6.8, label = "USA")

#To automatically add the labels from your data use geom_text()

countries_sp +
    geom_text(aes(label = Name), size = 4)

# to repel the text use ggrepel from package ggrepel
# install.packages("ggrepel")
library(ggrepel)

countries_sp +
    geom_text_repel(aes(label = Name), size = 3)

# alternatively 

countries_sp +
    geom_label_repel(aes(label = Name), size = 3)












