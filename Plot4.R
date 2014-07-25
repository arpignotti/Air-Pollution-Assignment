# Download, unzip and read in data
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip", destfile = "./data.zip")
unzip("./data.zip")
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Match and replace the SCC ID column in the NEI data with the short name column in the SCC data 
NEI$SCC <- SCC$Short.Name[match(NEI$SCC,SCC$SCC)]

# Create a new data frame rows that have combustion and coal in the short name column. Possibly not the most accurate sort, but I'm not knowledgeable in this area so I have little knowledge on how to refine this data anymore than this.
coalNEI <- NEI[grep("Comb.*Coal",
                    NEI$SCC,
                    ignore.case = TRUE), ]

# Summarize total emissions of coal combustion-related sources by year
library(plyr)
coalSum <- ddply(coalNEI,
              .(year),
              summarise,
              Emissions = sum(Emissions))

# Generate and export line graphs of the summarized data above
png(filename = "plot4.png", width = 800)
library(ggplot2)
qplot(year, Emissions,
      data = coalSum,
      geom = "line",
      xlab = "Year",
      ylab = "Coal Combustion-Related Emissions (Tons)",
      main = expression("PM"[2.5]*" Emissions from Coal Combustion-Related Sources in the United States (1999-2008)"))
dev.off()