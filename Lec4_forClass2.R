

########################################
# LECTURE 4, Part 2: Reading data from #
# csv files and and manipulating them  #
########################################

# See Section 6.1 and 5.1 in "R for Everyone". 


# Set the working directory to the folder
# where you have the csv files from the SNB

setwd("YOUR DIRECTORY!!!")

# Note the forward slashes in the directory!!!!!

# On a Mac it may look like this
#setwd("/Users/Thomas/Dropbox/Programmierkurs/Data")
# On Windows it may look like this
#setwd("D:/Programmierkurs/Data")


# Load the data... Which one
# works for you?

rawData = read.csv(file = "SNB Xrates downloaded.csv")

rawXrates = read.csv(file = "SNB Xrates downloaded clean.csv")

rawXrates = read.csv(file = "SNB Xrates downloaded clean.csv", sep = ",")


# In my case, there are still the empty rows and columns. 
# However, even if you do not have them, you can execute 
# the below commands

# What is the type of rawXrates?
class(rawXrates)

# Get the names of the columns ("variables"
# in the statistical sense)
names(rawXrates)

# You can use the names to get a column

rawXrates["Date"]

head(rawXrates["Date"])

# Use this trick to select only the variables we are interested in

varList = c("Date", "D0", "D1", "Value")

rawXrates = rawXrates[varList]

head(rawXrates)

# So we got rid of the empty columns!

save(rawXrates, file = "rawXrates.RData")

rm(rawXrates)
load("rawXrates.RData")


# The data looks really enormously big
# Let's say we only care about data from 2010 on
# to start with...

# The next lines of code are preparations for
# data from 2010 on (or any other year)


#install.packages("stringr")
library(stringr)

Xrates = rawXrates

Xrates$year = as.numeric(  substr(Xrates$Date, start = 1, stop = 4)  )

Xrates$month = as.numeric(  substr(Xrates$Date, start = 6, stop = 7)  )

# A unique identifier for time
Xrates$timeID = Xrates$year + (Xrates$month-1)/12

Xrates = Xrates[Xrates$year>=2010, ]


# Next we get rid of other information we are not interested in...
unique(Xrates$D0)

Xrates = Xrates[Xrates$D0 == "M0", ]


# And we select data on just the EUR exchange rate

unique(Xrates$D1)

Xrates = Xrates[Xrates$D1 == "EUR1", ]



plot(Xrates$timeID, Xrates$Value, type = "l", col = "red3")

