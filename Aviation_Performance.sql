------------------------------------------------AVIATION PERFORMANCE DATA CLEANING----------------------------------------------------------------------
select * from aviation_performance;

select column_name,
       data_type
from INFORMATION_SCHEMA.COLUMNS
WHERE table_name = 'aviation_performance'

------------------------------------------------1. Data Quality Checks---------------------------------------------------------------------------------
------checking for Duplicate Flight IDs----------------------------------------------------------------------------------------------------------------
select 
      Flight_ID,
	  count(*) as total_count
from 
    aviation_performance
group by Flight_ID
having count(*) > 1;

-------Find records with missing critical data-------------------------------------------------------------------------------------------------------
select *
from aviation_performance
where Flight_ID is null
or Takeoff_Location is null
or Destination is null
or Flight_Duration is null
or Altitude is null
or Longitude is null 
or Latitude is null
or Fuel_Consumption is null 
or Ticket_Price is null
or Passenger_Count is null;

-----Check for invalid coordinates---------------------------------------------------------------------------------------------------------------------
select *
from aviation_performance
where Latitude < -90 or Latitude > 90
or Longitude < -180 or Longitude > 180; 

------Check for unrealistic flight durations-------------------------------------------------------------------------------------------------------------
select * 
from  aviation_performance
where Flight_Duration < 1 or Flight_Duration > 24; -- assuming flights are between 1-24 hours

--------------------------------------2. Data Cleaning Operation---------------------------------------------------------------------------------------------------
--Handling missing values, Around 40% of values are missing in Flight_Duration, Altitude, Fuel_Consumption, Ticket_Price, and Passenger_Count.-----------

-----Identifying the missing values Count of missing values per column----------------------------------------------------------------------------------
select 
    count(*) as total_rows,
	sum(case when Flight_Duration is null then 1 else 0 end) as missing_flight,
	sum(case when Altitude is null then 1 else 0 end ) as missing_altitude,
	sum(case when Fuel_Consumption is null then 1 else 0 end) as missing_fuel_consumption,
	sum(case when Passenger_Count is null then 1 else 0 end) as missing_passenger_count
from aviation_performance;

-------Handling missing values-----------------------------------------------------------------------------------------------------------------------
-------Using average by route for flight duration flight duration------------------------------------------------------------------------------------
update a
set Flight_Duration = (
      select avg(Flight_Duration)
	  from aviation_performance b
	  where b.Takeoff_Location = a.Takeoff_Location 
	  and b. Destination = a.Destination
	  and b.Flight_Duration IS NOT NULL
	  )
from aviation_performance a
where a.Flight_Duration is null; 

------For altitude, using most common value for the route------------------------------------------------------------------------------------------------
------Most freqeuent-------------------------------------------------------------------------------------------------------------------------------------
select 
      Altitude, 
	  count(*) as Frequency
from aviation_performance
where Altitude IS NOT NULL
group by  Altitude
order by Frequency DESC;

-- Fill missing Altitude values with 30000------------------------------------------------------------------------------------------------------------
Update aviation_performance
set Altitude = 30000
where Altitude is null;

-- Using average fuel for similar routes For Fuel_Consumption-----------------------------------------------------------------------------------------
-- Average fuel consumption per route-----------------------------------------------------------------------------------------------------------------
select 
      Takeoff_Location,
	  Destination,
	  avg(Fuel_Consumption) as average_fuel
from aviation_performance
where fuel_consumption is not null
group by  Takeoff_Location,
	  Destination;

-- Update NULL Fuel_Consumption values with route averages------------------------------------------------------------------------------------------
update aviation_performance
set Fuel_Consumption = (
     select AVG(Fuel_Consumption)
     from aviation_performance b
     where b.Takeoff_Location = aviation_performance.Takeoff_Location
     and b.Destination = aviation_performance.Destination
     and b.Fuel_Consumption is not null 
)
WHERE Fuel_Consumption is null;

-- Passenger_Count → Use average passenger load per route.--------------------------------------------------------------------------------------------
update aviation_performance
set Passenger_Count = (
      select avg(Passenger_Count)
	  from aviation_performance b
	  where b.Takeoff_Location = aviation_performance.Takeoff_Location
	  and b.Destination = aviation_performance.Destination
	  and Passenger_Count is not null
)
where Passenger_Count is null;

-------------------------------------------3. Checking for Duplicates--------------------------------------------------------------------------------
 select Flight_ID,
       count(*)
from aviation_performance
group by Flight_ID
having count(*) > 1;---- no duplicates found

------------------------------------------------4. Fixing Data Types-------------------------------------------------------------------------------
 alter table aviation_performance
alter column Flight_Duration int;

alter table aviation_performance
alter column Altitude int;

alter table aviation_performance
alter column Fuel_Consumption int;

alter table aviation_performance
alter column Ticket_Price int;

alter table aviation_performance
alter column Passenger_Count int;
   
 ------------------------------------5. Checking for Outliers-------------------------------------------------------------------------------------------
 
select Flight_ID, 
       Flight_Duration, 
	   Ticket_Price, 
	   Passenger_Count 
from aviation_performance
where  Flight_Duration > 20 OR Ticket_Price > 1000 OR Passenger_Count > 500;

----------------------------------------------------------------------------------------------------------------------------------------------------------
select * from aviation_performance;


