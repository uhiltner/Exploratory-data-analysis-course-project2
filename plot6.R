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

# 24510 is Baltimore, see plot2.R, 06037 is LA CA
# Searching for ON-ROAD type in NEI
subsNEI <- NEI[(NEI$fips == "24510" | NEI$fips=="06037") 
               & NEI$type == "ON-ROAD",  ]
# aggreagated total by year and fips
aggrTotByYrAndFps <- aggregate(Emissions ~ year + fips, subsNEI, sum)
aggrTotByYrAndFps$fips[aggrTotByYrAndFps$fips == "24510"] <- "Baltimore, MD"
aggrTotByYrAndFps$fips[aggrTotByYrAndFps$fips == "06037"] <- "Los Angeles, CA"

png("plot6.png", width = 1040, height = 480)
p <- ggplot(data = aggrTotByYrAndFps, 
            mapping = aes(factor(year), Emissions)) +
    facet_grid(. ~ fips) + 
    geom_bar(stat="identity", fill = "#696969")  +
    theme_bw() + 
    xlab("time (a)") +
    ylab(expression('total PM'[2.5]*" emissions")) +
    ggtitle('Total emissions from motor vehicle in \nBaltimore City, MD vs Los Angeles, CA between 1999-2008')
print(p)
dev.off()
