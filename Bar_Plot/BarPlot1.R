#==========================================================================
#               #      Creating Bar Plot    #
#==========================================================================

# ----------------------------------------------------------------
#               Creating a Bar plot in base plotting system
#-----------------------------------------------------------------
# bar plot can be created with function barplot()
# In the Example we will use the BOD data set

df <- BOD
# the BOD is a two variable df, "Time" and "Demand"

# we will plot time in x and demand in y
attach(df)
barplot(height = demand, names.arg = Time)
detach(df)

#-------------------------------------------------------------
# 3.1 Barplot using GGPLOT package
#-------------------------------------------------------------

library(ggplot2)
library(forcats)
# default stat of bar is count for y variable
# one way to hand two variable bar plot is to specify stat = "identity"
ggplot(df, aes(factor(Time), demand)) + geom_bar(stat = "identity")
# another way is to use geom_col(), which take two variable for x and y
ggplot(df, aes(factor(Time), demand)) + geom_col()


# creating barplot with mtcars data set
# there are 4, 6 and 8 cylinders cars
# creating the table of the cylinders

table(mtcars$cyl)

ggplot(mtcars, aes(factor(cyl))) + geom_bar()

#--------------------------------------------------------------------------
# 3.2 grouping bars together, stacked side by side
#--------------------------------------------------------------------------

# install.packages("gcookbook")
library(gcookbook)
# plotting the cabbage expenditure data set

ggplot(cabbage_exp, aes(x = Date, y = Weight, fill = Cultivar)) +
    geom_col()
# in normal command they stacked one over another
# for side by side use command position = "dodge

ggplot(cabbage_exp, aes(x = Date, y = Weight, fill = Cultivar)) +
    geom_col(position = "dodge", color = "black", size = 1.0)

#-----------------------------------------------------------------------
# 3.3 Creating Bar plot for Count
#-----------------------------------------------------------------------

# the default stat in geom_bar() will be count
# Use geom_bar() without mapping anything to y will be count on y
# EXAMPLE .......
library(forcats)
ggplot(diamonds, aes(x = cut)) + geom_bar()


#-----------------------------------------------------------------------
# 3.4 Fill bar by mapping
#-----------------------------------------------------------------------
library(gcookbook) # Load gcookbook for the uspopchange data set
library(dplyr)
library(ggpattern)
upc <- uspopchange %>% arrange(desc(Change)) %>% slice(1:10)

ggplot(upc, aes(x = Abb, y = Change, pattern = Region, fill=Region)) +
    geom_col_pattern() 

#-----------------------------------------------------------------------
# 3.6 Adjusting Bar Width and Spacing
#-----------------------------------------------------------------------
# Load gcookbook for the pg_mean data set
# default width which is 0.9
ggplot(pg_mean, aes(x = group, y = weight)) + geom_col()

# narrow width
ggplot(pg_mean, aes(x = group, y = weight)) + geom_col(width = 0.5)

# grouped bar with narrow width and a gap between them

ggplot(cabbage_exp, aes(x = Date, y = Weight, fill = Cultivar)) +
    geom_col(width = 0.5, position = position_dodge(0.7))

#-----------------------------------------------------------------------
# 3.7 Making a Stacked Bar Graph
#-----------------------------------------------------------------------

# this is the default bhavoir for geom_col()
# in geom_col(), specify x,y in aes(), and fill by the third variable

ggplot(cabbage_exp, aes(x = Date, y = Weight, fill = Cultivar)) +
    geom_col()

#-----------------------------------------------------------------------
# 3.8 Making a Proportional Stacked Bar Graph
#-----------------------------------------------------------------------

# in the geom_col position = "fill" will normalize the graph height to 1.0
ggplot(cabbage_exp, aes(x = Date, y = Weight, fill = Cultivar)) +
    geom_col(position = "fill")

# to make y scale in percent the following code will work
ggplot(cabbage_exp, aes(x = Date, y = Weight, fill = Cultivar)) +
    geom_col(position = "fill") + 
    scale_y_continuous(labels = scales::percent)

#-----------------------------------------------------------------------
# 3.9 Adding Labels to a Bar Graph
#-----------------------------------------------------------------------

# geom_text used for labeling
# the label variable need to in aes()


ggplot(cabbage_exp, aes(x = Date, y = Weight, fill = Cultivar)) +
    geom_col(position = "dodge") +
    geom_text(aes(label = Weight), colour = "black", 
              vjust = 1.5, position = position_dodge(.9))


# if the position is stacked
ggplot(cabbage_exp, aes(x = Date, y = Weight, fill = Cultivar)) +
    geom_col() +
    geom_text(aes(label = Weight), colour = "black", 
              vjust = 1.5, position = position_stack())







