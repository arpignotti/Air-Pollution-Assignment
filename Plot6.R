# Download, unzip and read in data
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip", destfile = "./data.zip")
unzip("./data.zip")
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Subset out motor vehicle data for Baltimore and then Los Angeles
mvBaltNEI <- subset(NEI, type == "ON-ROAD" & fips == "24510")
mvLANEI <- subset(NEI, type == "ON-ROAD" & fips == "06037")

# Summarise total emissions for motor vehicles by year for Baltimore and then Los Angeles
library(plyr)
mvBaltSum <- ddply(mvBaltNEI,
              .(year),
              summarise,
              Emissions = sum(Emissions))
mvLASum <- ddply(mvLANEI,
                 .(year),
                 summarise,
                 Emissions = sum(Emissions))

# Generate and save two plots of motor vehicle emissions in Baltimore City and Los Angeles from 1999-2008
png(filename = "plot6.png", width = 960)
par(mfrow = c(1,2))
with(mvBaltSum,
     plot(year, Emissions,
          type = "l",
          xlab = "Year",
          ylab = "Motor Vehicle Emissions (Tons)",
          main = "Motor Vehicle Emissions\nin Baltimore City from 1999-2008"))
with(mvLASum,
     plot(year, Emissions,
          type = "l",
          xlab = "Year",
          ylab = "Motor Vehicle Emissions (Tons)",
          main = "Motor Vehicle Emissions\nin Los Angeles from 1999-2008"))
dev.off()