# Download, unzip and read in data
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip", destfile = "./data.zip")
unzip("./data.zip")
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Summarize total emissions in Baltimore City by year and type
library(plyr)
baltSum2 <- ddply(subset(NEI, fips == 24510),
              .(year, type),
              summarise,
              Emissions = sum(Emissions))

# Generate and export line graphs of the summarized data above with graph representing a emission source type
png(filename = "plot3.png", height = 720)
library(ggplot2)
qplot(year, Emissions,
      data = baltSum2,
      geom = "line",
      facets = type ~ .,
      xlab = "Year",
      ylab = "Total Emissions (Tons)",
      main = expression("PM"[2.5]*" Emissions in Baltimore City by Source Type (1999-2008)"))
dev.off()