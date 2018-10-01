# Import rds data
if(!exists("NEI")){
    NEI <- readRDS("./data/summarySCC_PM25.rds")
}
if(!exists("SCC")){
    SCC <- readRDS("./data/Source_Classification_Code.rds")
}
#1. Question: Have total emissions from PM2.5 decreased in the United States 
# from 1999 to 2008? 
# Using the base plotting system, make a plot showing the total PM2.5 emission 
# from all sources for each of the years 1999, 2002, 2005, and 2008. 

aggrTotByYr <- aggregate(Emissions ~ year, NEI, sum) # aggreagated total by year

# plot and store as png
png('plot1.png')
barplot(height = aggrTotByYr$Emissions, 
        names.arg=aggrTotByYr$year, 
        xlab = "time (a)", 
        ylab = expression('total PM'[2.5]*' emission'),
        main = expression('Emissions of total PM'[2.5]*' over time'))
dev.off()
