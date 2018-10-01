# Import rds data
if(!exists("NEI")){
    NEI <- readRDS("./data/summarySCC_PM25.rds")
}
if(!exists("SCC")){
    SCC <- readRDS("./data/Source_Classification_Code.rds")
}

# Have total emissions from PM2.5 decreased in the Baltimore City, 
# Maryland (fips == "24510") from 1999 to 2008? 
# Use the base plotting system to make a plot answering this question.

subsNEI  <- NEI[NEI$fips == "24510", ] # create subset of NEI data set

aggrTotByYr <- aggregate(Emissions ~ year, NEI, sum) # aggreagated total by year

# plot and store as png
png('plot2.png')
barplot(height = aggrTotByYr$Emissions, 
        names.arg = aggrTotByYr$year, 
        xlab = "time (a)", 
        ylab = expression('total PM'[2.5]*' emission'),
        main = expression('Total PM'[2.5]*' in Baltimore City, MD emissions over time'))
dev.off()