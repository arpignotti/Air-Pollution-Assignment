# Download, unzip and read in data
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip", destfile = "./data.zip")
unzip("./data.zip")
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Summarize by total emissions per year in Baltimore City
library(plyr)
baltSum <- ddply(subset(NEI, fips == 24510),
              .(year),
              summarise,
              Emissions = sum(Emissions))

# Generate and export a line graph of the summarized data above
png(filename = "plot2.png")
par(mar=c(5,5,5,5))
with(baltSum,
     plot(year, Emissions,
          type = "l",
          main = expression("Decline of Total PM"[2.5]*" Emissions in Baltimore City (1999-2008)"),
          ylab = "Total Emissions (Tons)",
          xlab = "Year"))
dev.off()