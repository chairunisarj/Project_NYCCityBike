# Project_NYCCityBike

The New York City Bike Share enables quick, easy, and affordable bike trips around the New York city boroughs. They make regular open data releases (this dataset is a transformed version of the data from [this link](https://ride.citibikenyc.com/system-data)). The dataset contains 735502 anonymised trips information made from Jan 2015 to June 2017.

## Acknowledgments -  

I get the data from [here](https://www.kaggle.com/akkithetechie/new-york-city-bike-share-dataset) and get the explanation of the data format from [here](https://ride.citibikenyc.com/system-data).

This dataset is the property of NYC Bike Share, LLC and Jersey City Bike Share, LLC (“Bikeshare”) operates New York City’s Citi Bike bicycle sharing service for T&C click https://ride.citibikenyc.com/data-sharing-policy .

> When I was working for this project, I just know several basic of SQL.  
It really took me back and forth to study the dataset and get the idea of it.  
It also took a lot of browser tabs to find which syntax will do the job and what I have to do for doing the EDA.  

## Steps in SQL
I cleaned and prepared the data using MSSQL.  
These are several steps I did:  
- Find the duplicates and delete it  using **CTE**  
- Add several column for the analysis  
  - From the column `Start Time`, I created another two columns `NameofDay` and `Nameof Month`.  
  - The values in `Gender` column are *'0', '1'* and *'2'* which can be confusing. So I add a new column `GenderConverted` where I replace those values to *'Unknown', 'Male'* and *'Female'*  
  - Create `Age` column by substracting `Birth Year` column on `Start Year` column  
  - Create `AgeGroup` column using **CASE** statement  
- Delete unused columns that won't be used at analysis stage, those are: 
`F1`, `Start Station Latitude`, `Start Station Longitude`, `End Station Latitude`, `End Station Longitude`,and `Gender`  
- Find summary statistics (the **MIN** and/or **MAX** values from `Age`, `ShortestDuration` and `LongestDuration` columns)  
- Delete rows with `Age` > 100 since it's quite doesn't make sense to bike at those age  
- Export the table for visualizations  

You can find the complete syntax [here](https://github.com/chairunisarj/Project_NYCCitiBike/blob/main/Citi%20Bike%20Data%20Preparation.sql)

## Data Visualization

After the data is cleaned, I imported it to Tableau and create [this visualization](https://public.tableau.com/app/profile/chairunisa.rachmadina.jiwani/viz/NYCCitiBike2015-2017/Dashboard2).  
![](https://github.com/chairunisarj/Project_NYCCityBike/blob/main/Dashboard%202.png)
From this visualization there are several things we know:
- Customer and Subscriber has a contrast habit when using the bike. While *Subscribers* have the busiest time in weekday, *Customers* are on the weekend.  
- Among all age group who rent the bike, **'25-34' age group** is who rent the most.  
- At the most popular pick up station, the company could consider to add more bikes.  
- There's litlle to no correlation between *Age* and *Trip Duration*.  

Thank you for reading. 😄





