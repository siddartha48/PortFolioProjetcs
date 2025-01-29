COVID-19 Data Analysis Project
Overview
This project provides an analysis of COVID-19 data using SQL queries. The dataset includes information about COVID-19 cases, deaths, and vaccinations from various locations worldwide. The queries help analyze the impact of COVID-19 by examining case rates, death rates, vaccination progress, and other critical insights.
Dataset
The project utilizes two main datasets:
    • CovidDeaths: Contains information about COVID-19 cases and deaths across different locations and time periods. 
    • CovidVaccinations: Includes data related to COVID-19 vaccination programs. 
Key Analyses
    1. Basic Data Retrieval
        ◦ Extracts data from CovidDeaths and CovidVaccinations tables. 
        ◦ Filters out records where the continent field is NULL. 
    2. Total Cases vs. Total Deaths Analysis
        ◦ Calculates the death percentage by dividing total_deaths by total_cases. 
        ◦ Focuses on specific locations like the United States. 
    3. Total Cases vs. Population
        ◦ Computes the percentage of the population that contracted COVID-19. 
        ◦ Identifies countries with the highest infection rates. 
    4. Highest Death Count per Country and Continent
        ◦ Determines the maximum total deaths per country. 
        ◦ Aggregates death data at the continent level to find the highest death percentages. 
    5. Global COVID-19 Trends
        ◦ Aggregates global case and death numbers. 
        ◦ Calculates the global death percentage over time. 
    6. Vaccination Progress Analysis
        ◦ Examines vaccination trends by calculating rolling sums of vaccinations per country. 
        ◦ Computes the percentage of the population vaccinated over time. 
    7. Use of SQL Techniques
        ◦ Common Table Expressions (CTE): Organizes vaccination data for better readability. 
        ◦ Temporary Tables: Stores intermediate vaccination data for efficient analysis. 
        ◦ Views: Creates a view (PercentPopulationvsVaccianated) to store processed data for visualization. 
SQL Queries Breakdown
    • Data retrieval and ordering: Extracts records from CovidDeaths and CovidVaccinations. 
    • Aggregation functions: Uses SUM(), MAX(), and AVG() to summarize data. 
    • Window functions: Utilizes OVER(PARTITION BY ...) to compute rolling sums. 
    • Filtering conditions: Removes irrelevant records to maintain accuracy. 
    • Grouping and ordering: Groups data by location, continent, and date for meaningful insights. 
Conclusion
This SQL project provides a structured approach to analyzing COVID-19 data, helping uncover trends related to case rates, deaths, and vaccinations. The use of various SQL techniques ensures efficient data handling and preparation for visualization tools like Power BI or Tableau.

Author: Siddartha Mudgala 
Database: PortFolioProject
Tools Used: Microsoft SQL Server
