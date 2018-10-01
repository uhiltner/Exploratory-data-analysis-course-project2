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

# Across the United States, how have emissions from coal combustion-related 
# sources changed from 1999–2008?

# fetch all NEIxSCC records with Short.Name (SCC) Coal
coalMatch  <- grepl("coal", mrgNEISCC$Short.Name, ignore.case=TRUE)
# subset data
subsMrgNEISCC <- mrgNEISCC[coalMatch, ]
# aggreagated total by year
aggrTotByYr <- aggregate(Emissions ~ year, subsMrgNEISCC, sum) 

# plot and store as png
png("plot4.png", width = 640, height = 480)
p <- ggplot(data = aggrTotByYr, 
            mapping = aes(factor(year), Emissions)) +
    geom_bar(stat = "identity", fill = "#696969") +
    theme_bw() +
    xlab("time (a)") +
    ylab(expression('total PM'[2.5]*" emissions")) +
    ggtitle('Total emissions of coal sources between 1999 and 2008')
print(p)
dev.off()
