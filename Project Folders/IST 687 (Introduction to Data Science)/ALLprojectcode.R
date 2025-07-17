

#Install arrow to read Parquet
install.packages("arrow")
install.packages("arrow", type = "source")
arrow::install_arrow()
library(arrow)

#----------------House Data-------------------------------------------

#Read in static_house parquest and make copy
static_house_data <- read_parquet("Downloads/static_house_info.parquet")
static_house_data
static_house_dataEDA<-static_house_data

#Static House data for just building 102063
EnergyExample<-static_house_dataEDA %>% filter(bldg_id ==102063)

#Find and remove redundant columns with no unique values
str(static_house_data)
str(static_house_dataEDA)
unique(static_house_dataEDA$upgrade.insulation_foundation_wall) 

static_house_dataEDAcleanedcolumns<-static_house_dataEDA[,-c(2,3,4,6,7,8,12,14,15,16, 26, 29, 31,32,
                                                             34,35,36,37,38,39,40,41,42,43,44,45,47,
                                                             49,50,51,52,53,54,55,56,63,72,73,79,84,
                                                             85,86,87,88,89,90,91,103,104,106,107,108
                                                             ,109,120,121,124,126,131,136,137,138,139,
                                                             140,141,142,143,144,146,153,159,161,162,
                                                             163,165,166,167,168,169)]


library(tidyverse)

#Static House data for buildings in the hottest county (27houses)
HotHouses<-static_house_dataEDAcleanedcolumns %>% filter(in.county == "G4500530")

#Static House data for buildings in the "coldest" county (68houses)
ColdHouses<-static_house_dataEDAcleanedcolumns %>% filter(in.county == "G4500210")



#--------Weather Data---------------------------------------------


#Create Weather df for July, delete other months and keep only column for temperature(converted into Fahrenheit)
WeatherDataJuly<-WeatherData[-1:-4343,]
WeatherDataJuly<-WeatherDataJuly[-745:-749,]
WeatherDataJuly<-WeatherDataJuly[,-4:-8]
WeatherDataJuly$Fahrenheit<-WeatherDataJuly$`Dry Bulb Temperature [Â°C]`*(9/5)+32



#Group Weather Data by Month 
class(WeatherData$date_time)
WeatherData$date_time<-as.character.Date(WeatherData$date_time)
WeatherData$month<-(substr(WeatherData$date_time,6,7))

WeatherGrouped<-WeatherData %>%
  group_by(month) %>%
  summarise(Avg_Monthly_Temp = mean(`Dry Bulb Temperature [Â°C]`))
WeatherGrouped



#Group July Weather Data by Day
class(WeatherDataJuly$date_time)
WeatherDataJuly$date_time<-as.character.Date(WeatherDataJuly$date_time)
WeatherDataJuly$day<-(substr(WeatherDataJuly$date_time,9,10))

WeatherGroupedJuly<-WeatherDataJuly %>%
  group_by(day) %>%
  summarise(Avg_Daily_Temp = mean(Fahrenheit))
WeatherGroupedJuly

WeatherGroupedJuly[which.max(WeatherGroupedJuly$Avg_Daily_Temp),] 


#Plot temperature and time to see trends in temperature over the year/in July
ggplot(WeatherDataJuly) + aes(x=WeatherDataJuly$date_time,y=WeatherDataJuly$Fahrenheit)+geom_line() 
ggplot(WeatherData) + aes(x=WeatherData$date_time, y=WeatherData$`Dry Bulb Temperature [Â°C]`) + geom_line() 


#Max Temp in June, hottest overall month is also June
WeatherData[which.max(WeatherData$`Dry Bulb Temperature [Â°C]`),]
WeatherGrouped[which.max(WeatherGrouped$Avg_Monthly_Temp),] 


#Attempted function to create code to run all csv files
library(tidyverse)

read_in_weatherfiles <- function(in.county) {
  common_url<- "https://intro-datascience.s3.us-east-2.amazonaws.com/SC-data/weather/2023-weather-data/"
  county_id<- unique(static_house_dataEDAcleanedcolumns$in.county)
  csv<-".csv')"
  url<-paste(common_url,county_id,csv, sep="")
  run<-paste("weather",county_id, "<-", "read_csv('", url, sep="")
  return(run)
}
read_in_weatherfiles()   


#Manually read in weather files for all counties
unique(static_house_dataEDAcleanedcolumns$in.county)

weatherG4500910<-read_csv('https://intro-datascience.s3.us-east-2.amazonaws.com/SC-data/weather/2023-weather-data/G4500910.csv')
weatherG4500730<-read_csv('https://intro-datascience.s3.us-east-2.amazonaws.com/SC-data/weather/2023-weather-data/G4500730.csv')
weatherG4500710<-read_csv('https://intro-datascience.s3.us-east-2.amazonaws.com/SC-data/weather/2023-weather-data/G4500710.csv')
weatherG4500790<-read_csv('https://intro-datascience.s3.us-east-2.amazonaws.com/SC-data/weather/2023-weather-data/G4500790.csv')
weatherG4500450<-read_csv('https://intro-datascience.s3.us-east-2.amazonaws.com/SC-data/weather/2023-weather-data/G4500450.csv')
weatherG4500150<-read_csv('https://intro-datascience.s3.us-east-2.amazonaws.com/SC-data/weather/2023-weather-data/G4500150.csv')
weatherG4500350<-read_csv('https://intro-datascience.s3.us-east-2.amazonaws.com/SC-data/weather/2023-weather-data/G4500350.csv')
weatherG4500190<-read_csv('https://intro-datascience.s3.us-east-2.amazonaws.com/SC-data/weather/2023-weather-data/G4500190.csv')
weatherG4500830<-read_csv('https://intro-datascience.s3.us-east-2.amazonaws.com/SC-data/weather/2023-weather-data/G4500830.csv')
weatherG4500510<-read_csv('https://intro-datascience.s3.us-east-2.amazonaws.com/SC-data/weather/2023-weather-data/G4500510.csv')
weatherG4500070<-read_csv('https://intro-datascience.s3.us-east-2.amazonaws.com/SC-data/weather/2023-weather-data/G4500070.csv')
weatherG4500670<-read_csv('https://intro-datascience.s3.us-east-2.amazonaws.com/SC-data/weather/2023-weather-data/G4500670.csv')
weatherG4500750<-read_csv('https://intro-datascience.s3.us-east-2.amazonaws.com/SC-data/weather/2023-weather-data/G4500750.csv')
weatherG4500290<-read_csv('https://intro-datascience.s3.us-east-2.amazonaws.com/SC-data/weather/2023-weather-data/G4500290.csv')
weatherG4500490<-read_csv('https://intro-datascience.s3.us-east-2.amazonaws.com/SC-data/weather/2023-weather-data/G4500490.csv')
weatherG4500130<-read_csv('https://intro-datascience.s3.us-east-2.amazonaws.com/SC-data/weather/2023-weather-data/G4500130.csv')
weatherG4500630<-read_csv('https://intro-datascience.s3.us-east-2.amazonaws.com/SC-data/weather/2023-weather-data/G4500630.csv')
weatherG4500870<-read_csv('https://intro-datascience.s3.us-east-2.amazonaws.com/SC-data/weather/2023-weather-data/G4500870.csv')
weatherG4500550<-read_csv('https://intro-datascience.s3.us-east-2.amazonaws.com/SC-data/weather/2023-weather-data/G4500550.csv')
weatherG4500010<-read_csv('https://intro-datascience.s3.us-east-2.amazonaws.com/SC-data/weather/2023-weather-data/G4500010.csv')
weatherG4500430<-read_csv('https://intro-datascience.s3.us-east-2.amazonaws.com/SC-data/weather/2023-weather-data/G4500430.csv')
weatherG4500890<-read_csv('https://intro-datascience.s3.us-east-2.amazonaws.com/SC-data/weather/2023-weather-data/G4500890.csv')
weatherG4500850<-read_csv('https://intro-datascience.s3.us-east-2.amazonaws.com/SC-data/weather/2023-weather-data/G4500850.csv')
weatherG4500770<-read_csv('https://intro-datascience.s3.us-east-2.amazonaws.com/SC-data/weather/2023-weather-data/G4500770.csv')
weatherG4500030<-read_csv('https://intro-datascience.s3.us-east-2.amazonaws.com/SC-data/weather/2023-weather-data/G4500030.csv')
weatherG4500590<-read_csv('https://intro-datascience.s3.us-east-2.amazonaws.com/SC-data/weather/2023-weather-data/G4500590.csv')
weatherG4500610<-read_csv('https://intro-datascience.s3.us-east-2.amazonaws.com/SC-data/weather/2023-weather-data/G4500610.csv')
weatherG4500250<-read_csv('https://intro-datascience.s3.us-east-2.amazonaws.com/SC-data/weather/2023-weather-data/G4500250.csv')
weatherG4500530<-read_csv('https://intro-datascience.s3.us-east-2.amazonaws.com/SC-data/weather/2023-weather-data/G4500530.csv')
weatherG4500210<-read_csv('https://intro-datascience.s3.us-east-2.amazonaws.com/SC-data/weather/2023-weather-data/G4500210.csv')
weatherG4500410<-read_csv('https://intro-datascience.s3.us-east-2.amazonaws.com/SC-data/weather/2023-weather-data/G4500410.csv')
weatherG4500570<-read_csv('https://intro-datascience.s3.us-east-2.amazonaws.com/SC-data/weather/2023-weather-data/G4500570.csv')
weatherG4500690<-read_csv('https://intro-datascience.s3.us-east-2.amazonaws.com/SC-data/weather/2023-weather-data/G4500690.csv')
weatherG4500310<-read_csv('https://intro-datascience.s3.us-east-2.amazonaws.com/SC-data/weather/2023-weather-data/G4500310.csv')
weatherG4500090<-read_csv('https://intro-datascience.s3.us-east-2.amazonaws.com/SC-data/weather/2023-weather-data/G4500090.csv')
weatherG4500470<-read_csv('https://intro-datascience.s3.us-east-2.amazonaws.com/SC-data/weather/2023-weather-data/G4500470.csv')
weatherG4500050<-read_csv('https://intro-datascience.s3.us-east-2.amazonaws.com/SC-data/weather/2023-weather-data/G4500050.csv')
weatherG4500330<-read_csv('https://intro-datascience.s3.us-east-2.amazonaws.com/SC-data/weather/2023-weather-data/G4500330.csv')
weatherG4500650<-read_csv('https://intro-datascience.s3.us-east-2.amazonaws.com/SC-data/weather/2023-weather-data/G4500650.csv')
weatherG4500230<-read_csv('https://intro-datascience.s3.us-east-2.amazonaws.com/SC-data/weather/2023-weather-data/G4500230.csv')
weatherG4500270<-read_csv('https://intro-datascience.s3.us-east-2.amazonaws.com/SC-data/weather/2023-weather-data/G4500270.csv')
weatherG4500370<-read_csv('https://intro-datascience.s3.us-east-2.amazonaws.com/SC-data/weather/2023-weather-data/G4500370.csv')
weatherG4500110<-read_csv('https://intro-datascience.s3.us-east-2.amazonaws.com/SC-data/weather/2023-weather-data/G4500110.csv')
weatherG4500170<-read_csv('https://intro-datascience.s3.us-east-2.amazonaws.com/SC-data/weather/2023-weather-data/G4500170.csv')
weatherG4500390<-read_csv('https://intro-datascience.s3.us-east-2.amazonaws.com/SC-data/weather/2023-weather-data/G4500390.csv')
weatherG4500810<-read_csv('https://intro-datascience.s3.us-east-2.amazonaws.com/SC-data/weather/2023-weather-data/G4500810.csv')


#Unique Counties
"G4500790" "G4500450" "G4500150" "G4500350" "G4500190"
"G4500830" "G4500510" "G4500070" "G4500670" "G4500750" "G4500290" "G4500490" "G4500130"
"G4500630" "G4500870" "G4500550" "G4500010" "G4500430" "G4500890" "G4500850" "G4500770"
"G4500030" "G4500590" "G4500610" "G4500250" "G4500530" "G4500210" "G4500410" "G4500570"
"G4500690" "G4500310" "G4500090" "G4500470" "G4500050" "G4500330" "G4500650" "G4500230"
"G4500270" "G4500370" "G4500110" "G4500170" "G4500390" "G4500810"


TESTweatherG4500690<-weatherG4500690
TESTweatherG4500690<-TESTweatherG4500690[-1:-4343,]
TESTweatherG4500690<-TESTweatherG4500690[-745:-749,]
TESTweatherG4500690<-TESTweatherG4500690[,-4:-8]




Group_weatherfiles <- function(df) {
  dfJuly<-df
  dfJuly<-dfJuly[-1:-4343,]
  dfJuly<-dfJuly[-745:-749,]
  dfJuly<-dfJuly[,-4:-8]
  dfJuly$date_time<-as.character.Date(dfJuly$date_time)
  dfJuly$day<-(substr(dfJuly$date_time,9,10))
  dfJuly<-dfJuly %>%
    group_by(day) %>%
    summarise(Avg_Daily_Temp = mean(`Dry Bulb Temperature [°C]`))
  return(dfJuly) 
}

#Grouped Weather Files (Grouped by day for month of July)
weatherG4500810<-Group_weatherfiles(weatherG4500810)
weatherG4500190<-Group_weatherfiles(weatherG4500190)
weatherG4500910<-Group_weatherfiles(weatherG4500910)
weatherG4500730<-Group_weatherfiles(weatherG4500730)
weatherG4500710<-Group_weatherfiles(weatherG4500710)
weatherG4500790<-Group_weatherfiles(weatherG4500790)
weatherG4500450<-Group_weatherfiles(weatherG4500450)
weatherG4500150<-Group_weatherfiles(weatherG4500150)
weatherG4500350<-Group_weatherfiles(weatherG4500350)
weatherG4500830<-Group_weatherfiles(weatherG4500830)
weatherG4500510<-Group_weatherfiles(weatherG4500510)
weatherG4500070<-Group_weatherfiles(weatherG4500070)
weatherG4500670<-Group_weatherfiles(weatherG4500670)
weatherG4500750<-Group_weatherfiles(weatherG4500750)
weatherG4500290<-Group_weatherfiles(weatherG4500290)
weatherG4500490<-Group_weatherfiles(weatherG4500490)
weatherG4500130<-Group_weatherfiles(weatherG4500130)
weatherG4500630<-Group_weatherfiles(weatherG4500630)
weatherG4500870<-Group_weatherfiles(weatherG4500870)
weatherG4500550<-Group_weatherfiles(weatherG4500550)
weatherG4500010<-Group_weatherfiles(weatherG4500010)
weatherG4500430<-Group_weatherfiles(weatherG4500430)
weatherG4500890<-Group_weatherfiles(weatherG4500890)
weatherG4500850<-Group_weatherfiles(weatherG4500850)
weatherG4500770<-Group_weatherfiles(weatherG4500770)
weatherG4500030<-Group_weatherfiles(weatherG4500030)
weatherG4500590<-Group_weatherfiles(weatherG4500590)
weatherG4500610<-Group_weatherfiles(weatherG4500610)
weatherG4500250<-Group_weatherfiles(weatherG4500250)
weatherG4500530<-Group_weatherfiles(weatherG4500530)
weatherG4500210<-Group_weatherfiles(weatherG4500210)
weatherG4500410<-Group_weatherfiles(weatherG4500410)
weatherG4500570<-Group_weatherfiles(weatherG4500570)
weatherG4500690<-Group_weatherfiles(weatherG4500690)
weatherG4500310<-Group_weatherfiles(weatherG4500310)
weatherG4500090<-Group_weatherfiles(weatherG4500090)
weatherG4500470<-Group_weatherfiles(weatherG4500470)
weatherG4500050<-Group_weatherfiles(weatherG4500050)
weatherG4500330<-Group_weatherfiles(weatherG4500330)
weatherG4500650<-Group_weatherfiles(weatherG4500650)
weatherG4500230<-Group_weatherfiles(weatherG4500230)
weatherG4500270<-Group_weatherfiles(weatherG4500270)
weatherG4500370<-Group_weatherfiles(weatherG4500370)
weatherG4500110<-Group_weatherfiles(weatherG4500110)
weatherG4500170<-Group_weatherfiles(weatherG4500170)
weatherG4500390<-Group_weatherfiles(weatherG4500390)

#Plot Avg Temps
ggplot() + 
  geom_line(data=weatherG4500810, aes(x=day, y=Avg_Daily_Temp, group=1), color='blue') + 
  geom_line(data=weatherG4500190, aes(x=day, y=Avg_Daily_Temp, group=1), color='red1') +
  geom_line(data=weatherG4500910, aes(x=day, y=Avg_Daily_Temp, group=1), color='chartreuse') +
  geom_line(data=weatherG4500730, aes(x=day, y=Avg_Daily_Temp, group=1), color='pink') +
  geom_line(data=weatherG4500710, aes(x=day, y=Avg_Daily_Temp, group=1), color='purple') +
  geom_line(data=weatherG4500790, aes(x=day, y=Avg_Daily_Temp, group=1), color='orange') +
  geom_line(data=weatherG4500450, aes(x=day, y=Avg_Daily_Temp, group=1), color='yellow') +
  geom_line(data=weatherG4500150, aes(x=day, y=Avg_Daily_Temp, group=1), color='tan') +
  geom_line(data=weatherG4500350, aes(x=day, y=Avg_Daily_Temp, group=1), color='lightblue') +
  geom_line(data=weatherG4500830, aes(x=day, y=Avg_Daily_Temp, group=1), color='darkgreen') +
  geom_line(data=weatherG4500510, aes(x=day, y=Avg_Daily_Temp, group=1), color='gray') +
  geom_line(data=weatherG4500070, aes(x=day, y=Avg_Daily_Temp, group=1), color='hotpink') +
  geom_line(data=weatherG4500670, aes(x=day, y=Avg_Daily_Temp, group=1), color='lavender') +
  geom_line(data=weatherG4500750, aes(x=day, y=Avg_Daily_Temp, group=1), color='turquoise') +
  geom_line(data=weatherG4500290, aes(x=day, y=Avg_Daily_Temp, group=1), color='chocolate4') +
  geom_line(data=weatherG4500490, aes(x=day, y=Avg_Daily_Temp, group=1), color='palegreen') +
  geom_line(data=weatherG4500130, aes(x=day, y=Avg_Daily_Temp, group=1), color='navy') +
  geom_line(data=weatherG4500630, aes(x=day, y=Avg_Daily_Temp, group=1), color='gold') +
  geom_line(data=weatherG4500870, aes(x=day, y=Avg_Daily_Temp, group=1), color='cyan') +
  geom_line(data=weatherG4500550, aes(x=day, y=Avg_Daily_Temp, group=1), color='peru') +
  geom_line(data=weatherG4500010, aes(x=day, y=Avg_Daily_Temp, group=1), color='cornflowerblue') +
  geom_line(data=weatherG4500430, aes(x=day, y=Avg_Daily_Temp, group=1), color='maroon') +
  geom_line(data=weatherG4500890, aes(x=day, y=Avg_Daily_Temp, group=1), color='tomato') +
  geom_line(data=weatherG4500850, aes(x=day, y=Avg_Daily_Temp, group=1), color='slateblue') +
  geom_line(data=weatherG4500770, aes(x=day, y=Avg_Daily_Temp, group=1), color='honeydew') +
  geom_line(data=weatherG4500030, aes(x=day, y=Avg_Daily_Temp, group=1), color='violet') +
  geom_line(data=weatherG4500590, aes(x=day, y=Avg_Daily_Temp, group=1), color='olivedrab') +
  geom_line(data=weatherG4500610, aes(x=day, y=Avg_Daily_Temp, group=1), color='antiquewhite') +
  geom_line(data=weatherG4500250, aes(x=day, y=Avg_Daily_Temp, group=1), color='orangered1') +
  geom_line(data=weatherG4500530, aes(x=day, y=Avg_Daily_Temp, group=1), color='black') +
  geom_line(data=weatherG4500210, aes(x=day, y=Avg_Daily_Temp, group=1), color='black') +
  geom_line(data=weatherG4500410, aes(x=day, y=Avg_Daily_Temp, group=1), color='darkmagenta') +
  geom_line(data=weatherG4500570, aes(x=day, y=Avg_Daily_Temp, group=1), color='azure') +
  geom_line(data=weatherG4500690, aes(x=day, y=Avg_Daily_Temp, group=1), color='forestgreen') +
  geom_line(data=weatherG4500310, aes(x=day, y=Avg_Daily_Temp, group=1), color='khaki1') +
  geom_line(data=weatherG4500090, aes(x=day, y=Avg_Daily_Temp, group=1), color='yellowgreen') +
  geom_line(data=weatherG4500470, aes(x=day, y=Avg_Daily_Temp, group=1), color='darkcyan') +
  geom_line(data=weatherG4500050, aes(x=day, y=Avg_Daily_Temp, group=1), color='mediumorchid') +
  geom_line(data=weatherG4500650, aes(x=day, y=Avg_Daily_Temp, group=1), color='thistle') +
  geom_line(data=weatherG4500230, aes(x=day, y=Avg_Daily_Temp, group=1), color='wheat') +
  geom_line(data=weatherG4500270, aes(x=day, y=Avg_Daily_Temp, group=1), color='firebrick') +
  geom_line(data=weatherG4500370, aes(x=day, y=Avg_Daily_Temp, group=1), color='darkorange') +
  geom_line(data=weatherG4500110, aes(x=day, y=Avg_Daily_Temp, group=1), color='beige') +
  geom_line(data=weatherG4500170, aes(x=day, y=Avg_Daily_Temp, group=1), color='mediumspringgreen') +
  geom_line(data=weatherG4500390, aes(x=day, y=Avg_Daily_Temp, group=1), color='ghostwhite') +
  geom_line(data=weatherG4500330, aes(x=day, y=Avg_Daily_Temp, group=1), color='aquamarine') 


#Highest Avg Temps in county G4500530
geom_line(data=weatherG4500530, aes(x=day, y=Avg_Daily_Temp, group=1), color='black')


#Lowest Avg Temps in county G4500210

#---------------Energy Data Bldg 102063--------------------------------------

#Read in energy data for building 102063 and make a copy of just July data
energy_usage_102063 <- read_parquet("Downloads/102063.parquet")
energy_usage_102063_July<-energy_usage_102063

#Parse time column to get just the month
energy_usage_102063_July$date<-as.character.Date(energy_usage_102063_July$time)
energy_usage_102063_July$month<-(substr(energy_usage_102063_July$date,6,7))
class(energy_usage_102063_July$month)

#Filter month=7 to get July data only
library(tidyverse)
energy_usage_102063_July<- energy_usage_102063_July %>% filter(month=="07")
summary(energy_usage_102063_July)


#Run basic hist and summary comparing overall energy year over the year to energy consumption in July
#for (out.electricity.cooling.energy_consumption) variable

#July
hist(energy_usage_102063_July$out.electricity.cooling.energy_consumption)
summary(energy_usage_102063_July$out.electricity.cooling.energy_consumption)

#Overall
hist(energy_usage_102063$out.electricity.cooling.energy_consumption)
summary(energy_usage_102063$out.electricity.cooling.energy_consumption)

#Plot 
library(ggplot2)
ggplot(energy_usage_102063) + aes(x=energy_usage_102063$time,y=energy_usage_102063$out.electricity.cooling.energy_consumption)+geom_line()
ggplot(energy_usage_102063_July) + aes(x=energy_usage_102063_July$time,y=energy_usage_102063_July$out.electricity.cooling.energy_consumption)+geom_line()                                

#Group by Day for July
#Create day column as substring of date column
energy_usage_102063_July$date<-as.character.Date(energy_usage_102063_July$time)
energy_usage_102063_July$day<-(substr(energy_usage_102063_July$date,9,10))

#Make character variables numeric for grouping purposes
energy_usage_102063_July$time<-as.numeric(energy_usage_102063_July$time)
energy_usage_102063_July$date<-as.numeric(energy_usage_102063_July$date)
energy_usage_102063_July$month<-as.numeric(energy_usage_102063_July$month)
energy_usage_102063_July$day<-as.numeric(energy_usage_102063_July$day)

#Group by average all the columns over day of July
energy_usage_102063_July_Grouped<- energy_usage_102063_July %>%
  group_by(day) %>%
  summarise_all(mean)
energy_usage_102063_July_Grouped


#July 3rd used the most cooling energy
energy_usage_102063_July_Grouped[which.max(energy_usage_102063_July_Grouped$out.electricity.cooling.energy_consumption),]

#Plot
ggplot(energy_usage_102063_July) + aes(x=energy_usage_102063_July$time,y=energy_usage_102063_July$out.electricity.cooling.energy_consumption)+geom_line()
ggplot(energy_usage_102063_July_Grouped) + aes(x=energy_usage_102063_July_Grouped$day,y=energy_usage_102063_July_Grouped$out.electricity.cooling.energy_consumption)+geom_line()



#Function to read in energy files for selected county
read_in_energyfiles <- function(bldg_id) {
  common_url<- "https://intro-datascience.s3.us-east-2.amazonaws.com/SC-data/2023-houseData/"
  bldg_id<- HotHouses$bldg_id
  parquet<-".parquet')"
  url<-paste(common_url,bldg_id,parquet, sep="")
  run<-paste("energy",bldg_id, "<-", "read_parquet('", url, sep="")
  return(run)
}
read_in_energyfiles(HotHouses$bldg_id) 

#Energy files for hottest county G4500690
energy9590<-read_parquet('https://intro-datascience.s3.us-east-2.amazonaws.com/SC-data/2023-houseData/9590.parquet')    
energy20799<-read_parquet('https://intro-datascience.s3.us-east-2.amazonaws.com/SC-data/2023-houseData/20799.parquet')  
energy42807<-read_parquet('https://intro-datascience.s3.us-east-2.amazonaws.com/SC-data/2023-houseData/42807.parquet')  
energy45565<-read_parquet('https://intro-datascience.s3.us-east-2.amazonaws.com/SC-data/2023-houseData/45565.parquet')  
energy51955<-read_parquet('https://intro-datascience.s3.us-east-2.amazonaws.com/SC-data/2023-houseData/51955.parquet')  
energy89793<-read_parquet('https://intro-datascience.s3.us-east-2.amazonaws.com/SC-data/2023-houseData/89793.parquet')  
energy114167<-read_parquet('https://intro-datascience.s3.us-east-2.amazonaws.com/SC-data/2023-houseData/114167.parquet')
energy126714<-read_parquet('https://intro-datascience.s3.us-east-2.amazonaws.com/SC-data/2023-houseData/126714.parquet')
energy142919<-read_parquet('https://intro-datascience.s3.us-east-2.amazonaws.com/SC-data/2023-houseData/142919.parquet')
energy169672<-read_parquet('https://intro-datascience.s3.us-east-2.amazonaws.com/SC-data/2023-houseData/169672.parquet')
energy174809<-read_parquet('https://intro-datascience.s3.us-east-2.amazonaws.com/SC-data/2023-houseData/174809.parquet')
energy181726<-read_parquet('https://intro-datascience.s3.us-east-2.amazonaws.com/SC-data/2023-houseData/181726.parquet')
energy187030<-read_parquet('https://intro-datascience.s3.us-east-2.amazonaws.com/SC-data/2023-houseData/187030.parquet')
energy192420<-read_parquet('https://intro-datascience.s3.us-east-2.amazonaws.com/SC-data/2023-houseData/192420.parquet')
energy209925<-read_parquet('https://intro-datascience.s3.us-east-2.amazonaws.com/SC-data/2023-houseData/209925.parquet')
energy275868<-read_parquet('https://intro-datascience.s3.us-east-2.amazonaws.com/SC-data/2023-houseData/275868.parquet')
energy276948<-read_parquet('https://intro-datascience.s3.us-east-2.amazonaws.com/SC-data/2023-houseData/276948.parquet')
energy289369<-read_parquet('https://intro-datascience.s3.us-east-2.amazonaws.com/SC-data/2023-houseData/289369.parquet')
energy290138<-read_parquet('https://intro-datascience.s3.us-east-2.amazonaws.com/SC-data/2023-houseData/290138.parquet')
energy295891<-read_parquet('https://intro-datascience.s3.us-east-2.amazonaws.com/SC-data/2023-houseData/295891.parquet')
energy296938<-read_parquet('https://intro-datascience.s3.us-east-2.amazonaws.com/SC-data/2023-houseData/296938.parquet')
energy357971<-read_parquet('https://intro-datascience.s3.us-east-2.amazonaws.com/SC-data/2023-houseData/357971.parquet')
energy360863<-read_parquet('https://intro-datascience.s3.us-east-2.amazonaws.com/SC-data/2023-houseData/360863.parquet')
energy363396<-read_parquet('https://intro-datascience.s3.us-east-2.amazonaws.com/SC-data/2023-houseData/363396.parquet')
energy436552<-read_parquet('https://intro-datascience.s3.us-east-2.amazonaws.com/SC-data/2023-houseData/436552.parquet')
energy495411<-read_parquet('https://intro-datascience.s3.us-east-2.amazonaws.com/SC-data/2023-houseData/495411.parquet')
energy505669<-read_parquet('https://intro-datascience.s3.us-east-2.amazonaws.com/SC-data/2023-houseData/505669.parquet')


#Function to read in energy files for selected county
read_in_energyfiles <- function(bldg_id) {
  common_url<- "https://intro-datascience.s3.us-east-2.amazonaws.com/SC-data/2023-houseData/"
  bldg_id<- ColdHouses$bldg_id
  parquet<-".parquet')"
  url<-paste(common_url,bldg_id,parquet, sep="")
  run<-paste("energy",bldg_id, "<-", "read_parquet('", url, sep="")
  return(run)
}
read_in_energyfiles(ColdHouses$bldg_id) 

#Energy files for "coldest" county
energy9756<-read_parquet('https://intro-datascience.s3.us-east-2.amazonaws.com/SC-data/2023-houseData/9756.parquet')   
energy21893<-read_parquet('https://intro-datascience.s3.us-east-2.amazonaws.com/SC-data/2023-houseData/21893.parquet')  
energy32634<-read_parquet('https://intro-datascience.s3.us-east-2.amazonaws.com/SC-data/2023-houseData/32634.parquet') 
energy38693<-read_parquet('https://intro-datascience.s3.us-east-2.amazonaws.com/SC-data/2023-houseData/38693.parquet') 
energy42264<-read_parquet('https://intro-datascience.s3.us-east-2.amazonaws.com/SC-data/2023-houseData/42264.parquet') 
energy62053<-read_parquet('https://intro-datascience.s3.us-east-2.amazonaws.com/SC-data/2023-houseData/62053.parquet') 
energy65081<-read_parquet('https://intro-datascience.s3.us-east-2.amazonaws.com/SC-data/2023-houseData/65081.parquet')  
energy70556<-read_parquet('https://intro-datascience.s3.us-east-2.amazonaws.com/SC-data/2023-houseData/70556.parquet')  
energy73790<-read_parquet('https://intro-datascience.s3.us-east-2.amazonaws.com/SC-data/2023-houseData/73790.parquet')  
energy84593<-read_parquet('https://intro-datascience.s3.us-east-2.amazonaws.com/SC-data/2023-houseData/84593.parquet')  
energy86055<-read_parquet('https://intro-datascience.s3.us-east-2.amazonaws.com/SC-data/2023-houseData/86055.parquet')  
energy93405<-read_parquet('https://intro-datascience.s3.us-east-2.amazonaws.com/SC-data/2023-houseData/93405.parquet')  
energy98000<-read_parquet('https://intro-datascience.s3.us-east-2.amazonaws.com/SC-data/2023-houseData/98000.parquet')  
energy106029<-read_parquet('https://intro-datascience.s3.us-east-2.amazonaws.com/SC-data/2023-houseData/106029.parquet')
energy121408<-read_parquet('https://intro-datascience.s3.us-east-2.amazonaws.com/SC-data/2023-houseData/121408.parquet')
energy152486<-read_parquet('https://intro-datascience.s3.us-east-2.amazonaws.com/SC-data/2023-houseData/152486.parquet')
energy166440<-read_parquet('https://intro-datascience.s3.us-east-2.amazonaws.com/SC-data/2023-houseData/166440.parquet')
energy166922<-read_parquet('https://intro-datascience.s3.us-east-2.amazonaws.com/SC-data/2023-houseData/166922.parquet')
energy185048<-read_parquet('https://intro-datascience.s3.us-east-2.amazonaws.com/SC-data/2023-houseData/185048.parquet')
energy187343<-read_parquet('https://intro-datascience.s3.us-east-2.amazonaws.com/SC-data/2023-houseData/187343.parquet')
energy191084<-read_parquet('https://intro-datascience.s3.us-east-2.amazonaws.com/SC-data/2023-houseData/191084.parquet')
energy194578<-read_parquet('https://intro-datascience.s3.us-east-2.amazonaws.com/SC-data/2023-houseData/194578.parquet')
energy195774<-read_parquet('https://intro-datascience.s3.us-east-2.amazonaws.com/SC-data/2023-houseData/195774.parquet')
energy203513<-read_parquet('https://intro-datascience.s3.us-east-2.amazonaws.com/SC-data/2023-houseData/203513.parquet')
energy211416<-read_parquet('https://intro-datascience.s3.us-east-2.amazonaws.com/SC-data/2023-houseData/211416.parquet')
energy214222<-read_parquet('https://intro-datascience.s3.us-east-2.amazonaws.com/SC-data/2023-houseData/214222.parquet')
energy224699<-read_parquet('https://intro-datascience.s3.us-east-2.amazonaws.com/SC-data/2023-houseData/224699.parquet')
energy241708<-read_parquet('https://intro-datascience.s3.us-east-2.amazonaws.com/SC-data/2023-houseData/241708.parquet')
energy249664<-read_parquet('https://intro-datascience.s3.us-east-2.amazonaws.com/SC-data/2023-houseData/249664.parquet')
energy258649<-read_parquet('https://intro-datascience.s3.us-east-2.amazonaws.com/SC-data/2023-houseData/258649.parquet')
energy259244<-read_parquet('https://intro-datascience.s3.us-east-2.amazonaws.com/SC-data/2023-houseData/259244.parquet')
energy270423<-read_parquet('https://intro-datascience.s3.us-east-2.amazonaws.com/SC-data/2023-houseData/270423.parquet')
energy273162<-read_parquet('https://intro-datascience.s3.us-east-2.amazonaws.com/SC-data/2023-houseData/273162.parquet')
energy274323<-read_parquet('https://intro-datascience.s3.us-east-2.amazonaws.com/SC-data/2023-houseData/274323.parquet')
energy281886<-read_parquet('https://intro-datascience.s3.us-east-2.amazonaws.com/SC-data/2023-houseData/281886.parquet')
energy314169<-read_parquet('https://intro-datascience.s3.us-east-2.amazonaws.com/SC-data/2023-houseData/314169.parquet')
energy337684<-read_parquet('https://intro-datascience.s3.us-east-2.amazonaws.com/SC-data/2023-houseData/337684.parquet')
energy344708<-read_parquet('https://intro-datascience.s3.us-east-2.amazonaws.com/SC-data/2023-houseData/344708.parquet')
energy355961<-read_parquet('https://intro-datascience.s3.us-east-2.amazonaws.com/SC-data/2023-houseData/355961.parquet')
energy361437<-read_parquet('https://intro-datascience.s3.us-east-2.amazonaws.com/SC-data/2023-houseData/361437.parquet')
energy362040<-read_parquet('https://intro-datascience.s3.us-east-2.amazonaws.com/SC-data/2023-houseData/362040.parquet')
energy378103<-read_parquet('https://intro-datascience.s3.us-east-2.amazonaws.com/SC-data/2023-houseData/378103.parquet')
energy385223<-read_parquet('https://intro-datascience.s3.us-east-2.amazonaws.com/SC-data/2023-houseData/385223.parquet')
energy388882<-read_parquet('https://intro-datascience.s3.us-east-2.amazonaws.com/SC-data/2023-houseData/388882.parquet')
energy388957<-read_parquet('https://intro-datascience.s3.us-east-2.amazonaws.com/SC-data/2023-houseData/388957.parquet')
energy395711<-read_parquet('https://intro-datascience.s3.us-east-2.amazonaws.com/SC-data/2023-houseData/395711.parquet')
energy396313<-read_parquet('https://intro-datascience.s3.us-east-2.amazonaws.com/SC-data/2023-houseData/396313.parquet')
energy401968<-read_parquet('https://intro-datascience.s3.us-east-2.amazonaws.com/SC-data/2023-houseData/401968.parquet')
energy429521<-read_parquet('https://intro-datascience.s3.us-east-2.amazonaws.com/SC-data/2023-houseData/429521.parquet')
energy435590<-read_parquet('https://intro-datascience.s3.us-east-2.amazonaws.com/SC-data/2023-houseData/435590.parquet')
energy454524<-read_parquet('https://intro-datascience.s3.us-east-2.amazonaws.com/SC-data/2023-houseData/454524.parquet')
energy460013<-read_parquet('https://intro-datascience.s3.us-east-2.amazonaws.com/SC-data/2023-houseData/460013.parquet')
energy460880<-read_parquet('https://intro-datascience.s3.us-east-2.amazonaws.com/SC-data/2023-houseData/460880.parquet')
energy466403<-read_parquet('https://intro-datascience.s3.us-east-2.amazonaws.com/SC-data/2023-houseData/466403.parquet')
energy473013<-read_parquet('https://intro-datascience.s3.us-east-2.amazonaws.com/SC-data/2023-houseData/473013.parquet')
energy493441<-read_parquet('https://intro-datascience.s3.us-east-2.amazonaws.com/SC-data/2023-houseData/493441.parquet')
energy515843<-read_parquet('https://intro-datascience.s3.us-east-2.amazonaws.com/SC-data/2023-houseData/515843.parquet')
energy519668<-read_parquet('https://intro-datascience.s3.us-east-2.amazonaws.com/SC-data/2023-houseData/519668.parquet')
energy522528<-read_parquet('https://intro-datascience.s3.us-east-2.amazonaws.com/SC-data/2023-houseData/522528.parquet')
energy537193<-read_parquet('https://intro-datascience.s3.us-east-2.amazonaws.com/SC-data/2023-houseData/537193.parquet')
energy538921<-read_parquet('https://intro-datascience.s3.us-east-2.amazonaws.com/SC-data/2023-houseData/538921.parquet')
energy547621<-read_parquet('https://intro-datascience.s3.us-east-2.amazonaws.com/SC-data/2023-houseData/547621.parquet')






#-------------------Merge Files-------------------------------------



MergeTest<-merge(weatherG4500690,energy_usage_102063,by.x="date_time",by.y="time")


mergecountyweather<- function(county){
  x<-paste("weather",county, sep="")
  return(x)
  y<-paste("energy", HotHouses$bldg_id, sep="")
  return(y)
  merge(x,y,by.x=x$date_time,by.y=y$time)
  
}



#Install arrow to read Parquet
#install.packages("arrow")
#install.packages("arrow", type = "source")
#arrow::install_arrow()
library(arrow)

#----------------House Data-------------------------------------------

#Read in static_house parquest and make copy
static_house_data <- read_parquet("Downloads/static_house_info.parquet")
static_house_data
static_house_dataEDA<-static_house_data

#Static House data for just building 102063
EnergyExample<-static_house_dataEDA %>% filter(bldg_id ==102063)

#Find and remove redundant columns with no unique values
str(static_house_data)
str(static_house_dataEDA)
unique(static_house_dataEDA$upgrade.insulation_foundation_wall) 

static_house_dataEDAcleanedcolumns<-static_house_dataEDA[,-c(2,3,4,6,7,8,12,14,15,16, 26, 29, 31,32,
                                                             34,35,36,37,38,39,40,41,42,43,44,45,47,
                                                             49,50,51,52,53,54,55,56,63,72,73,79,84,
                                                             85,86,87,88,89,90,91,103,104,106,107,108
                                                             ,109,120,121,124,126,131,136,137,138,139,
                                                             140,141,142,143,144,146,153,159,161,162,
                                                             163,165,166,167,168,169)]


str(energy_usage_102063)
summary(energy_usage_102063)

library(tidyverse)

#Variable Exploration
unique(static_house_dataEDAcleanedcolumns$in.hvac_cooling_type)
str(static_house_dataEDAcleanedcolumns)
summary(static_house_dataEDAcleanedcolumns)
totalusage<-colSums(energy_usage_102063[,1:42])
barplot(totalusage, las=2 )
which.max(totalusage)
unique(static_house_dataEDAcleanedcolumns$in.building_america_climate_zone)
str(static_house_dataEDAcleanedcolumns$in.cooling_setpoint)


#Static House data for buildings in the hottest county (27houses)
HotHouses<-static_house_dataEDAcleanedcolumns %>% filter(in.county == "G4500530")
HotHouses$Temps<-"Hot"
HotHouses$Temps<-as.factor(HotHouses$Temps)
#Static House data for buildings in the "coldest" county (68houses)
ColdHouses<-static_house_dataEDAcleanedcolumns %>% filter(in.county == "G4500210")
ColdHouses$Temps<-"Cold"
ColdHouses$Temps<-as.factor(ColdHouses$Temps)

HotandCold<-rbind(HotHouses, ColdHouses)




static_house_dataEDAcleanedcolumns$in.cooling_setpoint<-as.numeric(substr(static_house_dataEDAcleanedcolumns$in.cooling_setpoint,1,2))
str(static_house_dataEDAcleanedcolumns$in.cooling_setpoint)
mean(as.numeric(substr(static_house_dataEDAcleanedcolumns$in.cooling_setpoint,1,2)))

hist(static_house_dataEDAcleanedcolumns$in.cooling_setpoint)
#Overall avg 73.00823

boxplot(in.cooling_setpoint ~ in.county, data=static_house_dataEDAcleanedcolumns)

str(HotHouses$in.cooling_setpoint)
mean(as.numeric(substr(HotHouses$in.cooling_setpoint,1,2)))
#Average cooling setpoint is 73.2963

mean(as.numeric(substr(ColdHouses$in.cooling_setpoint,1,2)))
#Average cooling setpoint is 72.51613


mean(HotHouses$in.sqft)
#2688.074

mean(ColdHouses$in.sqft)
#1596.774

mean(static_house_dataEDAcleanedcolumns$in.sqft)
#2113.904

str(static_house_dataEDAcleanedcolumns$in.occupants)
static_house_dataEDAcleanedcolumns$in.occupants<-as.numeric(static_house_dataEDAcleanedcolumns$in.occupants)
hist(static_house_dataEDAcleanedcolumns$in.occupants)

#--------Weather Data---------------------------------------------




#Create Weather df for July, delete other months and keep only column for temperature(converted into Fahrenheit)
WeatherDataJuly<-WeatherData[-1:-4343,]
WeatherDataJuly<-WeatherDataJuly[-745:-749,]
WeatherDataJuly<-WeatherDataJuly[,-4:-8]
WeatherDataJuly$Fahrenheit<-WeatherDataJuly$`Dry Bulb Temperature [Â°C]`*(9/5)+32



#Group Weather Data by Month 
class(WeatherData$date_time)
WeatherData$date_time<-as.character.Date(WeatherData$date_time)
WeatherData$month<-(substr(WeatherData$date_time,6,7))

WeatherGrouped<-WeatherData %>%
  group_by(month) %>%
  summarise(Avg_Monthly_Temp = mean(`Dry Bulb Temperature [Â°C]`))
WeatherGrouped



#Group July Weather Data by Day
class(WeatherDataJuly$date_time)
WeatherDataJuly$date_time<-as.character.Date(WeatherDataJuly$date_time)
WeatherDataJuly$day<-(substr(WeatherDataJuly$date_time,9,10))

WeatherGroupedJuly<-WeatherDataJuly %>%
  group_by(day) %>%
  summarise(Avg_Daily_Temp = mean(Fahrenheit))
WeatherGroupedJuly

WeatherGroupedJuly[which.max(WeatherGroupedJuly$Avg_Daily_Temp),] 


#Plot temperature and time to see trends in temperature over the year/in July
ggplot(WeatherDataJuly) + aes(x=WeatherDataJuly$date_time,y=WeatherDataJuly$Fahrenheit)+geom_line() 
ggplot(WeatherData) + aes(x=WeatherData$date_time, y=WeatherData$`Dry Bulb Temperature [Â°C]`) + geom_line() 


#Max Temp in June, hottest overall month is also June
WeatherData[which.max(WeatherData$`Dry Bulb Temperature [Â°C]`),]
WeatherGrouped[which.max(WeatherGrouped$Avg_Monthly_Temp),] 


#Attempted function to create code to run all csv files
library(tidyverse)

read_in_weatherfiles <- function(in.county) {
  common_url<- "https://intro-datascience.s3.us-east-2.amazonaws.com/SC-data/weather/2023-weather-data/"
  county_id<- unique(static_house_dataEDAcleanedcolumns$in.county)
  csv<-".csv')"
  url<-paste(common_url,county_id,csv, sep="")
  run<-paste("weather",county_id, "<-", "read_csv('", url, sep="")
  return(run)
}
read_in_weatherfiles()   


#Manually read in weather files for all counties
unique(static_house_dataEDAcleanedcolumns$in.county)
library(tidyverse)
weatherG4500910<-read_csv('https://intro-datascience.s3.us-east-2.amazonaws.com/SC-data/weather/2023-weather-data/G4500910.csv')
weatherG4500730<-read_csv('https://intro-datascience.s3.us-east-2.amazonaws.com/SC-data/weather/2023-weather-data/G4500730.csv')
weatherG4500710<-read_csv('https://intro-datascience.s3.us-east-2.amazonaws.com/SC-data/weather/2023-weather-data/G4500710.csv')
weatherG4500790<-read_csv('https://intro-datascience.s3.us-east-2.amazonaws.com/SC-data/weather/2023-weather-data/G4500790.csv')
weatherG4500450<-read_csv('https://intro-datascience.s3.us-east-2.amazonaws.com/SC-data/weather/2023-weather-data/G4500450.csv')
weatherG4500150<-read_csv('https://intro-datascience.s3.us-east-2.amazonaws.com/SC-data/weather/2023-weather-data/G4500150.csv')
weatherG4500350<-read_csv('https://intro-datascience.s3.us-east-2.amazonaws.com/SC-data/weather/2023-weather-data/G4500350.csv')
weatherG4500190<-read_csv('https://intro-datascience.s3.us-east-2.amazonaws.com/SC-data/weather/2023-weather-data/G4500190.csv')
weatherG4500830<-read_csv('https://intro-datascience.s3.us-east-2.amazonaws.com/SC-data/weather/2023-weather-data/G4500830.csv')
weatherG4500510<-read_csv('https://intro-datascience.s3.us-east-2.amazonaws.com/SC-data/weather/2023-weather-data/G4500510.csv')
weatherG4500070<-read_csv('https://intro-datascience.s3.us-east-2.amazonaws.com/SC-data/weather/2023-weather-data/G4500070.csv')
weatherG4500670<-read_csv('https://intro-datascience.s3.us-east-2.amazonaws.com/SC-data/weather/2023-weather-data/G4500670.csv')
weatherG4500750<-read_csv('https://intro-datascience.s3.us-east-2.amazonaws.com/SC-data/weather/2023-weather-data/G4500750.csv')
weatherG4500290<-read_csv('https://intro-datascience.s3.us-east-2.amazonaws.com/SC-data/weather/2023-weather-data/G4500290.csv')
weatherG4500490<-read_csv('https://intro-datascience.s3.us-east-2.amazonaws.com/SC-data/weather/2023-weather-data/G4500490.csv')
weatherG4500130<-read_csv('https://intro-datascience.s3.us-east-2.amazonaws.com/SC-data/weather/2023-weather-data/G4500130.csv')
weatherG4500630<-read_csv('https://intro-datascience.s3.us-east-2.amazonaws.com/SC-data/weather/2023-weather-data/G4500630.csv')
weatherG4500870<-read_csv('https://intro-datascience.s3.us-east-2.amazonaws.com/SC-data/weather/2023-weather-data/G4500870.csv')
weatherG4500550<-read_csv('https://intro-datascience.s3.us-east-2.amazonaws.com/SC-data/weather/2023-weather-data/G4500550.csv')
weatherG4500010<-read_csv('https://intro-datascience.s3.us-east-2.amazonaws.com/SC-data/weather/2023-weather-data/G4500010.csv')
weatherG4500430<-read_csv('https://intro-datascience.s3.us-east-2.amazonaws.com/SC-data/weather/2023-weather-data/G4500430.csv')
weatherG4500890<-read_csv('https://intro-datascience.s3.us-east-2.amazonaws.com/SC-data/weather/2023-weather-data/G4500890.csv')
weatherG4500850<-read_csv('https://intro-datascience.s3.us-east-2.amazonaws.com/SC-data/weather/2023-weather-data/G4500850.csv')
weatherG4500770<-read_csv('https://intro-datascience.s3.us-east-2.amazonaws.com/SC-data/weather/2023-weather-data/G4500770.csv')
weatherG4500030<-read_csv('https://intro-datascience.s3.us-east-2.amazonaws.com/SC-data/weather/2023-weather-data/G4500030.csv')
weatherG4500590<-read_csv('https://intro-datascience.s3.us-east-2.amazonaws.com/SC-data/weather/2023-weather-data/G4500590.csv')
weatherG4500610<-read_csv('https://intro-datascience.s3.us-east-2.amazonaws.com/SC-data/weather/2023-weather-data/G4500610.csv')
weatherG4500250<-read_csv('https://intro-datascience.s3.us-east-2.amazonaws.com/SC-data/weather/2023-weather-data/G4500250.csv')
weatherG4500530<-read_csv('https://intro-datascience.s3.us-east-2.amazonaws.com/SC-data/weather/2023-weather-data/G4500530.csv')
weatherG4500210<-read_csv('https://intro-datascience.s3.us-east-2.amazonaws.com/SC-data/weather/2023-weather-data/G4500210.csv')
weatherG4500410<-read_csv('https://intro-datascience.s3.us-east-2.amazonaws.com/SC-data/weather/2023-weather-data/G4500410.csv')
weatherG4500570<-read_csv('https://intro-datascience.s3.us-east-2.amazonaws.com/SC-data/weather/2023-weather-data/G4500570.csv')
weatherG4500690<-read_csv('https://intro-datascience.s3.us-east-2.amazonaws.com/SC-data/weather/2023-weather-data/G4500690.csv')
weatherG4500310<-read_csv('https://intro-datascience.s3.us-east-2.amazonaws.com/SC-data/weather/2023-weather-data/G4500310.csv')
weatherG4500090<-read_csv('https://intro-datascience.s3.us-east-2.amazonaws.com/SC-data/weather/2023-weather-data/G4500090.csv')
weatherG4500470<-read_csv('https://intro-datascience.s3.us-east-2.amazonaws.com/SC-data/weather/2023-weather-data/G4500470.csv')
weatherG4500050<-read_csv('https://intro-datascience.s3.us-east-2.amazonaws.com/SC-data/weather/2023-weather-data/G4500050.csv')
weatherG4500330<-read_csv('https://intro-datascience.s3.us-east-2.amazonaws.com/SC-data/weather/2023-weather-data/G4500330.csv')
weatherG4500650<-read_csv('https://intro-datascience.s3.us-east-2.amazonaws.com/SC-data/weather/2023-weather-data/G4500650.csv')
weatherG4500230<-read_csv('https://intro-datascience.s3.us-east-2.amazonaws.com/SC-data/weather/2023-weather-data/G4500230.csv')
weatherG4500270<-read_csv('https://intro-datascience.s3.us-east-2.amazonaws.com/SC-data/weather/2023-weather-data/G4500270.csv')
weatherG4500370<-read_csv('https://intro-datascience.s3.us-east-2.amazonaws.com/SC-data/weather/2023-weather-data/G4500370.csv')
weatherG4500110<-read_csv('https://intro-datascience.s3.us-east-2.amazonaws.com/SC-data/weather/2023-weather-data/G4500110.csv')
weatherG4500170<-read_csv('https://intro-datascience.s3.us-east-2.amazonaws.com/SC-data/weather/2023-weather-data/G4500170.csv')
weatherG4500390<-read_csv('https://intro-datascience.s3.us-east-2.amazonaws.com/SC-data/weather/2023-weather-data/G4500390.csv')
weatherG4500810<-read_csv('https://intro-datascience.s3.us-east-2.amazonaws.com/SC-data/weather/2023-weather-data/G4500810.csv')





#Unique Counties
"G4500790" "G4500450" "G4500150" "G4500350" "G4500190"
"G4500830" "G4500510" "G4500070" "G4500670" "G4500750" "G4500290" "G4500490" "G4500130"
"G4500630" "G4500870" "G4500550" "G4500010" "G4500430" "G4500890" "G4500850" "G4500770"
"G4500030" "G4500590" "G4500610" "G4500250" "G4500530" "G4500210" "G4500410" "G4500570"
"G4500690" "G4500310" "G4500090" "G4500470" "G4500050" "G4500330" "G4500650" "G4500230"
"G4500270" "G4500370" "G4500110" "G4500170" "G4500390" "G4500810"


read_in_weatherfiles <- function(dataframe, id_column) {
  
  common_url <- "https://intro-datascience.s3.us-east-2.amazonaws.com/SC-data/weather/2023-weather-data/"
  csv_ext <- ".csv"
  
  weather_data <- list()
  
  for (county_id in dataframe[[id_column]]) {
    url <- paste0(common_url, county_id, csv_ext)
    weather_df <- read_csv(url)
    weather_df$County_ID <- county_id  # Add a new column for the county ID
    weather_data[[county_id]] <- weather_df
  }
  
  return(weather_data)
}

# Example usage:
dataframe <- static_house_dataEDAcleanedcolumns  # Your dataframe containing county IDs
id_column <- "in.county"   # Name of the column containing county IDs
weather_data <- read_in_weatherfiles(dataframe, id_column)
ALL_combined_weather <- bind_rows(weather_data)

#Filter for July
ALL_weather_July<-ALL_combined_weather%>%filter(between(date_time, as.Date('2018-07-01'), as.Date('2018-07-31'))) 

library(tidyverse)
MAXweather<- ALL_weather_July %>%
  group_by(County_ID) %>%
  summarise(Avg_Monthly_Temp = mean(`Dry Bulb Temperature [°C]`))


#Static House data for buildings in the hottest counties (27houses)
HotCounties<-static_house_dataEDAcleanedcolumns %>% filter(in.county %in% c("G4500630","G4500710", "G4500130"))
HotCounties$Temps<-"Hot"
HotCounties$Temps<-as.factor(HotCounties$Temps)
#Static House data for buildings in the "coldest" county (68houses)
ColdCounties<-static_house_dataEDAcleanedcolumns %>% filter(in.county %in% c("G4500210","G4500010", "G4500470"))
ColdCounties$Temps<-"Cold"
ColdCounties$Temps<-as.factor(ColdCounties$Temps)

HotColdCounties<-rbind(HotCounties,ColdCounties)

dataframe <- HotColdCounties  # Your dataframe containing building IDs
id_column <- "bldg_id"   # Name of the column containing building IDs
energy_data <- read_in_energyfiles(dataframe, id_column)


HotColdEnergy <- do.call(rbind, energy_data)


HotandCold$total<-HotandCold %>%
  group_by(bldg_id) %>%
  summarise((Total_Energy = colSums(HotandCold)))

WeatherGrouped<-WeatherData %>%
  group_by(month) %>%
  summarise(Avg_Monthly_Temp = mean(`Dry Bulb Temperature [Â°C]`))
WeatherGrouped

lmHC<-lm(formula=)



#Plot Avg Temps
ggplot() + 
  geom_line(data=weatherG4500810, aes(x=day, y=Avg_Daily_Temp, group=1), color='blue') + 
  geom_line(data=weatherG4500190, aes(x=day, y=Avg_Daily_Temp, group=1), color='red1') +
  geom_line(data=weatherG4500910, aes(x=day, y=Avg_Daily_Temp, group=1), color='chartreuse') +
  geom_line(data=weatherG4500730, aes(x=day, y=Avg_Daily_Temp, group=1), color='pink') +
  geom_line(data=weatherG4500710, aes(x=day, y=Avg_Daily_Temp, group=1), color='purple') +
  geom_line(data=weatherG4500790, aes(x=day, y=Avg_Daily_Temp, group=1), color='orange') +
  geom_line(data=weatherG4500450, aes(x=day, y=Avg_Daily_Temp, group=1), color='yellow') +
  geom_line(data=weatherG4500150, aes(x=day, y=Avg_Daily_Temp, group=1), color='tan') +
  geom_line(data=weatherG4500350, aes(x=day, y=Avg_Daily_Temp, group=1), color='lightblue') +
  geom_line(data=weatherG4500830, aes(x=day, y=Avg_Daily_Temp, group=1), color='darkgreen') +
  geom_line(data=weatherG4500510, aes(x=day, y=Avg_Daily_Temp, group=1), color='gray') +
  geom_line(data=weatherG4500070, aes(x=day, y=Avg_Daily_Temp, group=1), color='hotpink') +
  geom_line(data=weatherG4500670, aes(x=day, y=Avg_Daily_Temp, group=1), color='lavender') +
  geom_line(data=weatherG4500750, aes(x=day, y=Avg_Daily_Temp, group=1), color='turquoise') +
  geom_line(data=weatherG4500290, aes(x=day, y=Avg_Daily_Temp, group=1), color='chocolate4') +
  geom_line(data=weatherG4500490, aes(x=day, y=Avg_Daily_Temp, group=1), color='palegreen') +
  geom_line(data=weatherG4500130, aes(x=day, y=Avg_Daily_Temp, group=1), color='navy') +
  geom_line(data=weatherG4500630, aes(x=day, y=Avg_Daily_Temp, group=1), color='gold') +
  geom_line(data=weatherG4500870, aes(x=day, y=Avg_Daily_Temp, group=1), color='cyan') +
  geom_line(data=weatherG4500550, aes(x=day, y=Avg_Daily_Temp, group=1), color='peru') +
  geom_line(data=weatherG4500010, aes(x=day, y=Avg_Daily_Temp, group=1), color='cornflowerblue') +
  geom_line(data=weatherG4500430, aes(x=day, y=Avg_Daily_Temp, group=1), color='maroon') +
  geom_line(data=weatherG4500890, aes(x=day, y=Avg_Daily_Temp, group=1), color='tomato') +
  geom_line(data=weatherG4500850, aes(x=day, y=Avg_Daily_Temp, group=1), color='slateblue') +
  geom_line(data=weatherG4500770, aes(x=day, y=Avg_Daily_Temp, group=1), color='honeydew') +
  geom_line(data=weatherG4500030, aes(x=day, y=Avg_Daily_Temp, group=1), color='violet') +
  geom_line(data=weatherG4500590, aes(x=day, y=Avg_Daily_Temp, group=1), color='olivedrab') +
  geom_line(data=weatherG4500610, aes(x=day, y=Avg_Daily_Temp, group=1), color='antiquewhite') +
  geom_line(data=weatherG4500250, aes(x=day, y=Avg_Daily_Temp, group=1), color='orangered1') +
  geom_line(data=weatherG4500530, aes(x=day, y=Avg_Daily_Temp, group=1), color='black') +
  geom_line(data=weatherG4500210, aes(x=day, y=Avg_Daily_Temp, group=1), color='black') +
  geom_line(data=weatherG4500410, aes(x=day, y=Avg_Daily_Temp, group=1), color='darkmagenta') +
  geom_line(data=weatherG4500570, aes(x=day, y=Avg_Daily_Temp, group=1), color='azure') +
  geom_line(data=weatherG4500690, aes(x=day, y=Avg_Daily_Temp, group=1), color='forestgreen') +
  geom_line(data=weatherG4500310, aes(x=day, y=Avg_Daily_Temp, group=1), color='khaki1') +
  geom_line(data=weatherG4500090, aes(x=day, y=Avg_Daily_Temp, group=1), color='yellowgreen') +
  geom_line(data=weatherG4500470, aes(x=day, y=Avg_Daily_Temp, group=1), color='darkcyan') +
  geom_line(data=weatherG4500050, aes(x=day, y=Avg_Daily_Temp, group=1), color='mediumorchid') +
  geom_line(data=weatherG4500650, aes(x=day, y=Avg_Daily_Temp, group=1), color='thistle') +
  geom_line(data=weatherG4500230, aes(x=day, y=Avg_Daily_Temp, group=1), color='wheat') +
  geom_line(data=weatherG4500270, aes(x=day, y=Avg_Daily_Temp, group=1), color='firebrick') +
  geom_line(data=weatherG4500370, aes(x=day, y=Avg_Daily_Temp, group=1), color='darkorange') +
  geom_line(data=weatherG4500110, aes(x=day, y=Avg_Daily_Temp, group=1), color='beige') +
  geom_line(data=weatherG4500170, aes(x=day, y=Avg_Daily_Temp, group=1), color='mediumspringgreen') +
  geom_line(data=weatherG4500390, aes(x=day, y=Avg_Daily_Temp, group=1), color='ghostwhite') +
  geom_line(data=weatherG4500330, aes(x=day, y=Avg_Daily_Temp, group=1), color='aquamarine') 




ggplot() + 
  geom_line(data=weatherG4500810, aes(x=day, y=Avg_Daily_Humidity, group=1), color='blue') + 
  geom_line(data=weatherG4500190, aes(x=day, y=Avg_Daily_Humidity, group=1), color='red1') +
  geom_line(data=weatherG4500910, aes(x=day, y=Avg_Daily_Humidity, group=1), color='chartreuse') +
  geom_line(data=weatherG4500730, aes(x=day, y=Avg_Daily_Humidity, group=1), color='pink') +
  geom_line(data=weatherG4500710, aes(x=day, y=Avg_Daily_Humidity, group=1), color='purple') +
  geom_line(data=weatherG4500790, aes(x=day, y=Avg_Daily_Humidity, group=1), color='orange') +
  geom_line(data=weatherG4500450, aes(x=day, y=Avg_Daily_Humidity, group=1), color='yellow') +
  geom_line(data=weatherG4500150, aes(x=day, y=Avg_Daily_Humidity, group=1), color='tan') +
  geom_line(data=weatherG4500350, aes(x=day, y=Avg_Daily_Humidity, group=1), color='lightblue') +
  geom_line(data=weatherG4500830, aes(x=day, y=Avg_Daily_Humidity, group=1), color='darkgreen') +
  geom_line(data=weatherG4500510, aes(x=day, y=Avg_Daily_Humidity, group=1), color='gray') +
  geom_line(data=weatherG4500070, aes(x=day, y=Avg_Daily_Humidity, group=1), color='hotpink') +
  geom_line(data=weatherG4500670, aes(x=day, y=Avg_Daily_Humidity, group=1), color='lavender') +
  geom_line(data=weatherG4500750, aes(x=day, y=Avg_Daily_Humidity, group=1), color='turquoise') +
  geom_line(data=weatherG4500290, aes(x=day, y=Avg_Daily_Humidity, group=1), color='chocolate4') +
  geom_line(data=weatherG4500490, aes(x=day, y=Avg_Daily_Humidity, group=1), color='palegreen') +
  geom_line(data=weatherG4500130, aes(x=day, y=Avg_Daily_Humidity, group=1), color='navy') +
  geom_line(data=weatherG4500630, aes(x=day, y=Avg_Daily_Humidity, group=1), color='gold') +
  geom_line(data=weatherG4500870, aes(x=day, y=Avg_Daily_Humidity, group=1), color='cyan') +
  geom_line(data=weatherG4500550, aes(x=day, y=Avg_Daily_Humidity, group=1), color='peru') +
  geom_line(data=weatherG4500010, aes(x=day, y=Avg_Daily_Humidity, group=1), color='cornflowerblue') +
  geom_line(data=weatherG4500430, aes(x=day, y=Avg_Daily_Humidity, group=1), color='maroon') +
  geom_line(data=weatherG4500890, aes(x=day, y=Avg_Daily_Humidity, group=1), color='tomato') +
  geom_line(data=weatherG4500850, aes(x=day, y=Avg_Daily_Humidity, group=1), color='slateblue') +
  geom_line(data=weatherG4500770, aes(x=day, y=Avg_Daily_Humidity, group=1), color='honeydew') +
  geom_line(data=weatherG4500030, aes(x=day, y=Avg_Daily_Humidity, group=1), color='violet') +
  geom_line(data=weatherG4500590, aes(x=day, y=Avg_Daily_Humidity, group=1), color='olivedrab') +
  geom_line(data=weatherG4500610, aes(x=day, y=Avg_Daily_Humidity, group=1), color='antiquewhite') +
  geom_line(data=weatherG4500250, aes(x=day, y=Avg_Daily_Humidity, group=1), color='orangered1') +
  geom_line(data=weatherG4500530, aes(x=day, y=Avg_Daily_Humidity, group=1), color='black') +
  geom_line(data=weatherG4500210, aes(x=day, y=Avg_Daily_Humidity, group=1), color='black') +
  geom_line(data=weatherG4500410, aes(x=day, y=Avg_Daily_Humidity, group=1), color='darkmagenta') +
  geom_line(data=weatherG4500570, aes(x=day, y=Avg_Daily_Humidity, group=1), color='azure') +
  geom_line(data=weatherG4500690, aes(x=day, y=Avg_Daily_Humidity, group=1), color='forestgreen') +
  geom_line(data=weatherG4500310, aes(x=day, y=Avg_Daily_Humidity, group=1), color='khaki1') +
  geom_line(data=weatherG4500090, aes(x=day, y=Avg_Daily_Humidity, group=1), color='yellowgreen') +
  geom_line(data=weatherG4500470, aes(x=day, y=Avg_Daily_Humidity, group=1), color='darkcyan') +
  geom_line(data=weatherG4500050, aes(x=day, y=Avg_Daily_Humidity, group=1), color='mediumorchid') +
  geom_line(data=weatherG4500650, aes(x=day, y=Avg_Daily_Humidity, group=1), color='thistle') +
  geom_line(data=weatherG4500230, aes(x=day, y=Avg_Daily_Humidity, group=1), color='wheat') +
  geom_line(data=weatherG4500270, aes(x=day, y=Avg_Daily_Humidity, group=1), color='firebrick') +
  geom_line(data=weatherG4500370, aes(x=day, y=Avg_Daily_Humidity, group=1), color='darkorange') +
  geom_line(data=weatherG4500110, aes(x=day, y=Avg_Daily_Humidity, group=1), color='beige') +
  geom_line(data=weatherG4500170, aes(x=day, y=Avg_Daily_Humidity, group=1), color='mediumspringgreen') +
  geom_line(data=weatherG4500390, aes(x=day, y=Avg_Daily_Humidity, group=1), color='ghostwhite') +
  geom_line(data=weatherG4500330, aes(x=day, y=Avg_Daily_Humidity, group=1), color='aquamarine') 








#Highest Avg Temps in county G4500530
geom_line(data=weatherG4500530, aes(x=day, y=Avg_Daily_Temp, group=1), color='black')


#Lowest Avg Temps in county G4500210

#---------------Energy Data Bldg 102063--------------------------------------

#Read in energy data for building 102063 and make a copy of just July data
energy_usage_102063 <- read_parquet("Downloads/102063.parquet")
energy_usage_102063_July<-energy_usage_102063

#Parse time column to get just the month
energy_usage_102063_July$date<-as.character.Date(energy_usage_102063_July$time)
energy_usage_102063_July$month<-(substr(energy_usage_102063_July$date,6,7))
class(energy_usage_102063_July$month)

#Filter month=7 to get July data only
library(tidyverse)
energy_usage_102063_July<- energy_usage_102063_July %>% filter(month=="07")
summary(energy_usage_102063_July)


#Run basic hist and summary comparing overall energy year over the year to energy consumption in July
#for (out.electricity.cooling.energy_consumption) variable

#July
hist(energy_usage_102063_July$out.electricity.cooling.energy_consumption)
summary(energy_usage_102063_July$out.electricity.cooling.energy_consumption)

#Overall
hist(energy_usage_102063$out.electricity.cooling.energy_consumption)
summary(energy_usage_102063$out.electricity.cooling.energy_consumption)

#Plot 
library(ggplot2)
ggplot(energy_usage_102063) + aes(x=energy_usage_102063$time,y=energy_usage_102063$out.electricity.cooling.energy_consumption)+geom_line()
ggplot(energy_usage_102063_July) + aes(x=energy_usage_102063_July$time,y=energy_usage_102063_July$out.electricity.cooling.energy_consumption)+geom_line()                                

#Group by Day for July
#Create day column as substring of date column
energy_usage_102063_July$date<-as.character.Date(energy_usage_102063_July$time)
energy_usage_102063_July$day<-(substr(energy_usage_102063_July$date,9,10))

#Make character variables numeric for grouping purposes
energy_usage_102063_July$time<-as.numeric(energy_usage_102063_July$time)
energy_usage_102063_July$date<-as.numeric(energy_usage_102063_July$date)
energy_usage_102063_July$month<-as.numeric(energy_usage_102063_July$month)
energy_usage_102063_July$day<-as.numeric(energy_usage_102063_July$day)

#Group by average all the columns over day of July
energy_usage_102063_July_Grouped<- energy_usage_102063_July %>%
  group_by(day) %>%
  summarise_all(mean)
energy_usage_102063_July_Grouped


#July 3rd used the most cooling energy
energy_usage_102063_July_Grouped[which.max(energy_usage_102063_July_Grouped$out.electricity.cooling.energy_consumption),]

#Plot
ggplot(energy_usage_102063_July) + aes(x=energy_usage_102063_July$time,y=energy_usage_102063_July$out.electricity.cooling.energy_consumption)+geom_line()
ggplot(energy_usage_102063_July_Grouped) + aes(x=energy_usage_102063_July_Grouped$day,y=energy_usage_102063_July_Grouped$out.electricity.cooling.energy_consumption)+geom_line()



#Function to read in energy files for selected county
read_in_energyfiles <- function(bldg_id) {
  common_url<- "https://intro-datascience.s3.us-east-2.amazonaws.com/SC-data/2023-houseData/"
  bldg_id<- HotHouses$bldg_id
  parquet<-".parquet')"
  url<-paste(common_url,bldg_id,parquet, sep="")
  run<-paste("energy",bldg_id, "<-", "read_parquet('", url, sep="")
  return(run)
}
read_in_energyfiles(HotHouses$bldg_id) 

#Energy files for hottest county G4500690
energy9590<-read_parquet('https://intro-datascience.s3.us-east-2.amazonaws.com/SC-data/2023-houseData/9590.parquet')    
energy20799<-read_parquet('https://intro-datascience.s3.us-east-2.amazonaws.com/SC-data/2023-houseData/20799.parquet')  
energy42807<-read_parquet('https://intro-datascience.s3.us-east-2.amazonaws.com/SC-data/2023-houseData/42807.parquet')  
energy45565<-read_parquet('https://intro-datascience.s3.us-east-2.amazonaws.com/SC-data/2023-houseData/45565.parquet')  
energy51955<-read_parquet('https://intro-datascience.s3.us-east-2.amazonaws.com/SC-data/2023-houseData/51955.parquet')  
energy89793<-read_parquet('https://intro-datascience.s3.us-east-2.amazonaws.com/SC-data/2023-houseData/89793.parquet')  
energy114167<-read_parquet('https://intro-datascience.s3.us-east-2.amazonaws.com/SC-data/2023-houseData/114167.parquet')
energy126714<-read_parquet('https://intro-datascience.s3.us-east-2.amazonaws.com/SC-data/2023-houseData/126714.parquet')
energy142919<-read_parquet('https://intro-datascience.s3.us-east-2.amazonaws.com/SC-data/2023-houseData/142919.parquet')
energy169672<-read_parquet('https://intro-datascience.s3.us-east-2.amazonaws.com/SC-data/2023-houseData/169672.parquet')
energy174809<-read_parquet('https://intro-datascience.s3.us-east-2.amazonaws.com/SC-data/2023-houseData/174809.parquet')
energy181726<-read_parquet('https://intro-datascience.s3.us-east-2.amazonaws.com/SC-data/2023-houseData/181726.parquet')
energy187030<-read_parquet('https://intro-datascience.s3.us-east-2.amazonaws.com/SC-data/2023-houseData/187030.parquet')
energy192420<-read_parquet('https://intro-datascience.s3.us-east-2.amazonaws.com/SC-data/2023-houseData/192420.parquet')
energy209925<-read_parquet('https://intro-datascience.s3.us-east-2.amazonaws.com/SC-data/2023-houseData/209925.parquet')
energy275868<-read_parquet('https://intro-datascience.s3.us-east-2.amazonaws.com/SC-data/2023-houseData/275868.parquet')
energy276948<-read_parquet('https://intro-datascience.s3.us-east-2.amazonaws.com/SC-data/2023-houseData/276948.parquet')
energy289369<-read_parquet('https://intro-datascience.s3.us-east-2.amazonaws.com/SC-data/2023-houseData/289369.parquet')
energy290138<-read_parquet('https://intro-datascience.s3.us-east-2.amazonaws.com/SC-data/2023-houseData/290138.parquet')
energy295891<-read_parquet('https://intro-datascience.s3.us-east-2.amazonaws.com/SC-data/2023-houseData/295891.parquet')
energy296938<-read_parquet('https://intro-datascience.s3.us-east-2.amazonaws.com/SC-data/2023-houseData/296938.parquet')
energy357971<-read_parquet('https://intro-datascience.s3.us-east-2.amazonaws.com/SC-data/2023-houseData/357971.parquet')
energy360863<-read_parquet('https://intro-datascience.s3.us-east-2.amazonaws.com/SC-data/2023-houseData/360863.parquet')
energy363396<-read_parquet('https://intro-datascience.s3.us-east-2.amazonaws.com/SC-data/2023-houseData/363396.parquet')
energy436552<-read_parquet('https://intro-datascience.s3.us-east-2.amazonaws.com/SC-data/2023-houseData/436552.parquet')
energy495411<-read_parquet('https://intro-datascience.s3.us-east-2.amazonaws.com/SC-data/2023-houseData/495411.parquet')
energy505669<-read_parquet('https://intro-datascience.s3.us-east-2.amazonaws.com/SC-data/2023-houseData/505669.parquet')


#Function to read in energy files for selected county
read_in_energyfiles <- function(bldg_id) {
  common_url<- "https://intro-datascience.s3.us-east-2.amazonaws.com/SC-data/2023-houseData/"
  bldg_id<- ColdHouses$bldg_id
  parquet<-".parquet')"
  url<-paste(common_url,bldg_id,parquet, sep="")
  run<-paste("energy",bldg_id, "<-", "read_parquet('", url, sep="")
  return(run)
}
read_in_energyfiles(ColdHouses$bldg_id) 

#Energy files for "coldest" county
energy9756<-read_parquet('https://intro-datascience.s3.us-east-2.amazonaws.com/SC-data/2023-houseData/9756.parquet')   
energy21893<-read_parquet('https://intro-datascience.s3.us-east-2.amazonaws.com/SC-data/2023-houseData/21893.parquet')  
energy32634<-read_parquet('https://intro-datascience.s3.us-east-2.amazonaws.com/SC-data/2023-houseData/32634.parquet') 
energy38693<-read_parquet('https://intro-datascience.s3.us-east-2.amazonaws.com/SC-data/2023-houseData/38693.parquet') 
energy42264<-read_parquet('https://intro-datascience.s3.us-east-2.amazonaws.com/SC-data/2023-houseData/42264.parquet') 
energy62053<-read_parquet('https://intro-datascience.s3.us-east-2.amazonaws.com/SC-data/2023-houseData/62053.parquet') 
energy65081<-read_parquet('https://intro-datascience.s3.us-east-2.amazonaws.com/SC-data/2023-houseData/65081.parquet')  
energy70556<-read_parquet('https://intro-datascience.s3.us-east-2.amazonaws.com/SC-data/2023-houseData/70556.parquet')  
energy73790<-read_parquet('https://intro-datascience.s3.us-east-2.amazonaws.com/SC-data/2023-houseData/73790.parquet')  
energy84593<-read_parquet('https://intro-datascience.s3.us-east-2.amazonaws.com/SC-data/2023-houseData/84593.parquet')  
energy86055<-read_parquet('https://intro-datascience.s3.us-east-2.amazonaws.com/SC-data/2023-houseData/86055.parquet')  
energy93405<-read_parquet('https://intro-datascience.s3.us-east-2.amazonaws.com/SC-data/2023-houseData/93405.parquet')  
energy98000<-read_parquet('https://intro-datascience.s3.us-east-2.amazonaws.com/SC-data/2023-houseData/98000.parquet')  
energy106029<-read_parquet('https://intro-datascience.s3.us-east-2.amazonaws.com/SC-data/2023-houseData/106029.parquet')
energy121408<-read_parquet('https://intro-datascience.s3.us-east-2.amazonaws.com/SC-data/2023-houseData/121408.parquet')
energy152486<-read_parquet('https://intro-datascience.s3.us-east-2.amazonaws.com/SC-data/2023-houseData/152486.parquet')
energy166440<-read_parquet('https://intro-datascience.s3.us-east-2.amazonaws.com/SC-data/2023-houseData/166440.parquet')
energy166922<-read_parquet('https://intro-datascience.s3.us-east-2.amazonaws.com/SC-data/2023-houseData/166922.parquet')
energy185048<-read_parquet('https://intro-datascience.s3.us-east-2.amazonaws.com/SC-data/2023-houseData/185048.parquet')
energy187343<-read_parquet('https://intro-datascience.s3.us-east-2.amazonaws.com/SC-data/2023-houseData/187343.parquet')
energy191084<-read_parquet('https://intro-datascience.s3.us-east-2.amazonaws.com/SC-data/2023-houseData/191084.parquet')
energy194578<-read_parquet('https://intro-datascience.s3.us-east-2.amazonaws.com/SC-data/2023-houseData/194578.parquet')
energy195774<-read_parquet('https://intro-datascience.s3.us-east-2.amazonaws.com/SC-data/2023-houseData/195774.parquet')
energy203513<-read_parquet('https://intro-datascience.s3.us-east-2.amazonaws.com/SC-data/2023-houseData/203513.parquet')
energy211416<-read_parquet('https://intro-datascience.s3.us-east-2.amazonaws.com/SC-data/2023-houseData/211416.parquet')
energy214222<-read_parquet('https://intro-datascience.s3.us-east-2.amazonaws.com/SC-data/2023-houseData/214222.parquet')
energy224699<-read_parquet('https://intro-datascience.s3.us-east-2.amazonaws.com/SC-data/2023-houseData/224699.parquet')
energy241708<-read_parquet('https://intro-datascience.s3.us-east-2.amazonaws.com/SC-data/2023-houseData/241708.parquet')
energy249664<-read_parquet('https://intro-datascience.s3.us-east-2.amazonaws.com/SC-data/2023-houseData/249664.parquet')
energy258649<-read_parquet('https://intro-datascience.s3.us-east-2.amazonaws.com/SC-data/2023-houseData/258649.parquet')
energy259244<-read_parquet('https://intro-datascience.s3.us-east-2.amazonaws.com/SC-data/2023-houseData/259244.parquet')
energy270423<-read_parquet('https://intro-datascience.s3.us-east-2.amazonaws.com/SC-data/2023-houseData/270423.parquet')
energy273162<-read_parquet('https://intro-datascience.s3.us-east-2.amazonaws.com/SC-data/2023-houseData/273162.parquet')
energy274323<-read_parquet('https://intro-datascience.s3.us-east-2.amazonaws.com/SC-data/2023-houseData/274323.parquet')
energy281886<-read_parquet('https://intro-datascience.s3.us-east-2.amazonaws.com/SC-data/2023-houseData/281886.parquet')
energy314169<-read_parquet('https://intro-datascience.s3.us-east-2.amazonaws.com/SC-data/2023-houseData/314169.parquet')
energy337684<-read_parquet('https://intro-datascience.s3.us-east-2.amazonaws.com/SC-data/2023-houseData/337684.parquet')
energy344708<-read_parquet('https://intro-datascience.s3.us-east-2.amazonaws.com/SC-data/2023-houseData/344708.parquet')
energy355961<-read_parquet('https://intro-datascience.s3.us-east-2.amazonaws.com/SC-data/2023-houseData/355961.parquet')
energy361437<-read_parquet('https://intro-datascience.s3.us-east-2.amazonaws.com/SC-data/2023-houseData/361437.parquet')
energy362040<-read_parquet('https://intro-datascience.s3.us-east-2.amazonaws.com/SC-data/2023-houseData/362040.parquet')
energy378103<-read_parquet('https://intro-datascience.s3.us-east-2.amazonaws.com/SC-data/2023-houseData/378103.parquet')
energy385223<-read_parquet('https://intro-datascience.s3.us-east-2.amazonaws.com/SC-data/2023-houseData/385223.parquet')
energy388882<-read_parquet('https://intro-datascience.s3.us-east-2.amazonaws.com/SC-data/2023-houseData/388882.parquet')
energy388957<-read_parquet('https://intro-datascience.s3.us-east-2.amazonaws.com/SC-data/2023-houseData/388957.parquet')
energy395711<-read_parquet('https://intro-datascience.s3.us-east-2.amazonaws.com/SC-data/2023-houseData/395711.parquet')
energy396313<-read_parquet('https://intro-datascience.s3.us-east-2.amazonaws.com/SC-data/2023-houseData/396313.parquet')
energy401968<-read_parquet('https://intro-datascience.s3.us-east-2.amazonaws.com/SC-data/2023-houseData/401968.parquet')
energy429521<-read_parquet('https://intro-datascience.s3.us-east-2.amazonaws.com/SC-data/2023-houseData/429521.parquet')
energy435590<-read_parquet('https://intro-datascience.s3.us-east-2.amazonaws.com/SC-data/2023-houseData/435590.parquet')
energy454524<-read_parquet('https://intro-datascience.s3.us-east-2.amazonaws.com/SC-data/2023-houseData/454524.parquet')
energy460013<-read_parquet('https://intro-datascience.s3.us-east-2.amazonaws.com/SC-data/2023-houseData/460013.parquet')
energy460880<-read_parquet('https://intro-datascience.s3.us-east-2.amazonaws.com/SC-data/2023-houseData/460880.parquet')
energy466403<-read_parquet('https://intro-datascience.s3.us-east-2.amazonaws.com/SC-data/2023-houseData/466403.parquet')
energy473013<-read_parquet('https://intro-datascience.s3.us-east-2.amazonaws.com/SC-data/2023-houseData/473013.parquet')
energy493441<-read_parquet('https://intro-datascience.s3.us-east-2.amazonaws.com/SC-data/2023-houseData/493441.parquet')
energy515843<-read_parquet('https://intro-datascience.s3.us-east-2.amazonaws.com/SC-data/2023-houseData/515843.parquet')
energy519668<-read_parquet('https://intro-datascience.s3.us-east-2.amazonaws.com/SC-data/2023-houseData/519668.parquet')
energy522528<-read_parquet('https://intro-datascience.s3.us-east-2.amazonaws.com/SC-data/2023-houseData/522528.parquet')
energy537193<-read_parquet('https://intro-datascience.s3.us-east-2.amazonaws.com/SC-data/2023-houseData/537193.parquet')
energy538921<-read_parquet('https://intro-datascience.s3.us-east-2.amazonaws.com/SC-data/2023-houseData/538921.parquet')
energy547621<-read_parquet('https://intro-datascience.s3.us-east-2.amazonaws.com/SC-data/2023-houseData/547621.parquet')


energy_usage_102063_July[is.na(energy_usage_102063_July),]
energyna<-energy_usage_102063_July[is.na(energy_usage_102063_July),]

#-------------------Merge Files-------------------------------------

#Merge Weather and Energy for Hottest County


#Example Merge
weatherG4500530_20799<- merge(weatherG4500530,energy20799,by.x='date_time',by.y='time')
weatherG4500530_20799<-weatherG4500530_20799 %>% filter(between(date_time, as.Date('2018-07-01'), as.Date('2018-07-31')))
weatherG4500530_20799$bldg_id<-"20799"
weatherG4500530_20799

#Merge all energy files with the weather data for county G4500530
paste("weatherG4500530_",HotHouses$bldg_id, "<-merge(weatherG4500530,energy",HotHouses$bldg_id,",by.x='date_time',by.y='time')", sep="")

weatherG4500530_9590<-merge(weatherG4500530,energy9590,by.x='date_time',by.y='time')    
weatherG4500530_20799<-merge(weatherG4500530,energy20799,by.x='date_time',by.y='time')  
weatherG4500530_42807<-merge(weatherG4500530,energy42807,by.x='date_time',by.y='time')  
weatherG4500530_45565<-merge(weatherG4500530,energy45565,by.x='date_time',by.y='time') 
weatherG4500530_51955<-merge(weatherG4500530,energy51955,by.x='date_time',by.y='time')
weatherG4500530_89793<-merge(weatherG4500530,energy89793,by.x='date_time',by.y='time')  
weatherG4500530_114167<-merge(weatherG4500530,energy114167,by.x='date_time',by.y='time')
weatherG4500530_126714<-merge(weatherG4500530,energy126714,by.x='date_time',by.y='time')
weatherG4500530_142919<-merge(weatherG4500530,energy142919,by.x='date_time',by.y='time')
weatherG4500530_169672<-merge(weatherG4500530,energy169672,by.x='date_time',by.y='time')
weatherG4500530_174809<-merge(weatherG4500530,energy174809,by.x='date_time',by.y='time')
weatherG4500530_181726<-merge(weatherG4500530,energy181726,by.x='date_time',by.y='time')
weatherG4500530_187030<-merge(weatherG4500530,energy187030,by.x='date_time',by.y='time')
weatherG4500530_192420<-merge(weatherG4500530,energy192420,by.x='date_time',by.y='time')
weatherG4500530_209925<-merge(weatherG4500530,energy209925,by.x='date_time',by.y='time')
weatherG4500530_275868<-merge(weatherG4500530,energy275868,by.x='date_time',by.y='time')
weatherG4500530_276948<-merge(weatherG4500530,energy276948,by.x='date_time',by.y='time')
weatherG4500530_289369<-merge(weatherG4500530,energy289369,by.x='date_time',by.y='time')
weatherG4500530_290138<-merge(weatherG4500530,energy290138,by.x='date_time',by.y='time')
weatherG4500530_295891<-merge(weatherG4500530,energy295891,by.x='date_time',by.y='time')
weatherG4500530_296938<-merge(weatherG4500530,energy296938,by.x='date_time',by.y='time')
weatherG4500530_357971<-merge(weatherG4500530,energy357971,by.x='date_time',by.y='time')
weatherG4500530_360863<-merge(weatherG4500530,energy360863,by.x='date_time',by.y='time')
weatherG4500530_363396<-merge(weatherG4500530,energy363396,by.x='date_time',by.y='time')
weatherG4500530_436552<-merge(weatherG4500530,energy436552,by.x='date_time',by.y='time')
weatherG4500530_495411<-merge(weatherG4500530,energy495411,by.x='date_time',by.y='time')
weatherG4500530_505669<-merge(weatherG4500530,energy505669,by.x='date_time',by.y='time')




#Filter merged files for only July

paste("weatherG4500530_",HotHouses$bldg_id, "<-weatherG4500530_",HotHouses$bldg_id, "%>%filter(between(date_time, as.Date('2018-07-01'), as.Date('2018-07-31')))", sep="" )

weatherG4500530_9590<-weatherG4500530_9590%>%filter(between(date_time, as.Date('2018-07-01'), as.Date('2018-07-31')))   
weatherG4500530_20799<-weatherG4500530_20799%>%filter(between(date_time, as.Date('2018-07-01'), as.Date('2018-07-31')))  
weatherG4500530_42807<-weatherG4500530_42807%>%filter(between(date_time, as.Date('2018-07-01'), as.Date('2018-07-31')))  
weatherG4500530_45565<-weatherG4500530_45565%>%filter(between(date_time, as.Date('2018-07-01'), as.Date('2018-07-31')))  
weatherG4500530_51955<-weatherG4500530_51955%>%filter(between(date_time, as.Date('2018-07-01'), as.Date('2018-07-31')))  
weatherG4500530_89793<-weatherG4500530_89793%>%filter(between(date_time, as.Date('2018-07-01'), as.Date('2018-07-31')))  
weatherG4500530_114167<-weatherG4500530_114167%>%filter(between(date_time, as.Date('2018-07-01'), as.Date('2018-07-31')))
weatherG4500530_126714<-weatherG4500530_126714%>%filter(between(date_time, as.Date('2018-07-01'), as.Date('2018-07-31')))
weatherG4500530_142919<-weatherG4500530_142919%>%filter(between(date_time, as.Date('2018-07-01'), as.Date('2018-07-31')))
weatherG4500530_169672<-weatherG4500530_169672%>%filter(between(date_time, as.Date('2018-07-01'), as.Date('2018-07-31')))
weatherG4500530_174809<-weatherG4500530_174809%>%filter(between(date_time, as.Date('2018-07-01'), as.Date('2018-07-31')))
weatherG4500530_181726<-weatherG4500530_181726%>%filter(between(date_time, as.Date('2018-07-01'), as.Date('2018-07-31')))
weatherG4500530_187030<-weatherG4500530_187030%>%filter(between(date_time, as.Date('2018-07-01'), as.Date('2018-07-31')))
weatherG4500530_192420<-weatherG4500530_192420%>%filter(between(date_time, as.Date('2018-07-01'), as.Date('2018-07-31')))
weatherG4500530_209925<-weatherG4500530_209925%>%filter(between(date_time, as.Date('2018-07-01'), as.Date('2018-07-31')))
weatherG4500530_275868<-weatherG4500530_275868%>%filter(between(date_time, as.Date('2018-07-01'), as.Date('2018-07-31')))
weatherG4500530_276948<-weatherG4500530_276948%>%filter(between(date_time, as.Date('2018-07-01'), as.Date('2018-07-31')))
weatherG4500530_289369<-weatherG4500530_289369%>%filter(between(date_time, as.Date('2018-07-01'), as.Date('2018-07-31')))
weatherG4500530_290138<-weatherG4500530_290138%>%filter(between(date_time, as.Date('2018-07-01'), as.Date('2018-07-31')))
weatherG4500530_295891<-weatherG4500530_295891%>%filter(between(date_time, as.Date('2018-07-01'), as.Date('2018-07-31')))
weatherG4500530_296938<-weatherG4500530_296938%>%filter(between(date_time, as.Date('2018-07-01'), as.Date('2018-07-31')))
weatherG4500530_357971<-weatherG4500530_357971%>%filter(between(date_time, as.Date('2018-07-01'), as.Date('2018-07-31')))
weatherG4500530_360863<-weatherG4500530_360863%>%filter(between(date_time, as.Date('2018-07-01'), as.Date('2018-07-31')))
weatherG4500530_363396<-weatherG4500530_363396%>%filter(between(date_time, as.Date('2018-07-01'), as.Date('2018-07-31')))
weatherG4500530_436552<-weatherG4500530_436552%>%filter(between(date_time, as.Date('2018-07-01'), as.Date('2018-07-31')))
weatherG4500530_495411<-weatherG4500530_495411%>%filter(between(date_time, as.Date('2018-07-01'), as.Date('2018-07-31')))
weatherG4500530_505669<-weatherG4500530_505669%>%filter(between(date_time, as.Date('2018-07-01'), as.Date('2018-07-31')))


paste("weatherG4500530_",HotHouses$bldg_id,"$bldg_id","<-","'",HotHouses$bldg_id, "'",sep="")

weatherG4500530_9590$bldg_id<-'9590'
weatherG4500530_20799$bldg_id<-'20799'
weatherG4500530_42807$bldg_id<-'42807'  
weatherG4500530_45565$bldg_id<-'45565' 
weatherG4500530_51955$bldg_id<-'51955' 
weatherG4500530_89793$bldg_id<-'89793'  
weatherG4500530_114167$bldg_id<-'114167'
weatherG4500530_126714$bldg_id<-'126714'
weatherG4500530_142919$bldg_id<-'142919' 
weatherG4500530_169672$bldg_id<-'169672'
weatherG4500530_174809$bldg_id<-'174809'
weatherG4500530_181726$bldg_id<-'181726'
weatherG4500530_187030$bldg_id<-'187030'
weatherG4500530_192420$bldg_id<-'192420'
weatherG4500530_209925$bldg_id<-'209925' 
weatherG4500530_275868$bldg_id<-'275868'
weatherG4500530_276948$bldg_id<-'276948' 
weatherG4500530_289369$bldg_id<-'289369'
weatherG4500530_290138$bldg_id<-'290138'
weatherG4500530_295891$bldg_id<-'295891'
weatherG4500530_296938$bldg_id<-'296938'
weatherG4500530_357971$bldg_id<-'357971'
weatherG4500530_360863$bldg_id<-'360863'
weatherG4500530_363396$bldg_id<-'363396'
weatherG4500530_436552$bldg_id<-'436552'
weatherG4500530_495411$bldg_id<-'495411'
weatherG4500530_505669$bldg_id<-'505669'





#Merge all data frames into one energy file for county G4500530

HotEnergyDataCountyG4500530<-rbind(weatherG4500530_9590, weatherG4500530_20799, weatherG4500530_42807, weatherG4500530_45565,
                                   weatherG4500530_51955, weatherG4500530_89793, weatherG4500530_114167, weatherG4500530_126714,
                                   weatherG4500530_142919, weatherG4500530_169672, weatherG4500530_174809, weatherG4500530_181726,
                                   weatherG4500530_187030, weatherG4500530_192420, weatherG4500530_209925, weatherG4500530_275868,
                                   weatherG4500530_276948, weatherG4500530_289369, weatherG4500530_290138, weatherG4500530_295891,
                                   weatherG4500530_296938, weatherG4500530_357971, weatherG4500530_360863, weatherG4500530_363396,
                                   weatherG4500530_436552, weatherG4500530_495411, weatherG4500530_505669)








#Repeat Process for 'Coldest' county


mergecountyweather<- function(county){
  name<-paste("weather",county,"_",ColdHouses$bldg_id, "<-",sep="")
  input<-paste("merge(weather", county, ",energy", ColdHouses$bldg_id,",by.x='date_time',by.y='time')", sep="")
  x<-paste(name,input)
  return(x)
}

#Merge with county weather for G4500210
weatherG4500210_9756<- merge(weatherG4500210,energy9756,by.x='date_time',by.y='time')    
weatherG4500210_21893<- merge(weatherG4500210,energy21893,by.x='date_time',by.y='time') 
weatherG4500210_32634<- merge(weatherG4500210,energy32634,by.x='date_time',by.y='time') 
weatherG4500210_38693<- merge(weatherG4500210,energy38693,by.x='date_time',by.y='time') 
weatherG4500210_42264<- merge(weatherG4500210,energy42264,by.x='date_time',by.y='time') 
weatherG4500210_62053<- merge(weatherG4500210,energy62053,by.x='date_time',by.y='time') 
weatherG4500210_65081<- merge(weatherG4500210,energy65081,by.x='date_time',by.y='time') 
weatherG4500210_70556<- merge(weatherG4500210,energy70556,by.x='date_time',by.y='time')
weatherG4500210_73790<- merge(weatherG4500210,energy73790,by.x='date_time',by.y='time') 
weatherG4500210_84593<- merge(weatherG4500210,energy84593,by.x='date_time',by.y='time') 
weatherG4500210_86055<- merge(weatherG4500210,energy86055,by.x='date_time',by.y='time') 
weatherG4500210_93405<- merge(weatherG4500210,energy93405,by.x='date_time',by.y='time') 
weatherG4500210_98000<- merge(weatherG4500210,energy98000,by.x='date_time',by.y='time') 
weatherG4500210_106029<- merge(weatherG4500210,energy106029,by.x='date_time',by.y='time')
weatherG4500210_121408<- merge(weatherG4500210,energy121408,by.x='date_time',by.y='time')
weatherG4500210_152486<- merge(weatherG4500210,energy152486,by.x='date_time',by.y='time')
weatherG4500210_166440<- merge(weatherG4500210,energy166440,by.x='date_time',by.y='time')
weatherG4500210_166922<- merge(weatherG4500210,energy166922,by.x='date_time',by.y='time')
weatherG4500210_185048<- merge(weatherG4500210,energy185048,by.x='date_time',by.y='time')
weatherG4500210_187343<- merge(weatherG4500210,energy187343,by.x='date_time',by.y='time')
weatherG4500210_191084<- merge(weatherG4500210,energy191084,by.x='date_time',by.y='time')
weatherG4500210_194578<- merge(weatherG4500210,energy194578,by.x='date_time',by.y='time')
weatherG4500210_195774<- merge(weatherG4500210,energy195774,by.x='date_time',by.y='time')
weatherG4500210_203513<- merge(weatherG4500210,energy203513,by.x='date_time',by.y='time')
weatherG4500210_211416<- merge(weatherG4500210,energy211416,by.x='date_time',by.y='time')
weatherG4500210_214222<- merge(weatherG4500210,energy214222,by.x='date_time',by.y='time')
weatherG4500210_224699<- merge(weatherG4500210,energy224699,by.x='date_time',by.y='time')
weatherG4500210_241708<- merge(weatherG4500210,energy241708,by.x='date_time',by.y='time')
weatherG4500210_249664<- merge(weatherG4500210,energy249664,by.x='date_time',by.y='time')
weatherG4500210_258649<- merge(weatherG4500210,energy258649,by.x='date_time',by.y='time')
weatherG4500210_259244<- merge(weatherG4500210,energy259244,by.x='date_time',by.y='time')
weatherG4500210_270423<- merge(weatherG4500210,energy270423,by.x='date_time',by.y='time')
weatherG4500210_273162<- merge(weatherG4500210,energy273162,by.x='date_time',by.y='time')
weatherG4500210_274323<- merge(weatherG4500210,energy274323,by.x='date_time',by.y='time')
weatherG4500210_281886<- merge(weatherG4500210,energy281886,by.x='date_time',by.y='time')
weatherG4500210_314169<- merge(weatherG4500210,energy314169,by.x='date_time',by.y='time')
weatherG4500210_337684<- merge(weatherG4500210,energy337684,by.x='date_time',by.y='time')
weatherG4500210_344708<- merge(weatherG4500210,energy344708,by.x='date_time',by.y='time')
weatherG4500210_355961<- merge(weatherG4500210,energy355961,by.x='date_time',by.y='time')
weatherG4500210_361437<- merge(weatherG4500210,energy361437,by.x='date_time',by.y='time')
weatherG4500210_362040<- merge(weatherG4500210,energy362040,by.x='date_time',by.y='time')
weatherG4500210_378103<- merge(weatherG4500210,energy378103,by.x='date_time',by.y='time')
weatherG4500210_385223<- merge(weatherG4500210,energy385223,by.x='date_time',by.y='time')
weatherG4500210_388882<- merge(weatherG4500210,energy388882,by.x='date_time',by.y='time')
weatherG4500210_388957<- merge(weatherG4500210,energy388957,by.x='date_time',by.y='time')
weatherG4500210_395711<- merge(weatherG4500210,energy395711,by.x='date_time',by.y='time')
weatherG4500210_396313<- merge(weatherG4500210,energy396313,by.x='date_time',by.y='time')
weatherG4500210_401968<- merge(weatherG4500210,energy401968,by.x='date_time',by.y='time')
weatherG4500210_429521<- merge(weatherG4500210,energy429521,by.x='date_time',by.y='time')
weatherG4500210_435590<- merge(weatherG4500210,energy435590,by.x='date_time',by.y='time')
weatherG4500210_454524<- merge(weatherG4500210,energy454524,by.x='date_time',by.y='time')
weatherG4500210_460013<- merge(weatherG4500210,energy460013,by.x='date_time',by.y='time')
weatherG4500210_460880<- merge(weatherG4500210,energy460880,by.x='date_time',by.y='time')
weatherG4500210_466403<- merge(weatherG4500210,energy466403,by.x='date_time',by.y='time')
weatherG4500210_473013<- merge(weatherG4500210,energy473013,by.x='date_time',by.y='time')
weatherG4500210_493441<- merge(weatherG4500210,energy493441,by.x='date_time',by.y='time')
weatherG4500210_515843<- merge(weatherG4500210,energy515843,by.x='date_time',by.y='time')
weatherG4500210_519668<- merge(weatherG4500210,energy519668,by.x='date_time',by.y='time')
weatherG4500210_522528<- merge(weatherG4500210,energy522528,by.x='date_time',by.y='time')
weatherG4500210_537193<- merge(weatherG4500210,energy537193,by.x='date_time',by.y='time')
weatherG4500210_538921<- merge(weatherG4500210,energy538921,by.x='date_time',by.y='time')
weatherG4500210_547621<- merge(weatherG4500210,energy547621,by.x='date_time',by.y='time')


#Filter for July
paste("weatherG4500210_",ColdHouses$bldg_id, "<-weatherG4500210_",ColdHouses$bldg_id, "%>%filter(between(date_time, as.Date('2018-07-01'), as.Date('2018-07-31')))", sep="" )

weatherG4500210_9756<-weatherG4500210_9756%>%filter(between(date_time, as.Date('2018-07-01'), as.Date('2018-07-31')))   
weatherG4500210_21893<-weatherG4500210_21893%>%filter(between(date_time, as.Date('2018-07-01'), as.Date('2018-07-31'))) 
weatherG4500210_32634<-weatherG4500210_32634%>%filter(between(date_time, as.Date('2018-07-01'), as.Date('2018-07-31'))) 
weatherG4500210_38693<-weatherG4500210_38693%>%filter(between(date_time, as.Date('2018-07-01'), as.Date('2018-07-31')))  
weatherG4500210_42264<-weatherG4500210_42264%>%filter(between(date_time, as.Date('2018-07-01'), as.Date('2018-07-31')))  
weatherG4500210_62053<-weatherG4500210_62053%>%filter(between(date_time, as.Date('2018-07-01'), as.Date('2018-07-31')))  
weatherG4500210_65081<-weatherG4500210_65081%>%filter(between(date_time, as.Date('2018-07-01'), as.Date('2018-07-31')))  
weatherG4500210_70556<-weatherG4500210_70556%>%filter(between(date_time, as.Date('2018-07-01'), as.Date('2018-07-31')))  
weatherG4500210_73790<-weatherG4500210_73790%>%filter(between(date_time, as.Date('2018-07-01'), as.Date('2018-07-31')))  
weatherG4500210_84593<-weatherG4500210_84593%>%filter(between(date_time, as.Date('2018-07-01'), as.Date('2018-07-31')))  
weatherG4500210_86055<-weatherG4500210_86055%>%filter(between(date_time, as.Date('2018-07-01'), as.Date('2018-07-31')))  
weatherG4500210_93405<-weatherG4500210_93405%>%filter(between(date_time, as.Date('2018-07-01'), as.Date('2018-07-31')))  
weatherG4500210_98000<-weatherG4500210_98000%>%filter(between(date_time, as.Date('2018-07-01'), as.Date('2018-07-31'))) 
weatherG4500210_106029<-weatherG4500210_106029%>%filter(between(date_time, as.Date('2018-07-01'), as.Date('2018-07-31')))
weatherG4500210_121408<-weatherG4500210_121408%>%filter(between(date_time, as.Date('2018-07-01'), as.Date('2018-07-31')))
weatherG4500210_152486<-weatherG4500210_152486%>%filter(between(date_time, as.Date('2018-07-01'), as.Date('2018-07-31')))
weatherG4500210_166440<-weatherG4500210_166440%>%filter(between(date_time, as.Date('2018-07-01'), as.Date('2018-07-31')))
weatherG4500210_166922<-weatherG4500210_166922%>%filter(between(date_time, as.Date('2018-07-01'), as.Date('2018-07-31')))
weatherG4500210_185048<-weatherG4500210_185048%>%filter(between(date_time, as.Date('2018-07-01'), as.Date('2018-07-31')))
weatherG4500210_187343<-weatherG4500210_187343%>%filter(between(date_time, as.Date('2018-07-01'), as.Date('2018-07-31')))
weatherG4500210_191084<-weatherG4500210_191084%>%filter(between(date_time, as.Date('2018-07-01'), as.Date('2018-07-31')))
weatherG4500210_194578<-weatherG4500210_194578%>%filter(between(date_time, as.Date('2018-07-01'), as.Date('2018-07-31')))
weatherG4500210_195774<-weatherG4500210_195774%>%filter(between(date_time, as.Date('2018-07-01'), as.Date('2018-07-31')))
weatherG4500210_203513<-weatherG4500210_203513%>%filter(between(date_time, as.Date('2018-07-01'), as.Date('2018-07-31')))
weatherG4500210_211416<-weatherG4500210_211416%>%filter(between(date_time, as.Date('2018-07-01'), as.Date('2018-07-31')))
weatherG4500210_214222<-weatherG4500210_214222%>%filter(between(date_time, as.Date('2018-07-01'), as.Date('2018-07-31')))
weatherG4500210_224699<-weatherG4500210_224699%>%filter(between(date_time, as.Date('2018-07-01'), as.Date('2018-07-31')))
weatherG4500210_241708<-weatherG4500210_241708%>%filter(between(date_time, as.Date('2018-07-01'), as.Date('2018-07-31')))
weatherG4500210_249664<-weatherG4500210_249664%>%filter(between(date_time, as.Date('2018-07-01'), as.Date('2018-07-31')))
weatherG4500210_258649<-weatherG4500210_258649%>%filter(between(date_time, as.Date('2018-07-01'), as.Date('2018-07-31')))
weatherG4500210_259244<-weatherG4500210_259244%>%filter(between(date_time, as.Date('2018-07-01'), as.Date('2018-07-31')))
weatherG4500210_270423<-weatherG4500210_270423%>%filter(between(date_time, as.Date('2018-07-01'), as.Date('2018-07-31')))
weatherG4500210_273162<-weatherG4500210_273162%>%filter(between(date_time, as.Date('2018-07-01'), as.Date('2018-07-31')))
weatherG4500210_274323<-weatherG4500210_274323%>%filter(between(date_time, as.Date('2018-07-01'), as.Date('2018-07-31')))
weatherG4500210_281886<-weatherG4500210_281886%>%filter(between(date_time, as.Date('2018-07-01'), as.Date('2018-07-31')))
weatherG4500210_314169<-weatherG4500210_314169%>%filter(between(date_time, as.Date('2018-07-01'), as.Date('2018-07-31')))
weatherG4500210_337684<-weatherG4500210_337684%>%filter(between(date_time, as.Date('2018-07-01'), as.Date('2018-07-31')))
weatherG4500210_344708<-weatherG4500210_344708%>%filter(between(date_time, as.Date('2018-07-01'), as.Date('2018-07-31')))
weatherG4500210_355961<-weatherG4500210_355961%>%filter(between(date_time, as.Date('2018-07-01'), as.Date('2018-07-31')))
weatherG4500210_361437<-weatherG4500210_361437%>%filter(between(date_time, as.Date('2018-07-01'), as.Date('2018-07-31')))
weatherG4500210_362040<-weatherG4500210_362040%>%filter(between(date_time, as.Date('2018-07-01'), as.Date('2018-07-31')))
weatherG4500210_378103<-weatherG4500210_378103%>%filter(between(date_time, as.Date('2018-07-01'), as.Date('2018-07-31')))
weatherG4500210_385223<-weatherG4500210_385223%>%filter(between(date_time, as.Date('2018-07-01'), as.Date('2018-07-31')))
weatherG4500210_388882<-weatherG4500210_388882%>%filter(between(date_time, as.Date('2018-07-01'), as.Date('2018-07-31')))
weatherG4500210_388957<-weatherG4500210_388957%>%filter(between(date_time, as.Date('2018-07-01'), as.Date('2018-07-31')))
weatherG4500210_395711<-weatherG4500210_395711%>%filter(between(date_time, as.Date('2018-07-01'), as.Date('2018-07-31')))
weatherG4500210_396313<-weatherG4500210_396313%>%filter(between(date_time, as.Date('2018-07-01'), as.Date('2018-07-31')))
weatherG4500210_401968<-weatherG4500210_401968%>%filter(between(date_time, as.Date('2018-07-01'), as.Date('2018-07-31')))
weatherG4500210_429521<-weatherG4500210_429521%>%filter(between(date_time, as.Date('2018-07-01'), as.Date('2018-07-31')))
weatherG4500210_435590<-weatherG4500210_435590%>%filter(between(date_time, as.Date('2018-07-01'), as.Date('2018-07-31')))
weatherG4500210_454524<-weatherG4500210_454524%>%filter(between(date_time, as.Date('2018-07-01'), as.Date('2018-07-31')))
weatherG4500210_460013<-weatherG4500210_460013%>%filter(between(date_time, as.Date('2018-07-01'), as.Date('2018-07-31')))
weatherG4500210_460880<-weatherG4500210_460880%>%filter(between(date_time, as.Date('2018-07-01'), as.Date('2018-07-31')))
weatherG4500210_466403<-weatherG4500210_466403%>%filter(between(date_time, as.Date('2018-07-01'), as.Date('2018-07-31')))
weatherG4500210_473013<-weatherG4500210_473013%>%filter(between(date_time, as.Date('2018-07-01'), as.Date('2018-07-31')))
weatherG4500210_493441<-weatherG4500210_493441%>%filter(between(date_time, as.Date('2018-07-01'), as.Date('2018-07-31')))
weatherG4500210_515843<-weatherG4500210_515843%>%filter(between(date_time, as.Date('2018-07-01'), as.Date('2018-07-31')))
weatherG4500210_519668<-weatherG4500210_519668%>%filter(between(date_time, as.Date('2018-07-01'), as.Date('2018-07-31')))
weatherG4500210_522528<-weatherG4500210_522528%>%filter(between(date_time, as.Date('2018-07-01'), as.Date('2018-07-31')))
weatherG4500210_537193<-weatherG4500210_537193%>%filter(between(date_time, as.Date('2018-07-01'), as.Date('2018-07-31')))
weatherG4500210_538921<-weatherG4500210_538921%>%filter(between(date_time, as.Date('2018-07-01'), as.Date('2018-07-31')))
weatherG4500210_547621<-weatherG4500210_547621%>%filter(between(date_time, as.Date('2018-07-01'), as.Date('2018-07-31')))


#Add bldg id column
paste("weatherG4500210_",ColdHouses$bldg_id,"$bldg_id","<-","'",ColdHouses$bldg_id, "'",sep="")
weatherG4500210_9756$bldg_id<-'9756'     
weatherG4500210_21893$bldg_id<-'21893'
weatherG4500210_32634$bldg_id<-'32634'
weatherG4500210_38693$bldg_id<-'38693'  
weatherG4500210_42264$bldg_id<-'42264'
weatherG4500210_62053$bldg_id<-'62053'  
weatherG4500210_65081$bldg_id<-'65081'
weatherG4500210_70556$bldg_id<-'70556'  
weatherG4500210_73790$bldg_id<-'73790'
weatherG4500210_84593$bldg_id<-'84593'  
weatherG4500210_86055$bldg_id<-'86055'
weatherG4500210_93405$bldg_id<-'93405'  
weatherG4500210_98000$bldg_id<-'98000'
weatherG4500210_106029$bldg_id<-'106029'
weatherG4500210_121408$bldg_id<-'121408'
weatherG4500210_152486$bldg_id<-'152486'
weatherG4500210_166440$bldg_id<-'166440'
weatherG4500210_166922$bldg_id<-'166922'
weatherG4500210_185048$bldg_id<-'185048'
weatherG4500210_187343$bldg_id<-'187343'
weatherG4500210_191084$bldg_id<-'191084'
weatherG4500210_194578$bldg_id<-'194578'
weatherG4500210_195774$bldg_id<-'195774'
weatherG4500210_203513$bldg_id<-'203513'
weatherG4500210_211416$bldg_id<-'211416'
weatherG4500210_214222$bldg_id<-'214222'
weatherG4500210_224699$bldg_id<-'224699'
weatherG4500210_241708$bldg_id<-'241708'
weatherG4500210_249664$bldg_id<-'249664'
weatherG4500210_258649$bldg_id<-'258649'
weatherG4500210_259244$bldg_id<-'259244'
weatherG4500210_270423$bldg_id<-'270423'
weatherG4500210_273162$bldg_id<-'273162'
weatherG4500210_274323$bldg_id<-'274323'
weatherG4500210_281886$bldg_id<-'281886'
weatherG4500210_314169$bldg_id<-'314169'
weatherG4500210_337684$bldg_id<-'337684'
weatherG4500210_344708$bldg_id<-'344708'
weatherG4500210_355961$bldg_id<-'355961'
weatherG4500210_361437$bldg_id<-'361437'
weatherG4500210_362040$bldg_id<-'362040'
weatherG4500210_378103$bldg_id<-'378103'
weatherG4500210_385223$bldg_id<-'385223'
weatherG4500210_388882$bldg_id<-'388882'
weatherG4500210_388957$bldg_id<-'388957'
weatherG4500210_395711$bldg_id<-'395711'
weatherG4500210_396313$bldg_id<-'396313'
weatherG4500210_401968$bldg_id<-'401968'
weatherG4500210_429521$bldg_id<-'429521'
weatherG4500210_435590$bldg_id<-'435590'
weatherG4500210_454524$bldg_id<-'454524'
weatherG4500210_460013$bldg_id<-'460013'
weatherG4500210_460880$bldg_id<-'460880'
weatherG4500210_466403$bldg_id<-'466403'
weatherG4500210_473013$bldg_id<-'473013'
weatherG4500210_493441$bldg_id<-'493441'
weatherG4500210_515843$bldg_id<-'515843'
weatherG4500210_519668$bldg_id<-'519668'
weatherG4500210_522528$bldg_id<-'522528'
weatherG4500210_537193$bldg_id<-'537193'
weatherG4500210_538921$bldg_id<-'538921'
weatherG4500210_547621$bldg_id<-'547621'






#Merge all data frames into one energy file for county G4500530
paste("weatherG4500210_",ColdHouses$bldg_id,sep="")

ColdEnergyDataCountyG4500210<-rbind( weatherG4500210_9756, weatherG4500210_21893, weatherG4500210_32634, weatherG4500210_38693, 
                                     weatherG4500210_42264, weatherG4500210_62053, weatherG4500210_65081, weatherG4500210_70556, 
                                     weatherG4500210_73790, weatherG4500210_84593, weatherG4500210_86055, weatherG4500210_93405, 
                                     weatherG4500210_98000, weatherG4500210_106029, weatherG4500210_121408, weatherG4500210_152486,
                                     weatherG4500210_166440, weatherG4500210_166922, weatherG4500210_185048, weatherG4500210_187343,
                                     weatherG4500210_191084, weatherG4500210_194578, weatherG4500210_195774, weatherG4500210_203513,
                                     weatherG4500210_211416, weatherG4500210_214222, weatherG4500210_224699, weatherG4500210_241708,
                                     weatherG4500210_249664, weatherG4500210_258649, weatherG4500210_259244, weatherG4500210_270423,
                                     weatherG4500210_273162, weatherG4500210_274323, weatherG4500210_281886, weatherG4500210_314169,
                                     weatherG4500210_337684, weatherG4500210_344708, weatherG4500210_355961, weatherG4500210_361437,
                                     weatherG4500210_362040, weatherG4500210_378103, weatherG4500210_385223, weatherG4500210_388882,
                                     weatherG4500210_388957, weatherG4500210_395711, weatherG4500210_396313, weatherG4500210_401968,
                                     weatherG4500210_429521, weatherG4500210_435590, weatherG4500210_454524, weatherG4500210_460013,
                                     weatherG4500210_460880, weatherG4500210_466403, weatherG4500210_473013, weatherG4500210_493441,
                                     weatherG4500210_515843, weatherG4500210_519668, weatherG4500210_522528, weatherG4500210_537193,
                                     weatherG4500210_538921, weatherG4500210_547621)



#Merge House Data with Energy/Weather Data

HotEnergyDataCountyG4500530$
  
  HotandColdAll<-merge(HotandCold,HotEnergyDataCountyG4500530,by="bldg_id")


#Make character variables into factors
convert_to_factor <- function(dataframe, columns) {
  for (col in columns) {
    if (is.character(dataframe[[col]])) {
      dataframe[[col]] <- as.factor(dataframe[[col]])
    } else {
      warning(paste0("Column ", col, " is not of character type. Skipping..."))
    }
  }
  return(dataframe)
}


HotandColdAll<- convert_to_factor(HotandColdAll, c('Building_ID', 'out.electricity.ceiling_fan.energy_consumption', 'out.electricity.clothes_dryer.energy_consumption',
                                                   'out.electricity.clothes_washer.energy_consumption', 'out.electricity.cooling_fans_pumps.energy_consumption',
                                                   'out.electricity.cooling.energy_consumption', 'out.electricity.dishwasher.energy_consumption', 
                                                   'out.electricity.freezer.energy_consumption', 'out.electricity.heating_fans_pumps.energy_consumption', 'out.electricity.heating_hp_bkup.energy_consumption', 'out.electricity.heating.energy_consumption',
                                                   'out.electricity.hot_tub_heater.energy_consumption', 'out.electricity.hot_tub_pump.energy_consumption', 'out.electricity.hot_water.energy_consumption', 'out.electricity.lighting_exterior.energy_consumption', 'out.electricity.lighting_garage.energy_consumption', 
                                                   'out.electricity.lighting_interior.energy_consumption', 'out.electricity.mech_vent.energy_consumption',
                                                   'out.electricity.plug_loads.energy_consumption', 'out.electricity.pool_heater.energy_consumption',
                                                   'out.electricity.pool_pump.energy_consumption', 'out.electricity.pv.energy_consumption', 
                                                   'out.electricity.range_oven.energy_consumption', 'out.electricity.refrigerator.energy_consumption', 
                                                   'out.electricity.well_pump.energy_consumption', 'out.fuel_oil.heating_hp_bkup.energy_consumption', 
                                                   'out.fuel_oil.heating.energy_consumption', 'out.fuel_oil.hot_water.energy_consumption', 
                                                   'out.natural_gas.clothes_dryer.energy_consumption', 'out.natural_gas.fireplace.energy_consumption', 
                                                   'out.natural_gas.grill.energy_consumption', 'out.natural_gas.heating_hp_bkup.energy_consumption', 'out.natural_gas.heating.energy_consumption', 'out.natural_gas.hot_tub_heater.energy_consumption', 
                                                   'out.natural_gas.hot_water.energy_consumption', 'out.natural_gas.lighting.energy_consumption', 
                                                   'out.natural_gas.pool_heater.energy_consumption', 'out.natural_gas.range_oven.energy_consumption', 
                                                   'out.propane.clothes_dryer.energy_consumption', 'out.propane.heating_hp_bkup.energy_consumption', 
                                                   'out.propane.heating.energy_consumption', 'out.propane.hot_water.energy_consumption', 
                                                   'out.propane.range_oven.energy_consumption', 'time', 'month', 'in.sqft', 'in.bathroom_spot_vent_hour', 'in.bedrooms', 'in.building_america_climate_zone', 'in.ceiling_fan', 'in.city', 'in.clothes_dryer', 'in.clothes_washer', 'in.clothes_washer_presence', 'in.cooking_range', 'in.cooling_setpoint', 'in.cooling_setpoint_has_offset',
                                                   'in.cooling_setpoint_offset_magnitude', 'in.cooling_setpoint_offset_period', 'in.county', 'in.county_and_puma', 
                                                   'in.dishwasher', 'in.ducts', 'in.federal_poverty_level', 'in.geometry_attic_type', 'in.geometry_floor_area', 
                                                   'in.geometry_floor_area_bin', 'in.geometry_foundation_type', 'in.geometry_garage', 'in.geometry_stories',
                                                   'in.geometry_stories_low_rise', 'in.geometry_wall_exterior_finish', 'in.geometry_wall_type', 'in.has_pv', 
                                                   'in.heating_fuel', 'in.heating_setpoint', 'in.heating_setpoint_has_offset', 'in.heating_setpoint_offset_magnitude', 
                                                   'in.heating_setpoint_offset_period', 'in.hot_water_fixtures', 'in.hvac_cooling_efficiency', 'in.hvac_cooling_partial_space_conditioning', 'in.hvac_cooling_type', 'in.hvac_has_ducts', 'in.hvac_has_zonal_electric_heating',
                                                   'in.hvac_heating_efficiency', 'in.hvac_heating_type', 'in.hvac_heating_type_and_fuel', 'in.income', 'in.income_recs_2015', 'in.income_recs_2020', 'in.infiltration', 'in.insulation_ceiling', 'in.insulation_floor', 'in.insulation_foundation_wall', 'in.insulation_rim_joist', 'in.insulation_roof', 'in.insulation_slab', 'in.insulation_wall', 'in.lighting', 'in.misc_extra_refrigerator', 'in.misc_freezer', 'in.misc_gas_fireplace', 'in.misc_gas_grill', 'in.misc_gas_lighting', 'in.misc_hot_tub_spa', 'in.misc_pool', 'in.misc_pool_heater', 'in.misc_pool_pump', 'in.misc_well_pump', 'in.occupants', 'in.orientation', 'in.plug_load_diversity', 'in.puma', 'in.puma_metro_status', 'in.pv_orientation',
                                                   'in.pv_system_size', 'in.range_spot_vent_hour', 'in.reeds_balancing_area', 'in.refrigerator',
                                                   'in.roof_material', 'in.tenure', 'in.usage_level', 'in.vacancy_status', 'in.vintage', 'in.vintage_acs',
                                                   'in.water_heater_efficiency', 'in.water_heater_fuel', 'in.weather_file_city', 'in.weather_file_latitude',
                                                   'in.weather_file_longitude', 'in.window_areas', 'in.windows', 'upgrade.water_heater_efficiency',
                                                   'upgrade.clothes_dryer', 'upgrade.hvac_heating_efficiency', 'upgrade.cooking_range'))




str(HotandColdAll)
boxplot()

ggplot(ColdEnergyDataCountyG4500210) + aes(x=date_time,y=ColdEnergyDataCountyG4500210$out.electricity.cooling.energy_consumption)+geom_line()
ggplot(energy_usage_102063_July_Grouped) + aes(x=energy_usage_102063_July_Grouped$day,y=energy_usage_102063_July_Grouped$out.electricity.cooling.energy_consumption)+geom_line()


NUMColdEnergyDataCountyG4500210<-ColdEnergyDataCountyG4500210[,2:50]
str(NUMColdEnergyDataCountyG4500210)

NUMHotEnergyDataCountyG4500530<-HotEnergyDataCountyG4500530[,2:50]
colSums(NUMHotEnergyDataCountyG4500530)

#Which Vars use the most energy
colSums(NUMColdEnergyDataCountyG4500210)  
sum<-colSums(NUMColdEnergyDataCountyG4500210)  
sum

#out.electricity.clothes_dryer.energy_consumption --- 1.130618e+03 
#out.electricity.cooling_fans_pumps.energy_consumption --- 1.020068e+03
#out.electricity.cooling.energy_consumption ---1.835254e+04 
#out.electricity.hot_water.energy_consumption --- 2.343544e+03
#out.electricity.lighting_interior.energy_consumption --- 3.322427e+03
#out.electricity.plug_loads.energy_consumption --- 1.031952e+04
#out.electricity.pool_pump.energy_consumption --- 1.064748e+03
#out.electricity.range_oven.energy_consumption  --- 1.503836e+03
#out.electricity.refrigerator.energy_consumption --- 3.475796e+03 


#out.electricity.cooling.energy_consumption --14254.9630
#out.electricity.plug_loads.energy_consumption -- 4221.4880
#out.electricity.lighting_interior.energy_consumption -- 1738.6400
#out.electricity.refrigerator.energy_consumption -- 1782.2970



--------------------------
  #Modeling Attempts
  
  
  model<-ksvm(ColdEnergyDataCountyG4500210$out.electricity.cooling.energy_consumption, ColdEnergyDataCountyG4500210$`Dry Bulb Temperature [°C]`, data = trainSet, type="eps-svr",cost=5,cross=3)
model

svm.radial = tune(ksvm,ColdEnergyDataCountyG4500210$out.electricity.cooling.energy_consumption ~ ColdEnergyDataCountyG4500210$`Dry Bulb Temperature [°C]`, data = trainSet , type = "eps-svr" , 
                  ranges = list( cost = c(0.001 , 0.01 , 0.1 , 1 , 5 , 10 , 50 ) , gamma = c( .0001 , .001 , .01 , .1 , 1 , 5 , 10 ) ) )


library(e1071)
library(rpart)
library(rpart.plot)
library(caret)
library(kernlab)
set.seed(123)


trainingIndex1 <- createDataPartition(HotandColdAll$out.electricity.cooling.energy_consumption, p = .7, list = FALSE)
trainingData1 <- HotandColdAll[trainingIndex1, ]
testingData1 <- HotandColdAll[-trainingIndex1, ]

#str(trainingData1$out.electricity.cooling.energy_consumption)
#str(trainingData1$`Dry Bulb Temperature [°C]`)
svmOut1 <- ksvm(out.electricity.cooling.energy_consumption ~ in.hvac_cooling_type, data = trainingData1, C = 5, cross = 3, prob.model = TRUE)
svmOut1

svmPred <- predict(svmOut1, newdata = testingData1, type = "response")
head(svmPred)
table()

plot(HotandColdAll$out.electricity.cooling.energy_consumption)
plot(svmPred)

plot(testingData1$out.electricity.cooling.energy_consumption, svmPred,
     xlab = "Actual Values", ylab = "Predicted Values",
     main = "Predicted vs Actual Values", col = "blue", pch = 16)

# Add a reference line with slope 1 (perfect prediction)
abline(a = 0, b = 1, col = "red", lwd = 2)


lmOutHotCold<-lm(formula= out.electricity.cooling.energy_consumption ~ in.hvac_cooling_type + 
                   in.cooling_setpoint + `Dry Bulb Temperature [°C]` + in.sqft + 
                   in.insulation_foundation_wall + in.hvac_cooling_efficiency + in.geometry_wall_type +
                   , data=HotandColdAll)
summary(lmOutHotCold)
str(HotandColdAll$in.hvac_cooling_type)




str(HotandColdAll$Temps)

treemodel <- rpart(HotandColdAll$~ ., data = trainingData1)
rpart.plot(treemodel)


dim(svmPred)
dim(testingData1$out.electricity.cooling.energy_consumption)



#Base Data
static_house_data <- read_parquet("Downloads/static_house_info.parquet")
static_house_dataEDA<-static_house_data


#Find and remove redundant columns with no unique values
static_house_dataEDAcleanedcolumns<-static_house_dataEDA[,-c(2,3,4,6,7,8,12,14,15,16, 26, 29, 31,32,
                                                             34,35,36,37,38,39,40,41,42,43,44,45,47,
                                                             49,50,51,52,53,54,55,56,63,72,73,79,84,
                                                             85,86,87,88,89,90,91,103,104,106,107,108
                                                             ,109,120,121,124,126,131,136,137,138,139,
                                                             140,141,142,143,144,146,153,159,161,162,
                                                             163,165,166,167,168,169)]



#Load in all weather files
read_in_weatherfiles <- function(dataframe, id_column) {
  
  common_url <- "https://intro-datascience.s3.us-east-2.amazonaws.com/SC-data/weather/2023-weather-data/"
  csv_ext <- ".csv"
  
  weather_data <- list()
  
  for (county_id in dataframe[[id_column]]) {
    url <- paste0(common_url, county_id, csv_ext)
    weather_df <- read_csv(url)
    weather_df$County_ID <- county_id  # Add a new column for the county ID
    weather_data[[county_id]] <- weather_df
  }
  
  return(weather_data)
}

# Example usage:
dataframe <- static_house_dataEDAcleanedcolumns  # Your dataframe containing county IDs
id_column <- "in.county"   # Name of the column containing county IDs
weather_data <- read_in_weatherfiles(dataframe, id_column)
ALL_combined_weather <- bind_rows(weather_data)

#Filter for July
ALL_weather_July<-ALL_combined_weather%>%filter(between(date_time, as.Date('2018-07-01'), as.Date('2018-07-31'))) 

#Group by time and find the when temp peaks/dips
library(tidyverse)

ALL_weather_July$time <- format(ALL_weather_July$date_time, format = "%H:%M:%S")
HottestHour<- ALL_weather_July %>%
  group_by(time) %>%
  summarise(Avg_Hourly_Temp = mean(`Dry Bulb Temperature [°C]`))

order(HottestHour$Avg_Hourly_Temp)



#Group by county and find average monthly temp
library(tidyverse)
MAXweather<- ALL_weather_July %>%
  group_by(County_ID) %>%
  summarise(Avg_Monthly_Temp = mean(`Dry Bulb Temperature [°C]`))


#Static House data for buildings in the hottest 3 counties 
HotCounties<-static_house_dataEDAcleanedcolumns %>% filter(in.county %in% c("G4500630","G4500710", "G4500130"))
HotCounties$Temps<-"Hot"
HotCounties$Temps<-as.factor(HotCounties$Temps)
#Static House data for buildings in the "coldest" 3 counties
ColdCounties<-static_house_dataEDAcleanedcolumns %>% filter(in.county %in% c("G4500210","G4500010", "G4500470"))
ColdCounties$Temps<-"Cold"
ColdCounties$Temps<-as.factor(ColdCounties$Temps)

#Combine into one test data set
HotColdCounties<-rbind(HotCounties,ColdCounties)


#Load the corresponding energy files
#Read in the energy files for the sample houses
read_in_energyfiles <- function(dataframe, id_column) {
  
  common_url <- "https://intro-datascience.s3.us-east-2.amazonaws.com/SC-data/2023-houseData/"
  parquet_ext <- ".parquet"
  
  energy_data <- list()
  
  for (bldg_id in dataframe[[id_column]]) {
    url <- paste0(common_url, bldg_id, parquet_ext)
    energy_df <- arrow::read_parquet(url)
    energy_df$Building_ID <- bldg_id  # Add a new column for the building ID
    energy_data[[bldg_id]] <- energy_df
  }
  
  return(energy_data)
}

# Run Function to fetch Energy Files
dataframe <- HotColdCounties  # dataframe containing building IDs
id_column <- "bldg_id"   
energy_data <- read_in_energyfiles(dataframe, id_column)

#Combine into one large energy fule
combined_energy <- do.call(rbind, energy_data)


#Filter for just July
combined_energy<-combined_energy%>%filter(between(time, as.Date('2018-07-01'), as.Date('2018-07-31'))) 



#Create additional column for TOTAL energy used per house (Haven't confirmed this works yet)
combined_energy$total<-combined_energy %>%
  group_by(Building_ID) %>%
  summarise(Total_Energy = sum(combined_energy[,1:42]))


#Merge Energy and House Data
HotandColdALL<-merge(combined_energy, HotColdCounties, by.x="Building_ID", by.y="bldg_id")


#Linear Modeling
lmHC<-lm(formula= out.electricity.cooling.energy_consumption ~ in.county 
         #         +  in.ducts + in.cooling_setpoint_has_offset + in.cooling_setpoint_offset_magnitude
         #         + in.cooling_setpoint_offset_period + time + in.infiltration + in.windows
         #         + HotandColdALL$in.building_america_climate_zone
         ,data=HotandColdALL)
summary(lmHC)

HotandColdALL$in.infiltration<-as.factor(HotandColdALL$in.infiltration)
HotandColdALL$in.cooling_setpoint<-as.factor(HotandColdALL$in.cooling_setpoint)





boxplot(out.electricity.cooling.energy_consumption ~ in.county, data=HotandColdALL)


MostEnergyByCounty<- HotandColdALL %>%
  group_by(in.county) %>%
  summarise(Monthly_Cooling_Usage = sum(out.electricity.cooling.energy_consumption))

order(HottestHour$Avg_Hourly_Temp)



#HVAC Types

library(arrow)
library(tidyverse)

#Load Static House Data with Removed Columns
static_house_data <- read_parquet("Downloads/static_house_info.parquet")
static_house_dataEDA<-static_house_data
static_house_dataEDAcleanedcolumns<-static_house_dataEDA[,-c(2,3,4,6,7,8,12,14,15,16, 26, 29, 31,32,
                                                             34,35,36,37,38,39,40,41,42,43,44,45,47,
                                                             49,50,51,52,53,54,55,56,63,72,73,79,84,
                                                             85,86,87,88,89,90,91,103,104,106,107,108
                                                             ,109,120,121,124,126,131,136,137,138,139,
                                                             140,141,142,143,144,146,153,159,161,162,
                                                             163,165,166,167,168,169)]

#Filter homes by the type of HVAC unit they have
CentralAC <-static_house_dataEDAcleanedcolumns %>%
  filter (in.hvac_cooling_type == "Central AC")

NoHVAC <-static_house_dataEDAcleanedcolumns %>%
  filter (in.hvac_cooling_type == "None")

HeatPump <-static_house_dataEDAcleanedcolumns %>%
  filter (in.hvac_cooling_type == "Heat Pump")

RoomAC <-static_house_dataEDAcleanedcolumns %>%
  filter (in.hvac_cooling_type == "Room AC")


#Take a sample of each group
set.seed(123)
sample_indices1 <- sample(nrow(CentralAC), size = 125, replace = FALSE)
sample1 <- CentralAC[sample_indices1, ]

set.seed(123)
sample_indices2 <- sample(nrow(HeatPump), size = 125, replace = FALSE)
sample2 <- HeatPump[sample_indices2, ]

set.seed(123)
sample_indices3 <- sample(nrow(RoomAC), size = 125, replace = FALSE)
sample3 <- RoomAC[sample_indices3, ]


#Combine into one sample 
HVACSample<-rbind(sample1, sample2, sample3, NoHVAC)
boxplot(in.sqft ~ in.hvac_cooling_type, data=HVACSample)

str(HVACSample)


#Create a functio to convert character data types to factors
convert_to_factor <- function(dataframe, columns) {
  for (col in columns) {
    if (is.character(dataframe[[col]])) {
      dataframe[[col]] <- as.factor(dataframe[[col]])
    } else {
      warning(paste0("Column ", col, " is not of character type. Skipping..."))
    }
  }
  return(dataframe)
}

#Columns to convert to factor
HVACSample<- convert_to_factor(HVACSample, c('in.sqft', 'in.bathroom_spot_vent_hour', 'in.bedrooms', 'in.building_america_climate_zone', 'in.ceiling_fan', 'in.city', 'in.clothes_dryer', 'in.clothes_washer', 'in.clothes_washer_presence', 'in.cooking_range', 'in.cooling_setpoint', 'in.cooling_setpoint_has_offset',
                                             'in.cooling_setpoint_offset_magnitude', 'in.cooling_setpoint_offset_period', 'in.county', 'in.county_and_puma', 
                                             'in.dishwasher', 'in.ducts', 'in.federal_poverty_level', 'in.geometry_attic_type', 'in.geometry_floor_area', 
                                             'in.geometry_floor_area_bin', 'in.geometry_foundation_type', 'in.geometry_garage', 'in.geometry_stories',
                                             'in.geometry_stories_low_rise', 'in.geometry_wall_exterior_finish', 'in.geometry_wall_type', 'in.has_pv', 
                                             'in.heating_fuel', 'in.heating_setpoint', 'in.heating_setpoint_has_offset', 'in.heating_setpoint_offset_magnitude', 
                                             'in.heating_setpoint_offset_period', 'in.hot_water_fixtures', 'in.hvac_cooling_efficiency', 'in.hvac_cooling_partial_space_conditioning', 'in.hvac_cooling_type', 'in.hvac_has_ducts', 'in.hvac_has_zonal_electric_heating',
                                             'in.hvac_heating_efficiency', 'in.hvac_heating_type', 'in.hvac_heating_type_and_fuel', 'in.income', 'in.income_recs_2015', 'in.income_recs_2020', 'in.infiltration', 'in.insulation_ceiling', 'in.insulation_floor', 'in.insulation_foundation_wall', 'in.insulation_rim_joist', 'in.insulation_roof', 'in.insulation_slab', 'in.insulation_wall', 'in.lighting', 'in.misc_extra_refrigerator', 'in.misc_freezer', 'in.misc_gas_fireplace', 'in.misc_gas_grill', 'in.misc_gas_lighting', 'in.misc_hot_tub_spa', 'in.misc_pool', 'in.misc_pool_heater', 'in.misc_pool_pump', 'in.misc_well_pump', 'in.occupants', 'in.orientation', 'in.plug_load_diversity', 'in.puma', 'in.puma_metro_status', 'in.pv_orientation',
                                             'in.pv_system_size', 'in.range_spot_vent_hour', 'in.reeds_balancing_area', 'in.refrigerator',
                                             'in.roof_material', 'in.tenure', 'in.usage_level', 'in.vacancy_status', 'in.vintage', 'in.vintage_acs',
                                             'in.water_heater_efficiency', 'in.water_heater_fuel', 'in.weather_file_city', 'in.weather_file_latitude',
                                             'in.weather_file_longitude', 'in.window_areas', 'in.windows', 'upgrade.water_heater_efficiency',
                                             'upgrade.clothes_dryer', 'upgrade.hvac_heating_efficiency', 'upgrade.cooking_range'))



#Read in the energy files for the sample houses
read_in_energyfiles <- function(dataframe, id_column) {
  
  common_url <- "https://intro-datascience.s3.us-east-2.amazonaws.com/SC-data/2023-houseData/"
  parquet_ext <- ".parquet"
  
  energy_data <- list()
  
  for (bldg_id in dataframe[[id_column]]) {
    url <- paste0(common_url, bldg_id, parquet_ext)
    energy_df <- arrow::read_parquet(url)
    energy_df$Building_ID <- bldg_id  # Add a new column for the building ID
    energy_data[[bldg_id]] <- energy_df
  }
  
  return(energy_data)
}

#Can change dataframe here if you want to read in energy files for a different subset of houses
dataframe <- HVACSample  # Your dataframe containing building IDs
id_column <- "bldg_id"   # Name of the column containing building IDs
energy_data <- read_in_energyfiles(dataframe, id_column)

#All combined energy files for selected houses, with column building id to distinguish between them
HVACenergy <- do.call(rbind, energy_data)

#Filter for July
HVACenergy<-HVACenergy%>%filter(between(time, as.Date('2018-07-01'), as.Date('2018-07-31'))) 


#Merge with static house data by building id
HVACHouseEnergy<-merge(HVACenergy, HVACSample, by.x = "Building_ID", by.y="bldg_id")
HVACHouseEnergy$in.cooling_setpoint<-as.character(substr(HVACHouseEnergy$in.cooling_setpoint,1,2))
HVACHouseEnergy$in.cooling_setpoint<-as.numeric(HVACHouseEnergy$in.cooling_setpoint)

#Linear Model
lmoutHVAC<-lm(formula=out.electricity.cooling.energy_consumption ~ in.hvac_cooling_efficiency + in.hvac_cooling_partial_space_conditioning 
              + in.hvac_has_ducts + in.hvac_cooling_type , data=HVACHouseEnergy)
summary(lmoutHVAC)



boxplot(HVACHouseEnergy$out.electricity.lighting_interior.energy_consumption ~ HVACHouseEnergy$in.usage_level, data=HVACHouseEnergy)

#Read in weather files
library(readr)

read_in_weatherfiles <- function(dataframe, id_column) {
  
  common_url <- "https://intro-datascience.s3.us-east-2.amazonaws.com/SC-data/weather/2023-weather-data/"
  csv_ext <- ".csv"
  
  weather_data <- list()
  
  for (county_id in dataframe[[id_column]]) {
    url <- paste0(common_url, county_id, csv_ext)
    weather_df <- read_csv(url)
    weather_df$County_ID <- county_id  # Add a new column for the county ID
    weather_data[[county_id]] <- weather_df
  }
  
  return(weather_data)
}

# Example usage:
dataframe <- HVACSample  # Your dataframe containing county IDs
id_column <- "in.county"   # Name of the column containing county IDs
weather_data <- read_in_weatherfiles(dataframe, id_column)
combined_weather <- bind_rows(weather_data)

#Filter for July
combined_weather<-combined_weather%>%filter(between(date_time, as.Date('2018-07-01'), as.Date('2018-07-31'))) 

#Total Data frame with House, Energy, Weather Data
HVACweatherenergy<-merge(HVACenergy,combined_weather, by.x="time", by.y="date_time")



#SVM Modeling
set.seed(123)  # for reproducibility
training_index <- sample(nrow(HVACHouseEnergy), 0.7 * nrow(HVACHouseEnergy))
training_data <- HVACHouseEnergy[training_index, ]
testing_data <- HVACHouseEnergy[-training_index, ]

# Train the SVM model
svm_model <- svm(out.electricity.cooling.energy_consumption ~ ., data = training_data, kernel = "radial")
svm_model

# Make predictions on testing data
predictions <- predict(svm_model, newdata = testing_data)


#Random Sample of 1000 houses (since the whole data set crashed my computer)

library(arrow)
library(tidyverse)

static_house_data <- read_parquet("Downloads/static_house_info.parquet")
static_house_dataEDA<-static_house_data
static_house_dataEDAcleanedcolumns<-static_house_dataEDA[,-c(2,3,4,6,7,8,12,14,15,16, 26, 29, 31,32,
                                                             34,35,36,37,38,39,40,41,42,43,44,45,47,
                                                             49,50,51,52,53,54,55,56,63,72,73,79,84,
                                                             85,86,87,88,89,90,91,103,104,106,107,108
                                                             ,109,120,121,124,126,131,136,137,138,139,
                                                             140,141,142,143,144,146,153,159,161,162,
                                                             163,165,166,167,168,169)]



set.seed(123)
sample_indices <- sample(nrow(static_house_dataEDAcleanedcolumns), size = 1000, replace = FALSE)
sampleHouses <- static_house_dataEDAcleanedcolumns[sample_indices, ]

#Read-in energy files for random sample
read_in_energyfiles <- function(dataframe, id_column) {
  
  common_url <- "https://intro-datascience.s3.us-east-2.amazonaws.com/SC-data/2023-houseData/"
  parquet_ext <- ".parquet"
  
  energy_data <- list()
  
  for (bldg_id in dataframe[[id_column]]) {
    url <- paste0(common_url, bldg_id, parquet_ext)
    energy_df <- arrow::read_parquet(url)
    energy_df$Building_ID <- bldg_id  # Add a new column for the building ID
    energy_data[[bldg_id]] <- energy_df
  }
  
  return(energy_data)
}

#Can change dataframe here if you want to read in energy files for a different subset of houses
dataframe <- sampleHouses  # Your dataframe containing building IDs
id_column <- "bldg_id"   # Name of the column containing building IDs
energy_data <- read_in_energyfiles(dataframe, id_column)

#All combined energy files for selected houses, with column building id to distinguish between them
combined_df <- do.call(rbind, energy_data)



#Filter for July
combined_df_July<-combined_df%>%filter(between(time, as.Date('2018-07-01'), as.Date('2018-07-31'))) 


#Plot energy usage by energy source: Total, Mean, Median

#Remove non-numeric variables
combined_df_July<-combined_df_July[,1:42]

#Total, Mean, and Median of all variables
totals<-colSums(combined_df_July)
means<-colMeans(combined_df_July)
medians<- apply(combined_df_July , 2, median)



#Plot and compare
barplot(totals, las=2)
barplot(means, las=2)
barplot(medians, las=2)
order(medians)
which.max(totals)
totals[13]

#Create new df with just the top energy-using variables
drivers<- data.frame(Cooling=combined_df_July$out.electricity.cooling.energy_consumption,
                Plug_loads=combined_df_July$out.electricity.plug_loads.energy_consumption,
               Interior_lighting= combined_df_July$out.electricity.lighting_interior.energy_consumption,
                Refrigerator=combined_df_July$out.electricity.refrigerator.energy_consumption,
               BuildingID=combined_df_July$Building_ID,
               date_time=combined_df_July$time)

drivers_sample<-merge(drivers, sampleHouses, by.x="BuildingID", by.y="bldg_id")




lmoutdrivers<-lm(formula= Cooling ~ , data=drivers_sample)
summary(lmoutdrivers)




drivers[which.max(drivers$Cooling),]
drivers[which.min(drivers$Cooling),]


drivers$day <- as.Date(drivers$date_time)
drivers$time <- format(drivers$date_time, format = "%H:%M:%S")


# Group by day and find the row with the maximum value for each day
Coolmax_values_each_day <- drivers %>%
  group_by(day) %>%
  slice(which.max(Cooling))


median(Coolmax_values_each_day$time)
unique(Coolmax_values_each_day$BuildingID)


Lightmax_values_each_day <- drivers %>%
  group_by(day) %>%
  slice(which.max(Interior_lighting))


median(Lightmax_values_each_day$time)
unique(Lightmax_values_each_day$BuildingID)


Refrigmax_values_each_day <- drivers %>%
  group_by(day) %>%
  slice(which.max(Refrigerator))


median(Refrigmax_values_each_day$time)
unique(Refrigmax_values_each_day$BuildingID)


Plugmax_values_each_day <- drivers %>%
  group_by(day) %>%
  slice(which.max(Plug_loads))

median(Plugmax_values_each_day$time)
unique(Plugmax_values_each_day$BuildingID)

drivers[which.max(drivers$Cooling),]
drivers[which.max(drivers$Cooling),]

drivers[which.max(drivers$Cooling),]
drivers[which.max(drivers$Cooling),]



library(ggplot2) 

ggplot() + 
geom_line(data=drivers, aes(x=time, y=Cooling, group=1), color='blue') +
geom_line(data=drivers, aes(x=time, y=Plug_loads, group=1), color='red1') +
geom_line(data=drivers, aes(x=time, y=Interior_lighting, group=1), color='chartreuse') +
geom_line(data=drivers, aes(x=time, y=Refrigerator, group=1), color='pink') 

#What time of day are the max values happening?
ggplot() + 
  geom_point(data=Coolmax_values_each_day, aes(x=time, y=Cooling), color='blue') +
  geom_point(data=Lightmax_values_each_day, aes(x=time, y=Interior_lighting), color='red') +
  geom_point(data=Refrigmax_values_each_day, aes(x=time, y=Refrigerator), color='green') +
  geom_point(data=Plugmax_values_each_day, aes(x=time, y=Plug_loads), color='pink') 


  


#Merge with static house data by building id
HouseEnergy<-merge(combined_df_July, sample1, by.x = "Building_ID", by.y="bldg_id")
str(HouseEnergy)

#Make character variables into factors
convert_to_factor <- function(dataframe, columns) {
  for (col in columns) {
    if (is.character(dataframe[[col]])) {
      dataframe[[col]] <- as.factor(dataframe[[col]])
    } else {
      warning(paste0("Column ", col, " is not of character type. Skipping..."))
    }
  }
  return(dataframe)
}


HouseEnergy<- convert_to_factor(HouseEnergy, c('Building_ID', 'out.electricity.ceiling_fan.energy_consumption', 'out.electricity.clothes_dryer.energy_consumption',
'out.electricity.clothes_washer.energy_consumption', 'out.electricity.cooling_fans_pumps.energy_consumption',
'out.electricity.cooling.energy_consumption', 'out.electricity.dishwasher.energy_consumption', 
'out.electricity.freezer.energy_consumption', 'out.electricity.heating_fans_pumps.energy_consumption', 'out.electricity.heating_hp_bkup.energy_consumption', 'out.electricity.heating.energy_consumption',
'out.electricity.hot_tub_heater.energy_consumption', 'out.electricity.hot_tub_pump.energy_consumption', 'out.electricity.hot_water.energy_consumption', 'out.electricity.lighting_exterior.energy_consumption', 'out.electricity.lighting_garage.energy_consumption', 
'out.electricity.lighting_interior.energy_consumption', 'out.electricity.mech_vent.energy_consumption',
'out.electricity.plug_loads.energy_consumption', 'out.electricity.pool_heater.energy_consumption',
'out.electricity.pool_pump.energy_consumption', 'out.electricity.pv.energy_consumption', 
'out.electricity.range_oven.energy_consumption', 'out.electricity.refrigerator.energy_consumption', 
'out.electricity.well_pump.energy_consumption', 'out.fuel_oil.heating_hp_bkup.energy_consumption', 
'out.fuel_oil.heating.energy_consumption', 'out.fuel_oil.hot_water.energy_consumption', 
'out.natural_gas.clothes_dryer.energy_consumption', 'out.natural_gas.fireplace.energy_consumption', 
'out.natural_gas.grill.energy_consumption', 'out.natural_gas.heating_hp_bkup.energy_consumption', 'out.natural_gas.heating.energy_consumption', 'out.natural_gas.hot_tub_heater.energy_consumption', 
'out.natural_gas.hot_water.energy_consumption', 'out.natural_gas.lighting.energy_consumption', 
'out.natural_gas.pool_heater.energy_consumption', 'out.natural_gas.range_oven.energy_consumption', 
'out.propane.clothes_dryer.energy_consumption', 'out.propane.heating_hp_bkup.energy_consumption', 
'out.propane.heating.energy_consumption', 'out.propane.hot_water.energy_consumption', 
'out.propane.range_oven.energy_consumption', 'time', 'month', 'in.sqft', 'in.bathroom_spot_vent_hour', 'in.bedrooms', 'in.building_america_climate_zone', 'in.ceiling_fan', 'in.city', 'in.clothes_dryer', 'in.clothes_washer', 'in.clothes_washer_presence', 'in.cooking_range', 'in.cooling_setpoint', 'in.cooling_setpoint_has_offset',
'in.cooling_setpoint_offset_magnitude', 'in.cooling_setpoint_offset_period', 'in.county', 'in.county_and_puma', 
'in.dishwasher', 'in.ducts', 'in.federal_poverty_level', 'in.geometry_attic_type', 'in.geometry_floor_area', 
'in.geometry_floor_area_bin', 'in.geometry_foundation_type', 'in.geometry_garage', 'in.geometry_stories',
'in.geometry_stories_low_rise', 'in.geometry_wall_exterior_finish', 'in.geometry_wall_type', 'in.has_pv', 
'in.heating_fuel', 'in.heating_setpoint', 'in.heating_setpoint_has_offset', 'in.heating_setpoint_offset_magnitude', 
'in.heating_setpoint_offset_period', 'in.hot_water_fixtures', 'in.hvac_cooling_efficiency', 'in.hvac_cooling_partial_space_conditioning', 'in.hvac_cooling_type', 'in.hvac_has_ducts', 'in.hvac_has_zonal_electric_heating',
'in.hvac_heating_efficiency', 'in.hvac_heating_type', 'in.hvac_heating_type_and_fuel', 'in.income', 'in.income_recs_2015', 'in.income_recs_2020', 'in.infiltration', 'in.insulation_ceiling', 'in.insulation_floor', 'in.insulation_foundation_wall', 'in.insulation_rim_joist', 'in.insulation_roof', 'in.insulation_slab', 'in.insulation_wall', 'in.lighting', 'in.misc_extra_refrigerator', 'in.misc_freezer', 'in.misc_gas_fireplace', 'in.misc_gas_grill', 'in.misc_gas_lighting', 'in.misc_hot_tub_spa', 'in.misc_pool', 'in.misc_pool_heater', 'in.misc_pool_pump', 'in.misc_well_pump', 'in.occupants', 'in.orientation', 'in.plug_load_diversity', 'in.puma', 'in.puma_metro_status', 'in.pv_orientation',
'in.pv_system_size', 'in.range_spot_vent_hour', 'in.reeds_balancing_area', 'in.refrigerator',
'in.roof_material', 'in.tenure', 'in.usage_level', 'in.vacancy_status', 'in.vintage', 'in.vintage_acs',
'in.water_heater_efficiency', 'in.water_heater_fuel', 'in.weather_file_city', 'in.weather_file_latitude',
'in.weather_file_longitude', 'in.window_areas', 'in.windows', 'upgrade.water_heater_efficiency',
'upgrade.clothes_dryer', 'upgrade.hvac_heating_efficiency', 'upgrade.cooking_range'))

HouseEnergy<-HouseEnergy[,-45]

str(HouseEnergy)
lmOutsample<-lm(formula=out.electricity.refrigerator.energy_consumption ~ ., data=HouseEnergy)
summary(lmOutsample)

lmoutsample<-lm(formula=out.electricity.cooling.energy_consumption ~ time + in.sqft + in.bedrooms + 
            in.cooling_setpoint  + in.hvac_cooling_efficiency + in.hvac_cooling_partial_space_conditioning 
          + in.hvac_has_ducts + in.windows + in.ducts + in.insulation_wall + in.county + in.usage_level, data=HouseEnergy)
summary(lmoutsample)

#Read in weather files
library(readr)

read_in_weatherfiles <- function(dataframe, id_column) {
  
  common_url <- "https://intro-datascience.s3.us-east-2.amazonaws.com/SC-data/weather/2023-weather-data/"
  csv_ext <- ".csv"
  
  weather_data <- list()
  
  for (county_id in dataframe[[id_column]]) {
    url <- paste0(common_url, county_id, csv_ext)
    weather_df <- read_csv(url)
    weather_df$County_ID <- county_id  # Add a new column for the county ID
    weather_data[[county_id]] <- weather_df
  }
  
  return(weather_data)
}

# Example usage:
dataframe <- sample1  # Your dataframe containing county IDs
id_column <- "in.county"   # Name of the column containing county IDs
weather_data <- read_in_weatherfiles(dataframe, id_column)
combined_weather <- bind_rows(weather_data)

#Filter for July
combined_weather_July<-combined_weather%>%filter(between(date_time, as.Date('2018-07-01'), as.Date('2018-07-31'))) 

Energy_Weather<-merge(combined_df_July,combined_weather_July, by.x = "time", by.y = "date_time")
Energy_Weather_House<-merge(Energy_Weather, sample1, by.x= "Building_ID", by.y="bldg_id")
Energy_Wether_House$energy_total<-colSums(Energy_Weather_House

lmOuthelpme<-lm(formula=out.electricity.cooling.energy_consumption ~ . ,data=Energy_Weather_House)
summary(lmOuthelpme)

Energy_Weather<-merge(combined_df_July, combined_weather_July, by.x = "time", by.y = "date_time")
Energy_Weather_House<-merge(Energy_Weather, sample1, by.x= "Building_ID", by.y="bldg_id")
Energy_Weather_House$energy_total<-colSums(Energy_Weather_House)


str(Energy_Weather_House$)

hist(Energy_Weather_House)
boxplot(out.electricity.cooling.energy_consumption ~ in.sqft , data=Energy_Weather_House)
boxplot(out.electricity.cooling.energy_consumption ~ in.county, data=Energy_Weather_House)
boxplot(out.electricity.cooling.energy_consumption ~ in.building_america_climate_zone, data=Energy_Weather_House)
boxplot(out.electricity.cooling.energy_consumption ~ ., data=Energy_Weather_House)
boxplot(out.electricity.cooling.energy_consumption ~ in.infiltration, data=HVACHouseEnergy)


countyenergyHigh <-static_house_dataEDAcleanedcolumns %>%
  filter (in.county == "G4500290")

quantile(countyenergyHigh$)

countyenergyLow <-static_house_dataEDAcleanedcolumns %>%
  filter (in.county == "G4500210")

mean(countyenergyLow$in.sqft)

#Random Sample of 1000 houses (since the whole data set crashed my computer)

library(arrow)
library(tidyverse)

static_house_data <- read_parquet("Downloads/static_house_info.parquet")
static_house_dataEDA<-static_house_data
static_house_dataEDAcleanedcolumns<-static_house_dataEDA[,-c(2,3,4,6,7,8,12,14,15,16, 26, 29, 31,32,
                                                             34,35,36,37,38,39,40,41,42,43,44,45,47,
                                                             49,50,51,52,53,54,55,56,63,72,73,79,84,
                                                             85,86,87,88,89,90,91,103,104,106,107,108
                                                             ,109,120,121,124,126,131,136,137,138,139,
                                                             140,141,142,143,144,146,153,159,161,162,
                                                             163,165,166,167,168,169)]



set.seed(123)
sample_indices <- sample(nrow(static_house_dataEDAcleanedcolumns), size = 1000, replace = FALSE)
sampleHouses <- static_house_dataEDAcleanedcolumns[sample_indices, ]

#Read-in energy files for random sample
read_in_energyfiles <- function(dataframe, id_column) {
  
  common_url <- "https://intro-datascience.s3.us-east-2.amazonaws.com/SC-data/2023-houseData/"
  parquet_ext <- ".parquet"
  
  energy_data <- list()
  
  for (bldg_id in dataframe[[id_column]]) {
    url <- paste0(common_url, bldg_id, parquet_ext)
    energy_df <- arrow::read_parquet(url)
    energy_df$Building_ID <- bldg_id  # Add a new column for the building ID
    energy_data[[bldg_id]] <- energy_df
  }
  
  return(energy_data)
}

#Can change dataframe here if you want to read in energy files for a different subset of houses
dataframe <- sampleHouses  # Your dataframe containing building IDs
id_column <- "bldg_id"   # Name of the column containing building IDs
energy_data <- read_in_energyfiles(dataframe, id_column)

#All combined energy files for selected houses, with column building id to distinguish between them
combined_df <- do.call(rbind, energy_data)



#Filter for July
combined_df_July<-combined_df%>%filter(between(time, as.Date('2018-07-01'), as.Date('2018-07-31'))) 


#Plot energy usage by energy source: Total, Mean, Median

#Remove non-numeric variables
combined_df_July<-combined_df_July[,1:42]

#Total, Mean, and Median of all variables
totals<-colSums(combined_df_July)
means<-colMeans(combined_df_July)
medians<- apply(combined_df_July , 2, median)



#Plot and compare
barplot(totals, las=2)
barplot(means, las=2)
barplot(medians, las=2)
order(medians)
which.max(totals)
totals[13]

#Create new df with just the top energy-using variables
drivers<- data.frame(Cooling=combined_df_July$out.electricity.cooling.energy_consumption,
                     Plug_loads=combined_df_July$out.electricity.plug_loads.energy_consumption,
                     Interior_lighting= combined_df_July$out.electricity.lighting_interior.energy_consumption,
                     Refrigerator=combined_df_July$out.electricity.refrigerator.energy_consumption,
                     BuildingID=combined_df_July$Building_ID,
                     date_time=combined_df_July$time)

drivers_sample<-merge(drivers, sampleHouses, by.x="BuildingID", by.y="bldg_id")




lmoutdrivers<-lm(formula= Cooling ~ , data=drivers_sample)
summary(lmoutdrivers)




drivers[which.max(drivers$Cooling),]
drivers[which.min(drivers$Cooling),]


drivers$day <- as.Date(drivers$date_time)
drivers$time <- format(drivers$date_time, format = "%H:%M:%S")


# Group by day and find the row with the maximum value for each day
Coolmax_values_each_day <- drivers %>%
  group_by(day) %>%
  slice(which.max(Cooling))


median(Coolmax_values_each_day$time)
unique(Coolmax_values_each_day$BuildingID)


Lightmax_values_each_day <- drivers %>%
  group_by(day) %>%
  slice(which.max(Interior_lighting))


median(Lightmax_values_each_day$time)
unique(Lightmax_values_each_day$BuildingID)


Refrigmax_values_each_day <- drivers %>%
  group_by(day) %>%
  slice(which.max(Refrigerator))


median(Refrigmax_values_each_day$time)
unique(Refrigmax_values_each_day$BuildingID)


Plugmax_values_each_day <- drivers %>%
  group_by(day) %>%
  slice(which.max(Plug_loads))

median(Plugmax_values_each_day$time)
unique(Plugmax_values_each_day$BuildingID)

drivers[which.max(drivers$Cooling),]
drivers[which.max(drivers$Cooling),]

drivers[which.max(drivers$Cooling),]
drivers[which.max(drivers$Cooling),]



library(ggplot2) 

ggplot() + 
  geom_line(data=drivers, aes(x=time, y=Cooling, group=1), color='blue') +
  geom_line(data=drivers, aes(x=time, y=Plug_loads, group=1), color='red1') +
  geom_line(data=drivers, aes(x=time, y=Interior_lighting, group=1), color='chartreuse') +
  geom_line(data=drivers, aes(x=time, y=Refrigerator, group=1), color='pink') 

#What time of day are the max values happening?
ggplot() + 
  geom_point(data=Coolmax_values_each_day, aes(x=time, y=Cooling), color='blue') +
  geom_point(data=Lightmax_values_each_day, aes(x=time, y=Interior_lighting), color='red') +
  geom_point(data=Refrigmax_values_each_day, aes(x=time, y=Refrigerator), color='green') +
  geom_point(data=Plugmax_values_each_day, aes(x=time, y=Plug_loads), color='pink') 





#Merge with static house data by building id
HouseEnergy<-merge(combined_df_July, sample1, by.x = "Building_ID", by.y="bldg_id")
str(HouseEnergy)

#Make character variables into factors
convert_to_factor <- function(dataframe, columns) {
  for (col in columns) {
    if (is.character(dataframe[[col]])) {
      dataframe[[col]] <- as.factor(dataframe[[col]])
    } else {
      warning(paste0("Column ", col, " is not of character type. Skipping..."))
    }
  }
  return(dataframe)
}


HouseEnergy<- convert_to_factor(HouseEnergy, c('Building_ID', 'out.electricity.ceiling_fan.energy_consumption', 'out.electricity.clothes_dryer.energy_consumption',
                                               'out.electricity.clothes_washer.energy_consumption', 'out.electricity.cooling_fans_pumps.energy_consumption',
                                               'out.electricity.cooling.energy_consumption', 'out.electricity.dishwasher.energy_consumption', 
                                               'out.electricity.freezer.energy_consumption', 'out.electricity.heating_fans_pumps.energy_consumption', 'out.electricity.heating_hp_bkup.energy_consumption', 'out.electricity.heating.energy_consumption',
                                               'out.electricity.hot_tub_heater.energy_consumption', 'out.electricity.hot_tub_pump.energy_consumption', 'out.electricity.hot_water.energy_consumption', 'out.electricity.lighting_exterior.energy_consumption', 'out.electricity.lighting_garage.energy_consumption', 
                                               'out.electricity.lighting_interior.energy_consumption', 'out.electricity.mech_vent.energy_consumption',
                                               'out.electricity.plug_loads.energy_consumption', 'out.electricity.pool_heater.energy_consumption',
                                               'out.electricity.pool_pump.energy_consumption', 'out.electricity.pv.energy_consumption', 
                                               'out.electricity.range_oven.energy_consumption', 'out.electricity.refrigerator.energy_consumption', 
                                               'out.electricity.well_pump.energy_consumption', 'out.fuel_oil.heating_hp_bkup.energy_consumption', 
                                               'out.fuel_oil.heating.energy_consumption', 'out.fuel_oil.hot_water.energy_consumption', 
                                               'out.natural_gas.clothes_dryer.energy_consumption', 'out.natural_gas.fireplace.energy_consumption', 
                                               'out.natural_gas.grill.energy_consumption', 'out.natural_gas.heating_hp_bkup.energy_consumption', 'out.natural_gas.heating.energy_consumption', 'out.natural_gas.hot_tub_heater.energy_consumption', 
                                               'out.natural_gas.hot_water.energy_consumption', 'out.natural_gas.lighting.energy_consumption', 
                                               'out.natural_gas.pool_heater.energy_consumption', 'out.natural_gas.range_oven.energy_consumption', 
                                               'out.propane.clothes_dryer.energy_consumption', 'out.propane.heating_hp_bkup.energy_consumption', 
                                               'out.propane.heating.energy_consumption', 'out.propane.hot_water.energy_consumption', 
                                               'out.propane.range_oven.energy_consumption', 'time', 'month', 'in.sqft', 'in.bathroom_spot_vent_hour', 'in.bedrooms', 'in.building_america_climate_zone', 'in.ceiling_fan', 'in.city', 'in.clothes_dryer', 'in.clothes_washer', 'in.clothes_washer_presence', 'in.cooking_range', 'in.cooling_setpoint', 'in.cooling_setpoint_has_offset',
                                               'in.cooling_setpoint_offset_magnitude', 'in.cooling_setpoint_offset_period', 'in.county', 'in.county_and_puma', 
                                               'in.dishwasher', 'in.ducts', 'in.federal_poverty_level', 'in.geometry_attic_type', 'in.geometry_floor_area', 
                                               'in.geometry_floor_area_bin', 'in.geometry_foundation_type', 'in.geometry_garage', 'in.geometry_stories',
                                               'in.geometry_stories_low_rise', 'in.geometry_wall_exterior_finish', 'in.geometry_wall_type', 'in.has_pv', 
                                               'in.heating_fuel', 'in.heating_setpoint', 'in.heating_setpoint_has_offset', 'in.heating_setpoint_offset_magnitude', 
                                               'in.heating_setpoint_offset_period', 'in.hot_water_fixtures', 'in.hvac_cooling_efficiency', 'in.hvac_cooling_partial_space_conditioning', 'in.hvac_cooling_type', 'in.hvac_has_ducts', 'in.hvac_has_zonal_electric_heating',
                                               'in.hvac_heating_efficiency', 'in.hvac_heating_type', 'in.hvac_heating_type_and_fuel', 'in.income', 'in.income_recs_2015', 'in.income_recs_2020', 'in.infiltration', 'in.insulation_ceiling', 'in.insulation_floor', 'in.insulation_foundation_wall', 'in.insulation_rim_joist', 'in.insulation_roof', 'in.insulation_slab', 'in.insulation_wall', 'in.lighting', 'in.misc_extra_refrigerator', 'in.misc_freezer', 'in.misc_gas_fireplace', 'in.misc_gas_grill', 'in.misc_gas_lighting', 'in.misc_hot_tub_spa', 'in.misc_pool', 'in.misc_pool_heater', 'in.misc_pool_pump', 'in.misc_well_pump', 'in.occupants', 'in.orientation', 'in.plug_load_diversity', 'in.puma', 'in.puma_metro_status', 'in.pv_orientation',
                                               'in.pv_system_size', 'in.range_spot_vent_hour', 'in.reeds_balancing_area', 'in.refrigerator',
                                               'in.roof_material', 'in.tenure', 'in.usage_level', 'in.vacancy_status', 'in.vintage', 'in.vintage_acs',
                                               'in.water_heater_efficiency', 'in.water_heater_fuel', 'in.weather_file_city', 'in.weather_file_latitude',
                                               'in.weather_file_longitude', 'in.window_areas', 'in.windows', 'upgrade.water_heater_efficiency',
                                               'upgrade.clothes_dryer', 'upgrade.hvac_heating_efficiency', 'upgrade.cooking_range'))

HouseEnergy<-HouseEnergy[,-45]

str(HouseEnergy)
lmOutsample<-lm(formula=out.electricity.refrigerator.energy_consumption ~ ., data=HouseEnergy)
summary(lmOutsample)

lmoutsample<-lm(formula=out.electricity.cooling.energy_consumption ~ time + in.sqft + in.bedrooms + 
                  in.cooling_setpoint  + in.hvac_cooling_efficiency + in.hvac_cooling_partial_space_conditioning 
                + in.hvac_has_ducts + in.windows + in.ducts + in.insulation_wall + in.county + in.usage_level, data=HouseEnergy)
summary(lmoutsample)

#Read in weather files
library(readr)

read_in_weatherfiles <- function(dataframe, id_column) {
  
  common_url <- "https://intro-datascience.s3.us-east-2.amazonaws.com/SC-data/weather/2023-weather-data/"
  csv_ext <- ".csv"
  
  weather_data <- list()
  
  for (county_id in dataframe[[id_column]]) {
    url <- paste0(common_url, county_id, csv_ext)
    weather_df <- read_csv(url)
    weather_df$County_ID <- county_id  # Add a new column for the county ID
    weather_data[[county_id]] <- weather_df
  }
  
  return(weather_data)
}

# Example usage:
dataframe <- sample1  # Your dataframe containing county IDs
id_column <- "in.county"   # Name of the column containing county IDs
weather_data <- read_in_weatherfiles(dataframe, id_column)
combined_weather <- bind_rows(weather_data)

#Filter for July
combined_weather_July<-combined_weather%>%filter(between(date_time, as.Date('2018-07-01'), as.Date('2018-07-31'))) 

Energy_Weather<-merge(combined_df_July,combined_weather_July, by.x = "time", by.y = "date_time")
Energy_Weather_House<-merge(Energy_Weather, sample1, by.x= "Building_ID", by.y="bldg_id")
Energy_Wether_House$energy_total<-colSums(Energy_Weather_House
                                          
lmOuthelpme<-lm(formula=out.electricity.cooling.energy_consumption ~ . ,data=Energy_Weather_House)
summary(lmOuthelpme)
                                          
Energy_Weather<-merge(combined_df_July, combined_weather_July, by.x = "time", by.y = "date_time")
Energy_Weather_House<-merge(Energy_Weather, sample1, by.x= "Building_ID", by.y="bldg_id")
Energy_Weather_House$energy_total<-colSums(Energy_Weather_House)
                                          
                                          
str(Energy_Weather_House$)
                                          
hist(Energy_Weather_House)
boxplot(out.electricity.cooling.energy_consumption ~ in.sqft , data=Energy_Weather_House)
boxplot(out.electricity.cooling.energy_consumption ~ in.county, data=Energy_Weather_House)
boxplot(out.electricity.cooling.energy_consumption ~ in.building_america_climate_zone, data=Energy_Weather_House)
boxplot(out.electricity.cooling.energy_consumption ~ ., data=Energy_Weather_House)
boxplot(out.electricity.cooling.energy_consumption ~ in.infiltration, data=HVACHouseEnergy)
                                          
                                          
countyenergyHigh <-static_house_dataEDAcleanedcolumns %>%
filter (in.county == "G4500290")
                                          
quantile(countyenergyHigh$)
                                          
countyenergyLow <-static_house_dataEDAcleanedcolumns %>%
filter (in.county == "G4500210")
                                          
mean(countyenergyLow$in.sqft)


#Do above-average sized homes use more interior lighting energy or higher plug-loads?

#Avg sqft: 2113.904
mean(static_house_dataEDAcleanedcolumns$in.sqft)

#Median sqft: 1690
median(static_house_dataEDAcleanedcolumns$in.sqft)

#Outlier around 8000 sqft
hist(static_house_dataEDAcleanedcolumns$in.sqft)
boxplot(static_house_dataEDAcleanedcolumns$in.sqft, data=static_house_dataEDAcleanedcolumns)


library(tidyverse)
#Take subset of largest and smallest homes to compare energy usage

#8194 sqft
largehomes<- static_house_dataEDAcleanedcolumns %>% 
  arrange(desc(in.sqft)) %>% slice(1:100)
summary(largehomes$in.sqft)

unique(largehomes$in.county)
unique(smallhomes$in.county)

#328-885 sqft
smallhomes<- static_house_dataEDAcleanedcolumns %>% 
  arrange(in.sqft) %>% slice(1:100)
summary(smallhomes$in.sqft)


#Read in energy files
read_in_energyfiles <- function(dataframe, id_column) {
  
  
  common_url <- "https://intro-datascience.s3.us-east-2.amazonaws.com/SC-data/2023-houseData/"
  parquet_ext <- ".parquet"
  
  energy_data <- list()
  
  for (bldg_id in dataframe[[id_column]]) {
    url <- paste0(common_url, bldg_id, parquet_ext)
    energy_data[[bldg_id]] <- arrow::read_parquet(url)
  }
  
  return(energy_data)
}

#Small Homes Energy Files
dataframe1 <- smallhomes  # Your dataframe containing building IDs
id_column <- "bldg_id"   # Name of the column containing building IDs
energy_data1 <- read_in_energyfiles(dataframe1, id_column)


combined_df_small_energy <- do.call(rbind, energy_data1)

#Large Homes Energy Files
dataframe <- largehomes  # Your dataframe containing building IDs
id_column <- "bldg_id"   # Name of the column containing building IDs
energy_data <- read_in_energyfiles(dataframe, id_column)


combined_df_large_energy <- do.call(rbind, energy_data)



#Filter to get July data only
library(tidyverse)

combined_df_July_smallhomes<-combined_df_small_energy%>%filter(between(time, as.Date('2018-07-01'), as.Date('2018-07-31'))) 
combined_df_July_largeshomes<-combined_df_large_energy%>%filter(between(time, as.Date('2018-07-01'), as.Date('2018-07-31'))) 



#Assign class column to difference between small and large homes when merging
combined_df_July_smallhomes$class<-"small"

#Get column totals
sums<-colSums(combined_df_July_smallhomes[,1:42])  
str(combined_df)
order(sums)
sums[23]


#Assign class column to difference between small and large homes when merging
combined_df_July_largeshomes$class<-"large"

#Get column totals
sums<-colSums(combined_df_July_largeshomes[,1:42])  
str(combined_df)
order(sums)
sums[23]


#Combine energy files for small and large houses
ALL<-rbind(combined_df_July_smallhomes,combined_df_July_largeshomes)
str(ALL$class)
ALL$class<-as.factor(ALL$class)

samplehomes<-rbind(smallhomes,largehomes)

ALL<-merge(ALL,samplehomes, by.x="Building_ID", by.y="bldg_id")

ALL$in.usage_level<-as.factor(ALL$in.usage_level)
ALL$in.occupants<-as.factor(ALL$in.occupants)

#Linear Regression Model
lmOutALL<-lm(formula=out.electricity.plug_loads.energy_consumption ~ class  data=ALL)
summary(lmOutALL)

lmOutALL2<-lm(formula=out.electricity.plug_loads.energy_consumption ~ class + in.usage_level + in.occupants + time + in.infiltration, data=ALL)
summary(lmOutALL2)

lmOutALLlights2<-lm(formula=ALL$out.electricity.lighting_interior.energy_consumption ~ class + time + in.occupants + in.usage_level, data=ALL)
summary(lmOutALLlights2)

lmOutALLlights<-lm(formula=ALL$out.electricity.lighting_interior.energy_consumption ~ class + in.occupants, data=ALL)
summary(lmOutALLlights)

lmOutALLac<-lm(formula=ALL$out.electricity.cooling.energy_consumption ~ class + in.occupants + in.usage_level + time, data=ALL)
summary(lmOutALLac)

lmOutALLR<-lm(formula=ALL$out.electricity.refrigerator.energy_consumption ~ class + time, data=ALL)
summary(lmOutALLR)


lmoutsample<-lm(formula=out.electricity.cooling.energy_consumption ~ time + in.sqft + in.bedrooms + 
                  in.cooling_setpoint  + in.hvac_cooling_efficiency + in.hvac_cooling_partial_space_conditioning 
                + in.hvac_has_ducts + in.windows + in.ducts + in.insulation_wall + in.county + in.usage_level, data=HouseEnergy)
summary(lmoutsample)


#Filter data to merge with weather in preparation for prediction.

ALLPredictors<- subset(ALL, select = c(Building_ID, out.electricity.cooling.energy_consumption,
                                       out.electricity.lighting_interior.energy_consumption, out.electricity.plug_loads.energy_consumption,
                                       time, class, in.sqft, in.county, in.occupants, in.usage_level))

ALL_weather_July_Temps<-subset(ALL_weather_July, select = c(date_time, `Dry Bulb Temperature [°C]`, County_ID))

ALLPredictorsWeather<-merge(ALLPredictors, ALL_weather_July, by.x="in.county", by.y ="County_ID")

lmpredict<-lm(formula=ALLPredictors$out.electricity.lighting_interior.energy_consumption ~ ., data=ALLPredictors)
summary(lmpredict)


#SVM Model
library(caret)
library(kernlab)
trainList <- createDataPartition(y=ALL$class,p=.67,list=FALSE)
trainSet<-ALL[trainList,]
testSet<-ALL[-trainList,]

SQFTsvmModel<-ksvm(class ~ ., data=ALL,C = 5, cross =3, prob.model = TRUE)
SQFTsvmModel


#Boxplots of different energy variables by class to see relationship
boxplot(out.electricity.cooling.energy_consumption ~ class, data=ALL)
boxplot(out.electricity.lighting_interior.energy_consumption ~ class, data=ALL)
boxplot(out.electricity.refrigerator.energy_consumption ~ class, data=ALL)
boxplot(out.electricity.plug_loads.energy_consumption ~ class, data=ALL)


#Prediction

read_in_weatherfiles <- function(dataframe, id_column) {
  
  common_url <- "https://intro-datascience.s3.us-east-2.amazonaws.com/SC-data/weather/2023-weather-data/"
  csv_ext <- ".csv"
  
  weather_data <- list()
  
  for (county_id in dataframe[[id_column]]) {
    url <- paste0(common_url, county_id, csv_ext)
    weather_df <- read_csv(url)
    weather_df$County_ID <- county_id  # Add a new column for the county ID
    weather_data[[county_id]] <- weather_df
  }
  
  return(weather_data)
}

# Example usage:
dataframe <- HVACSample  # Your dataframe containing county IDs
id_column <- "in.county"   # Name of the column containing county IDs
weather_data <- read_in_weatherfiles(dataframe, id_column)
combined_weather <- bind_rows(weather_data)

combined_weather<-combined_weather%>%filter(between(date_time, as.Date('2018-07-01'), as.Date('2018-07-31'))) 

combined_weatherplus5<-combined_weather
combined_weatherplus5$`Dry Bulb Temperature [°C]`<-combined_weatherplus5$`Dry Bulb Temperature [°C]`+5

#Group by time and find the when temp peaks/dips
library(tidyverse)

ALL_weather_July$time <- format(ALL_weather_July$date_time, format = "%H:%M:%S")
HottestHour<- ALL_weather_July %>%
  group_by(time) %>%
  summarise(Avg_Hourly_Temp = mean(`Dry Bulb Temperature [°C]`))

order(HottestHour$Avg_Hourly_Temp)
str(HottestHour$time)



ALLPredictors<- subset(ALL, select = c(Building_ID, out.electricity.cooling.energy_consumption,
                                       out.electricity.lighting_interior.energy_consumption, out.electricity.plug_loads.energy_consumption,
                                       time, class, in.sqft, in.county, in.occupants, in.usage_level, in.infiltration))


ALLPredictors$timeofday<- format(ALLPredictors$time, format = "%H:%M:%S")
ALLPredictorsWeather<-merge(ALLPredictors, HottestHour, by.x="timeofday", by.y ="time")

lmpredict<-lm(formula=ALLPredictorsWeather$out.electricity.lighting_interior.energy_consumption ~ ., data=ALLPredictorsWeather)
summary(lmpredict)

lmpredict2<-lm(formula= out.electricity.cooling.energy_consumption ~ in.sqft + in.occupants + in.usage_level  + in.county + Avg_Hourly_Temp +in.infiltration, data=ALLPredictorsWeather)
summary(lmpredict2)


predDF <- data.frame(in.county = "G4500690", in.sqft= 1220, in.occupants= "2", in.usage_level= "High", timeofday="12:00:00", Avg_Hourly_Temp = HottestHour$Avg_Hourly_Temp[HottestHour$time == "12:00:00"] )
predict(lmpredict2, predDF)


predDF2 <- data.frame(in.county = "G4500690", in.sqft= 8000, in.occupants= "9", in.usage_level= "High", Avg_Hourly_Temp = 35)
predict(lmpredict2, predDF2)


predDF3 <- data.frame(in.county = "G4500690", in.sqft= 8000, in.occupants= "9", in.usage_level= "High", Avg_Hourly_Temp = 20)
predict(lmpredict2, predDF3)

unique(ALLPredictorsWeather$in.occupants)

str(ALLPredictorsWeather)




#Inputs:
#Sqft: (Any num)
#Num of occupants: (1-10)
#Usage Level: (Low, Medium, High)
#County
#Temperature 

#Outputs:
#Hourly Energy Usage (for each 4 sources) for July


#Cooling:
lmCooling<-lm(formula= out.electricity.cooling.energy_consumption ~ in.sqft + in.occupants + in.usage_level + in.county + Avg_Hourly_Temp , data=ALLPredictorsWeather)
summary(lmCooling)

predCoolingDF <- data.frame(in.county = "G4500690", in.sqft= 1220, in.occupants= "2", in.usage_level= "High",  Avg_Hourly_Temp= HottestHour$Plus5[HottestHour$time == "14:00:00"])
predict(lmCooling, predCoolingDF)




#Lighting:
lmLighting<-lm(formula= out.electricity.lighting_interior.energy_consumption ~ in.sqft + in.occupants + in.usage_level + Avg_Hourly_Temp + in.county, data=ALLPredictorsWeather)
summary(lmLighting) 

predLightingDF <- data.frame(in.county = "G4500690", in.sqft= 1220, in.occupants= "2", in.usage_level= "High", timeofday="12:00:00", Avg_Hourly_Temp = 35)
predict(lmLighting, predLightingDF)

#Plug Loads:
lmPlugLoads<-lm(formula=out.electricity.plug_loads.energy_consumption ~ in.sqft + in.occupants + in.usage_level + Avg_Hourly_Temp + in.county, data=ALLPredictorsWeather)
summary(lmPlugLoads)

predPlugLoadsDF <- data.frame(in.county = "G4500690", in.sqft= 1220, in.occupants= "2", in.usage_level= "High", timeofday="12:00:00", Avg_Hourly_Temp = 35)
predict(lmPlugLoads, predPlugLoadsDF)

#Code for Shiny:

#Read in static house data
library(arrow)
static_house_data <- read_parquet("Downloads/static_house_info.parquet")
static_house_dataEDA<-static_house_data
assign("static_house_dataEDA", static_house_dataEDA)

StaticPredictors<- subset(static_house_dataEDA, select = c(bldg_id, in.sqft, in.county, in.occupants, in.usage_level, in.infiltration))
StaticPredictors$in.county<-as.factor(StaticPredictors$in.county)
StaticPredictors$in.occupants<-as.factor(StaticPredictors$in.occupants)
StaticPredictors$in.usage_level<-as.factor(StaticPredictors$in.usage_level)
StaticPredictors$in.infiltration<-as.factor(StaticPredictors$in.infiltration)


#Take random sample of buildings (whole data set is too much)
set.seed(123)
sample_indices <- sample(nrow(StaticPredictors), size = 1000, replace = FALSE)
Sample <- StaticPredictors[sample_indices, ]
assign("Sample",Sample)

#Load in all weather files, combine, filter for July, and group by avg hourly temp

library(readr)
read_in_weatherfiles <- function(dataframe, id_column) {
  
  common_url <- "https://intro-datascience.s3.us-east-2.amazonaws.com/SC-data/weather/2023-weather-data/"
  csv_ext <- ".csv"
  
  weather_data <- list()
  
  for (county_id in dataframe[[id_column]]) {
    url <- paste0(common_url, county_id, csv_ext)
    weather_df <- read_csv(url)
    weather_df$in.county <- county_id  # Add a new column for the county ID
    weather_data[[county_id]] <- weather_df
  }
  
  return(weather_data)
}

#Change as needed
dataframe <- Sample  # Dataframe containing county IDs
id_column <- "in.county"   # Name of the column containing county IDs
weather_data <- read_in_weatherfiles(dataframe, id_column)
combined_weather <- bind_rows(weather_data)

library(dplyr)

#Filter for July
combined_weather_July<-combined_weather%>%filter(between(date_time, as.Date('2018-07-01'), as.Date('2018-07-31'))) 


#Group by Hour to find average temps
combined_weather_July$time <- format(combined_weather_July$date_time, format = "%H:%M:%S")
assign("combined_weather_July", combined_weather_July)

HottestHour<- combined_weather_July %>%
  group_by(time) %>%
  summarise(Avg_Hourly_Temp = mean(`Dry Bulb Temperature [°C]`))

#Add column with average hourly temps increased by 5 for predictions
HottestHour$Plus5<-HottestHour$Avg_Hourly_Temp+5
assign("HottestHour", HottestHour)

#Read-in energy files for random sample
read_in_energyfiles <- function(dataframe, id_column) {
  
  common_url <- "https://intro-datascience.s3.us-east-2.amazonaws.com/SC-data/2023-houseData/"
  parquet_ext <- ".parquet"
  
  energy_data <- list()
  
  for (bldg_id in dataframe[[id_column]]) {
    url <- paste0(common_url, bldg_id, parquet_ext)
    energy_df <- arrow::read_parquet(url)
    energy_df$Building_ID <- bldg_id  # Add a new column for the building ID
    energy_data[[bldg_id]] <- energy_df
  }
  
  return(energy_data)
}

#Can change dataframe here if you want to read in energy files for a different subset of houses
dataframe <- Sample  # Your dataframe containing building IDs
id_column <- "bldg_id"   # Name of the column containing building IDs
energy_data <- read_in_energyfiles(dataframe, id_column)

#All combined energy files for selected houses, with column building id to distinguish between them
combined_energy <- do.call(rbind, energy_data)

#Filter for July
combined_energy_July<-combined_energy%>%filter(between(time, as.Date('2018-07-01'), as.Date('2018-07-31'))) 


#Create a column to merge on time of day
combined_energy_July$timeofday<- format(combined_energy_July$time, format = "%H:%M:%S")
assign("combined_energy_July", combined_energy_July)

#Merge Energy, Weather, and Static House Predictors.

BaseForModel<-merge(StaticPredictors, combined_energy_July, by.x="bldg_id", by.y="Building_ID")
BaseForModel<-merge(BaseForModel,HottestHour, by.x="timeofday", by.y="time" )
assign("BaseForModel", BaseForModel)

BaseForModel[1,]


#Models

#Cooling:
lmCooling<-lm(formula= out.electricity.cooling.energy_consumption ~ in.sqft + in.occupants + in.usage_level + in.county + Avg_Hourly_Temp, data=BaseForModel)
summary(lmCooling)

predCoolingDF <- data.frame(in.county = "G4500690", in.sqft= 1220, in.occupants= "2", in.usage_level= "High",  Avg_Hourly_Temp= HottestHour$Plus5[HottestHour$time == "14:00:00"])
predict(lmCooling, predCoolingDF)


#Lighting:
lmLighting<-lm(formula= out.electricity.lighting_interior.energy_consumption ~ in.sqft + in.occupants + in.usage_level + Avg_Hourly_Temp + in.county, data=BaseForModel)
summary(lmLighting) 

predLightingDF <- data.frame(in.county = "G4500690", in.sqft= 1220, in.occupants= "2", in.usage_level= "High",  Avg_Hourly_Temp= HottestHour$Plus5[HottestHour$time == "14:00:00"])
predict(lmLighting, predLightingDF)

#Plug Loads:
lmPlugLoads<-lm(formula=out.electricity.plug_loads.energy_consumption ~ in.sqft + in.occupants + in.usage_level +timeofday, data=BaseForModel)
summary(lmPlugLoads)

predPlugLoadsDF <- data.frame(in.county = "G4500910", in.sqft= 885, in.occupants= "3", in.usage_level= "Medium",  Avg_Hourly_Temp= HottestHour$Plus5[HottestHour$time == "00:00:00"])
predict(lmPlugLoads, predPlugLoadsDF)



#Inputs:
#Sqft: (Any num)
#Num of occupants: (1-10)
#Usage Level: (Low, Medium, High)
#County
#Time

#Outputs:
#Hourly Energy Usage (for each 4 sources) for July


install.packages("shinyWidgets")
install.packages("shinythemes")


#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    https://shiny.posit.co/
#

library(shiny)
library(shinyWidgets)
library(shinythemes)
# Define UI for application that draws a histogram
ui <- fluidPage(shinythemes::themeSelector(),
                
                # Application title
                titlePanel("July Energy Prediction"),
                
                # Sidebar with a slider input for number of bins 
                sidebarLayout(
                  sidebarPanel(
                    textInput("county", "County Code:", "G4500690"),
                    numericInput("sqft", "Square Footage:", 0),
                    selectInput("occupants", "Number of Occupants:",
                                choices = c("1","2", "3","4","5","6","7","8","9","10+"), selected="2"),
                    selectInput("usage_level", "Usage Level:",
                                choices = c("Low", "Medium", "High"), selected = "High"),
                    selectInput("time", "Time:", 
                                choices = c("00:00:00", "01:00:00","02:00:00", "03:00:00", "04:00:00", "05:00:00", "06:00:00", "07:00:00", "08:00:00",
                                            "09:00:00", "10:00:00", "11:00:00", "12:00:00", "13:00:00", "14:00:00", "15:00:00", "16:00:00",
                                            "17:00:00","18:00:00", "19:00:00", "20:00:00", "21:00:00", "22:00:00", "23:00:00"), selected = "00:00:00"),
                    selectInput("model_type","Predict For:", choices = c("Cooling", "Lighting", "Plug Loads")),
                    selectInput("Temp","Type of Prediction:", choices = c("Current Temps", "Temps Plus 5")),
                    actionButton("predict_button", "Predict")
                    
                  ),
                  
                  # Show a plot of the generated distribution
                  mainPanel(
                    textOutput("prediction_output"),
                    plotOutput("energy_plot"),
                    plotOutput("map")
                  )
                )
)


library(dplyr)
library(arrow)
StaticPredictors<- subset(static_house_dataEDA, select = c(bldg_id, in.sqft, in.county, in.occupants, in.usage_level))


lmCooling<-lm(formula= out.electricity.cooling.energy_consumption ~ in.sqft + in.occupants + in.usage_level + in.county + Avg_Hourly_Temp, data=BaseForModel)
summary(lmCooling)

lmLighting<-lm(formula= out.electricity.lighting_interior.energy_consumption ~ in.sqft + in.occupants + in.usage_level + Avg_Hourly_Temp + in.county, data=BaseForModel)
summary(lmLighting)

lmPlugLoads<-lm(formula=out.electricity.plug_loads.energy_consumption ~ in.sqft + in.occupants + in.usage_level + Avg_Hourly_Temp + in.county, data=BaseForModel)
summary(lmPlugLoads)

library(ggplot2)

server <- function(input, output) {
  
  observeEvent(input$predict_button, {
    # Define an empty vector to store predicted energy for all times
    predicted_energy <- numeric(length(HottestHour$time))
    
    # Loop through each time value
    for (i in seq_along(HottestHour$time)) {
      # Prepare data for prediction based on the current time value
      if (input$model_type == "Cooling") {
        predDF <- data.frame(
          in.county = input$county,
          in.sqft = input$sqft,
          in.occupants = input$occupants,
          in.usage_level = input$usage_level,
          Avg_Hourly_Temp = if (input$Temp == "Current Temps") HottestHour$Avg_Hourly_Temp[i] else HottestHour$Plus5[i]
        )
        prediction <- predict(lmCooling, predDF)
      } else if (input$model_type == "Lighting") {
        predDF <- data.frame(
          in.county = input$county,
          in.sqft = input$sqft,
          in.occupants = input$occupants,
          in.usage_level = input$usage_level,
          Avg_Hourly_Temp = if (input$Temp == "Current Temps") HottestHour$Avg_Hourly_Temp[i] else HottestHour$Plus5[i]
        )
        prediction <- predict(lmLighting, predDF)
      } else if (input$model_type == "Plug Loads") {
        predDF <- data.frame(
          in.county = input$county,
          in.sqft = input$sqft,
          in.occupants = input$occupants,
          in.usage_level = input$usage_level,
          Avg_Hourly_Temp = if (input$Temp == "Current Temps") HottestHour$Avg_Hourly_Temp[i] else HottestHour$Plus5[i]
        )
        prediction <- predict(lmPlugLoads, predDF)
      }
      
      # Store the prediction in the vector
      predicted_energy[i] <- prediction
    }
    
    # Output prediction
    output$prediction_output <- renderText({
      paste("Predicted Electricity Usage:", prediction, "kWh per hour")
    })
    
    # Plot predicted energy usage over time using ggplot2
    output$energy_plot <- renderPlot({
      # Create a data frame for plotting
      plot_data <- data.frame(time = HottestHour$time, predicted_energy = predicted_energy)
      
      # Check the structure of plot_data
      str(plot_data)
      
      # Create the plot using ggplot2
      ggplot(plot_data, aes(x = time, y = predicted_energy, group = 1)) +
        geom_line() +
        labs(x = "Time", y = "Predicted Energy Usage") +
        ggtitle("Predicted Energy Usage Over Time") +
        theme_minimal() +
        scale_x_discrete(labels = function(x) format(as.POSIXct(x, format = "%H:%M:%S"), "%H:%M:%S")) +
        theme(axis.text.x = element_text(angle = 90, vjust = 0.5)) +  # Rotate x-axis labels vertically
        expand_limits(y = c(0, max(predicted_energy) * 1.1))  # Expand the range of the y-axis by 10%
    })
  })
  
  output$map <- renderPlot({
    selected_county_data <- reactive({
      SC_Map_Data[SC_Map_Data$in.county == input$county, ]
    })
    
    # Render map
    ggplot() +
      geom_polygon(data = SC_Map_Data, aes(long, lat, group = group, fill = Avg_Temp)) +
      geom_polygon(data = selected_county_data(), aes(long, lat), color = "red", alpha = 0.5) +
      coord_map(projection = "mercator") +
      ggtitle("Average Temperature in July by County")
  })
  
}



# Run the application 
shinyApp(ui = ui, server = server)



#Aaryan's Code-------------------------
                                          




```{r}
library(tidyverse)
statichouse<- read_csv('/Users/aaryanwani/Downloads/statichouse.csv')
#view(statichouse)
#summary(statichouse)
#str(statichouse)
#summary(statichouse$in.sqft)
#hist(statichouse$in.sqft == "1690")
statichouse1<-statichouse[,-c(2,3,4,6,7,8,12,14,15,16, 26, 29, 31,32,34,35,36,37,38,39,40,41,42,43,44,45,47,
                              49,50,51,52,53,54,55,56,63,72,73,79,84,
                              85,86,87,88,89,90,91,103,104,106,107,108
                              ,109,120,121,124,126,131,136,137,138,139,
                              140,141,142,143,144,146,153,159,161,162,163,165,166,167,168,169)]


unique(statichouse1$in.sqft)
a1<-statichouse1 %>%  filter(in.sqft == '1690')
a2<- a1 %>%  filter(in.infiltration %in% c('25 ACH50', '20 ACH50','10 ACH50','15 ACH50'))
a3<- a2 %>%  filter(in.windows %in% c('Double, Clear, Metal, Air', 'Single, Clear, Metal','Double, Low-E, Non-metal, Air, M-Gain','Double, Clear, Non-metal, Air', 'Single, Clear, Non-metal'))
view(a3)


a4d<- c("30% Leakage, R-8", "20% Leakage, R-6", "10% Leakage, R-6","30% Leakage, R-6","0% Leakage, Uninsulated")
a3<- a3[!a3$in.ducts %in% a4d, ]
a3<- a3 %>%  filter(in.county %in% c('G4500910', 'G4500830','G4500790','G4500630','G4500510','G4500450','G4500130','G4500150','G4500070'))

a4<-a3[1:250,]
view(a4)
unique(a4$in.county)

```

Weather data
```{r}

#Took the counties where the energy consumptions of buildings are high.

weatherG4500910 <- read_csv('https://intro-datascience.s3.us-east-2.amazonaws.com/SC-data/weather/2023-weather-data/G4500910.csv')
weatherG4500510 <- read_csv('https://intro-datascience.s3.us-east-2.amazonaws.com/SC-data/weather/2023-weather-data/G4500510.csv')
weatherG4500130 <- read_csv('https://intro-datascience.s3.us-east-2.amazonaws.com/SC-data/weather/2023-weather-data/G4500130.csv')
weatherG4500630 <- read_csv('https://intro-datascience.s3.us-east-2.amazonaws.com/SC-data/weather/2023-weather-data/G4500630.csv')
weatherG4500790 <- read_csv('https://intro-datascience.s3.us-east-2.amazonaws.com/SC-data/weather/2023-weather-data/G4500790.csv')
weatherG4500450 <- read_csv('https://intro-datascience.s3.us-east-2.amazonaws.com/SC-data/weather/2023-weather-data/G4500450.csv')
weatherG4500830 <- read_csv('https://intro-datascience.s3.us-east-2.amazonaws.com/SC-data/weather/2023-weather-data/G4500830.csv')
weatherG4500070 <- read_csv('https://intro-datascience.s3.us-east-2.amazonaws.com/SC-data/weather/2023-weather-data/G4500070.csv')
weatherG4500150 <- read_csv('https://intro-datascience.s3.us-east-2.amazonaws.com/SC-data/weather/2023-weather-data/G4500150.csv')

weatherG4500910 <- mutate(weatherG4500910, in.county = 'G4500910')
weatherG4500510 <- mutate(weatherG4500510, in.county = 'G4500510')
weatherG4500130 <- mutate(weatherG4500130, in.county = 'G4500130')
weatherG4500630 <- mutate(weatherG4500630, in.county = 'G4500630')
weatherG4500790 <- mutate(weatherG4500790, in.county = 'G4500790')
weatherG4500450 <- mutate(weatherG4500450, in.county = 'G4500450')
weatherG4500830 <- mutate(weatherG4500830, in.county = 'G4500830')
weatherG4500070 <- mutate(weatherG4500070, in.county = 'G4500070')
weatherG4500150 <- mutate(weatherG4500150, in.county = 'G4500150')

W1 <- rbind(
  weatherG4500910, weatherG4500510, weatherG4500130, weatherG4500630, weatherG4500790, weatherG4500450, 
  weatherG4500830, weatherG4500070, weatherG4500150 
)

W1 <- W1 %>%
  mutate(date_time = ymd_hms(date_time))

# Filter for the month of July, for all hours
w_july <- W1 %>%
  filter(month(date_time) == 7)

view(w_july)

#merge
w_july$day<-(substr(w_july$date_time,9,10))

WJ1 <-w_july
WJ2<- WJ1


weather7<- WJ1 %>%
  group_by(in.county,day) %>% summarise(avgdaytemp = mean(`Dry Bulb Temperature [°C]`), avghumidity = mean(`Relative Humidity [%]`))

WJ2$`Dry Bulb Temperature [°C]`<- WJ2$`Dry Bulb Temperature [°C]` + 5
view(WJ2)

weather11<- WJ2 %>%
  group_by(in.county,day) %>% summarise(avgdaytemp1 = mean(`Dry Bulb Temperature [°C]`), avghumidity1 = mean(`Relative Humidity [%]`))

view(w_july)
view(weather7)
view(weather11)


```


Energy data

```{r}
library(data.table)

# Set the path to the directory containing your CSV files
csv_directory <- "/Users/aaryanwani/Desktop/idsproject/ids 5"

# List all CSV files in the directory
file_names <- list.files(path = csv_directory, pattern = "\\.csv$", full.names = TRUE)

# Function to read each file and add building ID and county number
read_file_add_id <- function(file_path) {
  filename <- sub(".csv", "", basename(file_path))
  parts <- strsplit(filename, "_")[[1]]
  parts <- trimws(parts)
  
  building_id <- parts[1]
  county_number <- parts[2]
  
  dt <- fread(file_path)
  
  dt[, building_id := building_id]
  dt[, county_number := county_number]
  
  return(dt)
}

all_data <- rbindlist(lapply(file_names, read_file_add_id), use.names = TRUE, fill = TRUE)



library(dplyr)
library(lubridate)

all_data$time <- as.POSIXct(all_data$time, format="%y-%m-%d %H:%M:%S")  
# make sure 'time' is POSIXct

E1 <- all_data %>% 
  filter(month(time) == 07)
view(E1)


E1<-E1[,-c(21)]
E1$TotalConsumption <- rowSums(E1[,1:41], na.rm = TRUE)

E1$IPCConsumption <- rowSums(E1[,c(5,16,18)], na.rm = TRUE)

E1$day<-(substr(E1$time,9,10))

Ej <-E1
e_jd<- Ej %>%
  group_by(county_number,day) %>%
  summarise(TotalConsumptionperday = mean(TotalConsumption),
            IPCConsumptionperday = mean(IPCConsumption))
view(e_jd)
e_jd1<- e_jd

e_jd1$IPCConsumptionperday<- e_jd1$IPCConsumptionperday + 0.26

```

Merge

```{r}
names(e_jd)[which(names(e_jd) == "county_number")] <- "in.county"
maindata <- left_join(weather7, e_jd, by = c("in.county","day"))
view(maindata)

maindata1 <- left_join(weather11, e_jd1, by = c("in.county","day"))



```

Plot

```{r}
ggplot(maindata1, aes(x = avgdaytemp1, y = IPCConsumptionperday)) +
  geom_point(alpha = 0.5)

ggplot(maindata, aes(x = avghumidity, y = IPCConsumptionperday)) +
  geom_point(alpha = 0.5)


ggplot(maindata, aes(x=IPCConsumptionperday, y=day, fill=day)) +
  geom_bar(stat="identity")

ggplot(maindata, aes(x = avgdaytemp, y = IPCConsumptionperday)) +
  geom_point(alpha = 0.5) +
  geom_smooth(method = "lm", se = FALSE) 
```

Modeling

```{r}
#Multiple Regression

mreg <- lm(IPCConsumptionperday ~ avgdaytemp + avghumidity , data = maindata)
summary(mreg)

mreg1 <- lm(IPCConsumptionperday ~ avgdaytemp1 + avghumidity1 , data = maindata1)
summary(mreg1)


mreg2 <- lm(IPCConsumptionperday ~ in.usage_level , data = ma)
summary(mreg2)


#Generalised Additive Model
library(mgcv)
model_gam <- gam(IPCConsumptionperday ~ s(avgdaytemp) + s(avghumidity), data = maindata)
summary(model_gam)

```









                                          
                                          
                                          
                                          
                                          
                                          
                                          
                                          









