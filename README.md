# STAT451-project

## Background
Air pollution is one of the most important environmental threats to urban populations and while all people are exposed, pollutant emissions, levels of exposure, and population vulnerability vary across neighborhoods. Exposures to common air pollutants have been linked to respiratory and cardiovascular diseases, cancers, and premature deaths. These indicators provide a perspective across time and NYC geographies to better characterize air quality and health in NYC.



## About the dataset

The data can be downloaded from this link: https://catalog.data.gov/dataset/air-quality.

We are interested in a data set about the air quality about New York City. In this data set, there is a Name variable which represents the different air quality indicators, like PM2.5, NO2, etc. The variable Measure indicates the type of measurement for air quality, such as “mean”. Time period variable is about the corresponding validate time period for the data set measurements. Geo place name indicates the different places where the measurements have been taken. 

First, we are interested in the trend analysis of air quality over time in the whole NY City. To be specific, we plan to see the change of different indicators over time in NY.

* Overall Trend: There is a general decreasing trend in NO2 concentration over the years. The concentration starts at around 23 parts per billion (ppb) in 2009 and decreases to just below 15 ppb by 2021.

* Yearly Changes: The largest drop appears to occur between 2009 and 2011. After 2011, the decreases are less steep but consistent, with some years showing slight increases or stability before continuing to decline.

Second, we would compare different type of geographies using one type of indicator at a certain time period. 

The geographical types in the dataset are: "UHF34", "UHF42", "CD", "Borough", and "Citywide".I plot out the mean of NO2 each geographical type for annual average 2011.

The bar plot shows the annual average of NO2 in 2011 has the value from highest to lowest in Community Districts, United Hospital Fund (UHF) Neighborhoods (42), United Hospital Fund (UHF) Neighborhoods (34), Borough, and Citywide.

Third, we want to see the correlation between different types of air pollution (indicators, specifically NO2 and PM 2.5) across years at different locations.

In this specific and representative visualization, we have use Geo.Place.Name == "New York City"(data for whole New York) to show the correlation between NO2 and PM 2.5 across years (2009-2021).\

The scatter plot clearly illustrates the strong positive correlation between these two air quality indicators. Each point represents the levels of PM2.5 and NO2 for a specific year, demonstrating that as PM2.5 levels change, NO2 levels tend to change in a similar manner.\

Design: I intended to do not color each points in plot to represent different year for 2 reasons. First, if I do, the plot would be messy and too much information. Second, people would be attracted by color cues and potentially fail to notice the key information here, which is the positive trend(correlation) between NO2 and PM2.5. 
