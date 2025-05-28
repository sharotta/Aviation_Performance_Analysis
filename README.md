# Aviation_Performance_Analysis
An interactive Excel tool analyzing flight efficiency, revenue, and passenger trends to optimize airline operations. 

## Table of Contents

- [Project Overview](#project-overview)
- [Business Objectives](#business-objectives)
- [Dataset Overview](#dataset-overview)
- [Tools](#tools)
- [Data Cleaning Process (SQL + Excel)](#data-cleaning-process-sql--excel)
  - [Key Challenges](#key-challenges)
  - [SQL-Based Cleaning](#sql-based-cleaning)
- [Excel Analysis & Data Visualization](#excel-analysis--data-visualization)
  - [Columns Created](#columns-created)
  - [Conditional Formatting](#conditional-formatting)
  - [Visuals & Insights](#visuals--insights)
- [Executive Summary](#executive-summary)
- [Key Performance Insights](#key-performance-insights)
- [Recommendations](#recommendations)
- [Key Takeaway](#key-takeaway)
- [Medium Article](#medium-article)


## Project Overview  

This project demonstrates how data analytics can uncover operational insights and drive performance improvements in the airline industry. The dataset simulated real-world flight operations with missing values, geographic data, and critical business metrics. 

Using a combination of **Microsoft SQL Server** and **Microsoft Excel**, the raw dataset was cleaned, transformed, and visualized to solve business problems around route optimization, pricing, fuel efficiency, and passenger load.

## Business Objectives

1. Optimize flight route efficiency  
2. Understand fuel consumption patterns  
3. Identify pricing inconsistencies across destinations  
4. Analyze passenger trends  
5. Improve airline operations through automation

## Data Source
The dataset used in this analysis was synthetically generated using Python to simulate real-world aviation data challenges, including missing values, geographical data, and key business metrics.

## Dataset Overview  

Simulated data with 1,000+ records, including:

- TakeOff_Location & Destination  
- Altitude  
- Fuel_Consumption  
- Ticket_Price  
- Passenger_Count  
- Flight_Duration  
- Latitude & Longitude

## Tools 
- Microsoft SQL Server  
- Microsoft Excel  
- Power Query (for dynamic updates)  
- PivotTables, Charts, Conditional Formatting  

## Data Cleaning Process (SQL + Excel)

### Key Challenges:
- Null values in critical columns: `Altitude`, `Fuel_Consumption`, `Ticket_Price`, `Passenger_Count`
- Ticket_Price column appeared null in SQL due to formatting issues
- Geolocation values required proper numeric types
- Route-level metrics were missing

### SQL-Based Cleaning
![Before Cleaning](https://github.com/user-attachments/assets/ed21f7e8-392e-4bf0-8f16-ea2ea1005612)

- **Imputed Altitude** using mode value (30,000 ft)
- **Filled Fuel_Consumption** with route-level averages
- **Passenger_Count** imputed with average per route
- **Converted Latitude/Longitude** to `FLOAT` for mapping accuracy
- **Validated data quality** with checks for missing values, outliers, data types and unrealistic entries

📌 Ticket_Price imputation was done in **Excel** using **median per Destination**, since the column failed in SQL import.

## Excel Analysis & Data Visualization

### Columns Created:
- `Route` = `TakeOff_Location & " → " & Destination`
 ![Route](https://github.com/user-attachments/assets/1449bd25-de55-418a-9882-fa92b6ac021e)
 
- `Flight Revenue per Hour` = `Ticket_Price / Flight_Duration`
  ![Price_Per_Hour](https://github.com/user-attachments/assets/292eb7ed-da11-40fe-9432-0a3f9997432a)

- `Revenue` = `Ticket_Price * Passenger_Count`
![Revenue](https://github.com/user-attachments/assets/5272699d-d825-43e5-bece-355c9b5274a0)

### Conditional Formatting:
![Conditional formating](https://github.com/user-attachments/assets/401220a9-f103-4c7c-b050-c6a7aacccc1b)

- **High Fuel Use:** ≥ 3000  
- **Medium:** 2600–2999  
- **Low:** < 2600

### Visuals & Insights:
![SKYLINK DASHBOARD](https://github.com/user-attachments/assets/7d660382-cdb8-4196-8d01-90774d218313)

- Combo charts for fuel vs. passenger load
- Pivot tables by destination and route
- KPI cards for Avg. Ticket Price, Avg. Fuel, Avg. Passengers
- Revenue analysis by route and destination

## Executive Summary

SkyLink Airways demonstrates strong operational performance across **1,000** flights with consistent passenger loads averaging **123** passengers per flight. The airline maintains a competitive average ticket price of **$375.91** while managing fuel consumption efficiently at **2,731.04** units average.

## Key Performance Insights

**1. Optimize Flight Route Efficiency**
- Altitude Efficiency: Flights at **32,000** feet have the lowest average fuel consumption **(2610.12 gallons)** compared to **30,000 ft and 35,000 ft**. This suggests that **32,000** feet is the optimal cruising altitude for fuel efficiency.
- Route-Specific Altitude Patterns: **Chicago → Tokyo** has one of the **highest** average altitudes. **New York→ Dubai** stays on the lower end.

**2. Fuel Consumption Patterns**
- High Fuel Routes: **Los Angeles → Sydney, New York→ Tokyo, and Miami → Sydney** show higher fuel consumption than other routes. **Houston → Dubai and Houston → Sydney** are the lowest.
- Fuel & Passenger Correlation: Routes with high fuel but low passenger counts are inefficient **(e.g., Miami → Sydney, Chicago → Paris )**. Some high-passenger routes like **Los Angeles → Sydney** balance fuel well.

**3. Pricing Anomalies by Destination**
- Highest Avg Ticket Prices: **Dubai ($402.13)** and **Tokyo ($397.49)** **top** the list.
- Lowest Avg Ticket Prices: **Paris ($354)** and **Sydney ($356)** are below average. These findings flagged potential pricing inconsistencies, especially where similar routes had wildly different prices.
- Revenue by Destination: Despite lower prices, **Tokyo** generates the **highest** revenue, reflecting market demand and route premium positioning.

**4. Passenger Trends** — Avg passenger count: 123 (KPI Card)
- Route Utilization: **Los Angeles → Sydney** and **Houston → London** are among the most used. **Miami → Sydney** shows significantly lower passenger volumes.However, some routes had high fuel use but low passenger load — a red flag for route profitability.
- Destination Popularity: **Paris, Sydney,** and **London** have the highest number of total destination entries **(211 and 205)**.

## Recommendations
- **Revenue Optimization:** Consider increasing flight frequency to Tokyo and Sydney given their superior revenue performance. These routes show strong market acceptance and pricing power. Also, review underutilized routes

- **Fuel Efficiency:** Standardize cruise altitudes around 32,000 feet where operationally feasible to maximize fuel efficiency gains observed in the data. Further monitor and review routes with higher altitude but higher fuel usage, to detect anomalies or maintenance issues.

- **Invest in monitoring fuel consumption** by aircraft type or pilot behavior. High-consumption routes can benefit from load balancing or scheduling optimization.

- **Underperforming Routes:** Investigate reasons behind lower load on routes like **Miami → Sydney** and **New York → London**. Reassess underperforming routes with high fuel and low occupancy.

- **Capacity Management:** With consistent 123-passenger averages, explore opportunities for selective capacity increases on high-performing routes, particularly **Asia-Pacific** destinations.

- **Route Expansion:** The balanced performance across all five destinations suggests potential for additional route development, particularly within the profitable Asia-Pacific corridor.

- **Pricing Strategy:** Leverage Tokyo’s premium pricing acceptance ($397.49) as a benchmark for optimizing pricing on comparable long-haul routes.

- **Investigate pricing irregularities** between similar destinations to ensure market fairness.

## Key Takeaway

> This project shows how data is the co-pilot of smarter airline operations. With structured cleaning, targeted visualizations, and thoughtful automation, it’s possible to turn messy flight logs into strategic direction.

## Medium Article  
🔗 [Read the full story on Medium → *From Data Gaps to Data Gold*](https://medium.com/@sharon_dolapo_johnson/️-from-data-gaps-to-data-gold-how-data-analytics-is-optimizing-airline-performance-a40e195722fb)

