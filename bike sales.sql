CREATE DATABASE bikeSales_db;
USE bikeSales_db;

CREATE TABLE bike_sales (`Date` text,
`Day`	int,
`Month`	char(10),
`Year`	int,
Customer_Age	int,
Age_Group	text,
Customer_Gender	char(10),
Country	char(100),
State	char(100),
Product_Category char(100)	,
Sub_Category char(100),	
Product	char(100),
Order_Quantity	int,
Unit_Cost	int,
Unit_Price	int,
Profit	int,
Cost	int,
Revenue int)
;


SELECT * FROM bike_sales;

-- Data cleaning
-- 1. change date format: from text to date

set sql_safe_updates = 0;


alter table bike_sales
add column date1 date;

update bike_sales
set date1 = str_to_date(`date`, '%Y-%m-%d');

select distinct Customer_Gender
from bike_sales;

select distinct Country
from bike_sales;  # insights --> data focus on 6 country : Canada
-- Australia
-- United States
-- Germany
-- France
-- United Kingdom

select distinct State 
from bike_sales; # insights --> data focus on 53 states

select distinct Product_Category
from bike_sales; # insights --> data focus on 3 Product_Category : Accessories
-- Clothing
-- Bikes

select distinct Sub_Category
from bike_sales; # insights --> data focus on 17 Sub_Category :Bike Racks, Bike Stands, Bottles and Cages, Caps, Cleaners, Fenders
-- Gloves, Helmets, Hydration Packs, Jerseys, 
-- Mountain Bikes, Road Bikes, Shorts, Socks, Tires and Tubes, Touring Bikes, Vests

select distinct Product
from bike_sales; # insights --> 130 products

-- 2. ANALYSIS

-- CUSTOMER  
-- NO OF SALES PER AGE GROUP 
select  Age_Group, count(*)
from bike_sales
group by Age_Group
order by count(*) desc;  


-- AGE GROUP + GENDER COMBINATION BUYS THE MOST BIKES
select  Customer_Gender, Age_Group, sum(Order_Quantity)
from bike_sales
where Product_category = "Bikes"
group by Customer_Gender, Age_Group
;

-- SALES PERFORMANCE: 
-- TOTAL REVENUE, COST, AND PROFIT FOR EACH YEAR.
select  `year`, sum(Revenue), sum(Cost), sum(Profit)
from bike_sales
group by `Year`
order by `Year`;

-- WHAT IS THE AVERAGE PROFIT MARGIN BY PRODUCT_CATEGORY?
select Product_Category, round(avg(Profit/Revenue),2) as Avg_Profit_Margin
from bike_sales
group by Product_Category
order by avg(Profit/Revenue);


-- Demographics
-- TOP 3 COUNTRY BY SALES:  UNITED STATES, AUSTRALIA,CANADA

select count(*), country
from bike_sales
group by country
order by count(*) desc
limit 3;
 
 -- United States generate the highest revenue
select Country, sum(revenue)
from bike_sales
group by country
order by sum(revenue) desc
limit 1;

-- Within the US, California contribute most to sales.
select state, sum(revenue)
from bike_sales
where country = "united states"
group by state
order by sum(revenue) desc
limit 1;
-- Compare average order quantity per state.
select state, round(avg(Order_Quantity),2) as avg_order_quantity
from bike_sales
group by state
order by avg(Order_Quantity) desc;



-- PRODUCTS
-- THE TOP 10 PRODUCTS BY REVENUE
select product, sum(revenue)
from bike_sales
group by product
order by sum(revenue) desc
limit 10;

-- MOST POPULAR PRODUCT_CATEGORY AMOUNG YOUTH IS ACCESSORIES
select count(*), Product_Category
from bike_sales
where Age_Group = 'Adults (35-64)'
group by Product_Category
Order by count(*) desc;

-- AMOUNT ACCESSORIES TOP 3 POPULAR SUB_CATEGORY ARE TIRES, BOTTLES, HELMETS
select count(*), Sub_Category
from bike_sales
where Age_Group = 'Adults (35-64)'
and Product_Category = 'Accessories'
group by Sub_Category
Order by count(*) desc;


-- PRODUCT CATEGORIES THAT GENERATE THE MOST PROFIT: BIKES
select Product_Category, sum(profit)
from bike_sales
group by Product_Category
order by sum(profit) desc
limit 1;

-- ACCESSORIES ARE SOLD IN THE LARGEST QUANTITY
select Product_Category, sum(Order_Quantity)
from bike_Sales
group by Product_Category
order by sum(Order_Quantity) desc;

-- AMONG ACCESSORIES, TIRES AND TUBE ARE ORDERED IN HUGE QUANTITY.
select Sub_Category, sum(Order_Quantity)
from bike_Sales
where Product_Category = "Accessories"
group by Sub_Category
order by sum(Order_Quantity) desc;

-- WHICH PRODUCTS GENERATE THE HIGHEST PROFIT MARGINS?
select product , sum(profit)/sum(revenue)
from bike_sales
group by product
order by sum(profit)/sum(revenue) desc;


-- AVERAGE UNIT PRICE PER CATEGORY/SUB-CATEGORY
select Product_Category, Sub_Category, avg(Unit_Price)
from bike_sales
group by Product_Category, Sub_Category
order by Product_Category, avg(Unit_Price) desc;


-- SUB-CATEGORIES THAT ARE UNDERPERFORMING IN TERMS OF REVENUE
select Sub_Category, sum(revenue)
from bike_Sales
group by Sub_Category
order by sum(revenue);

