# Import rds data
if(!exists("NEI")){
    NEI <- readRDS("./data/summarySCC_PM25.rds")
}
if(!exists("SCC")){
    SCC <- readRDS("./data/Source_Classification_Code.rds")
}

library(ggplot2) # load package

# Of the four types of sources indicated by the type 
# (point, nonpoint, onroad, nonroad) variable, 
# which of these four sources have seen decreases in emissions 
# from 1999 2008 for Baltimore City? 
# Which have seen increases in emissions from 1999 to 2008? 
# Use the ggplot2 plotting system to make a plot answer this question.

# 24510 is Baltimore, see plot2.R
subsNEI  <- NEI[NEI$fips == "24510", ] # create subset of NEI data set
# aggreagated total by year and type
aggrTotByYrAndType <- aggregate(Emissions ~ year + type, subsNEI, sum) 

# plot and store as png
png("plot3.png", width = 640, height = 480)
p <- ggplot(data = aggrTotByYrAndType, 
            mapping = aes(year, Emissions, color = type)) + 
    geom_line(size = 2) +
    theme_bw() +
    xlab("time (a)") +
    ylab(expression('total PM'[2.5]*" emissions")) +
    ggtitle('Total emissions in Baltimore City, Maryland between 1999 and 2008')
print(p)
dev.off()
