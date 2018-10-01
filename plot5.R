# Import rds data
if(!exists("NEI")){
    NEI <- readRDS("./data/summarySCC_PM25.rds")
}
if(!exists("SCC")){
    SCC <- readRDS("./data/Source_Classification_Code.rds")
}
# merge the two data sets 
if(!exists("mrgNEISCC")){
    mrgNEISCC <- merge(NEI, SCC, by="SCC")
}

library(ggplot2) # load package

# How have emissions from motor vehicle sources changed 
# from 1999–2008 in Baltimore City?

# 24510 means Baltimore, see plot2.R
# Filtering for ON-ROAD type in NEI
subsNEI <- NEI[NEI$fips == "24510" & NEI$type == "ON-ROAD",  ]
# aggreagated total by year
aggrTotByYr <- aggregate(Emissions ~ year, subsNEI, sum)

# plot and store as png
png("plot5.png", width = 720, height = 480)
p <- ggplot(data = aggrTotByYr, 
            mapping = aes(factor(year), Emissions)) +
    geom_bar(stat="identity", fill = "#696969") +
    theme_bw() +
    xlab("time (a)") +
    ylab(expression('total PM'[2.5]*" emissions")) +
    ggtitle('Total emissions from motor vehicle in Baltimore City, Maryland from 1999 to 2008')
print(p)
dev.off()
