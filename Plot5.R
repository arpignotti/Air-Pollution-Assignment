# Download, unzip and read in data
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip", destfile = "./data.zip")
unzip("./data.zip")
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Subset out motor vehicle data for Baltimore
mvBaltNEI <- subset(NEI, type == "ON-ROAD" & fips == 24510)

# Summarise total emissions for motor vehicles by year 
library(plyr)
mvBaltSum <- ddply(mvBaltNEI,
              .(year),
              summarise,
              Emissions = sum(Emissions))

# Generate and save plot of motor vehicle emissions in Baltimore City from 1999-2008
png(filename = "plot5.png")
library(ggplot2)
qplot(year, Emissions,
      data = mvBaltSum,
      geom = "line",
      xlab = "Year",
      ylab = "Motor Vehicle Emissions (Tons)",
      main = "Motor Vehicle Emissions in Baltimore City from 1999-2008")
dev.off()