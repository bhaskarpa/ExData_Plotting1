#
# R-Script for plotting the histogram for the Global Active Power for the 2 days in Feb 1st and 2nd 2007.
#
# This script will do the following:
#    1) Read the data file for the specified date range Feb 1 2007 to Feb 2 2007
#    2) Convert the seperate date,time string columns into a datetime class.
#    3) Drop the seperate Date and Time columns from the table.
#    4) Create a histogram plot and store it in the png file "plot1.png"
#
loadDataAndCreatePlot1 <- function(dataLocation) {
    #
    # Initialize the dependencies
    #
    options(sqldf.driver="SQLite")
    options(gsubfn.engine="R")
    library(RMySQL)
    library(sqldf)
    #
    # Open a file handle to the data location.
    #
    fi <- file(dataLocation)
    #
    # Read only the required data within the data within the date range Feb 1 to Feb 2 2007
    #
    df <- sqldf("select * from fi where Date in ('1/2/2007', '2/2/2007')", file.format = list(header=TRUE, sep=";"), drv="SQLite")
    close(fi)
    #
    # Combine Date and Time columns and convert to POSIXct format and store it in new column datetime
    #
    df <- within(df, datetime <- as.POSIXct(paste(Date, Time), format="%d/%m/%Y %H:%M:%S"))
    png(file="plot1.png", width=480, height=480)
    hist(df$Global_active_power, col="red", main="Global Active Power", xlab="Global Active Power(killowatts)", ylab="Frequency")
    dev.off()
}