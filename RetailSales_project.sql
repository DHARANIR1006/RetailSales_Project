

--Create the table 

CREATE TABLE Retail_Sales( 
    transactions_id int PRIMARY KEY,
	sale_date       date ,
	sale_time       time ,
	customer_id     int ,
	gender          varchar(50),
	age             int ,
	category        varchar(15),
	quantity        int ,
	price_per_unit  double precision , 
	cogs            double precision , 
	total_sale      double precision
    )   


	SELECT * from retail_sales
	limit 10;


--Data cleaning--


select * from retail_sales
    WHERE
    transactions_id is null
    or
    sale_date is null
    or
    sale_time is null
    or 
    customer_id  is null
    or
	gender  is null
    or
	age  is null
    or
	category  is null
    or
	quantity  is null
    or
	price_per_unit is null
    or
	cogs is null
    or
	total_sale is null;

--Data exploration--	

--Total no of sales we have 

SELECT COUNT(*) as Total_sale from retail_sales  


--unique customers we have

SELECT COUNT(DISTINCT customer_id) as total_sale from retail_sales


SELECT COUNT(DISTINCT category) as total_sale from retail_sales


--1-- query to return all sales on 2022-11-05 


SELECT * from retail_sales
    WHERE sale_date = '2022-11-05' ;  

-2--query tp retrieve all tranctions with category 'clothing' and quantity sold is more than 10 for the month of november 

SELECT * 
FROM retail_sales 
WHERE 
category ='Clothing' 
AND
TO_CHAR(sale_date,'YYYY-MM')='2022-11'
AND
quantity>=4; 

--3-SQL query to calculte total sales for each category 

SELECT 
category,
SUM(total_sale) as net_sales, 
COUNT(*) as total_orders
from retail_sales 
GROUP BY 1;  

--4--query to find avg age of customers where  category is beauty 

SELECT
ROUND(avg(age), 2) as avg_age
FROM retail_sales
WHERE category = 'Beauty'


--5--query to find all transactions where total _sale sale is greater than 1000


  SELECT  * from retail_sales
  WHERE total_sale = 1000 

 --6-query to find total no of transactions made by each gender in each category 

 
SELECT
gender,
category,
COUNT(*) as total_trans
FROM retail_sales
GROUP BY
gender,
category
ORDER BY 1;  


--7--SQL query to calculate average sale for each month,best selling month in each year 
SELECT
     year,
	 month,
	 avg_sale
FROM	 
(
SELECT 
     EXTRACT(YEAR FROM sale_date) as year,
     EXTRACT (MONTH FROM sale_date)as month,
     AVG (total_sale) as avg_sale,
RANK()OVER(PARTITION BY EXTRACT(YEAR FROM sale_date)ORDER BY AVG(total_sale)DESC) as rank
FROM retail_sales
GROUP BY 1, 2
) as t1
WHERE rank=1  

--8--SQL Query to find top 5 customers based on highest total sales 


SELECT 
customer_id,
sum(total_sale) as highest_sale
from retail_sales
group by 1
ORDER by 2 desc
LIMIT 5;


--9--query to find the no of unique customers who purchased from each category

Select 
category,
count(DISTINCT customer_id)
FROM retail_sales
GROUP BY category 

--10-query to create each shift and no of orders(example morning <=12,afternoon 12-17,evening >17)

WITH hourly_sale
AS
(
SELECT *,
    CASE
	    WHEN EXTRACT(HOUR FROM sale_time) <12 THEN 'Morning'
		WHEN EXTRACT(HOUR FROM sale_time) between 12 and 17 THEN  'Afternoon'
		ELSE 'Evening'
	END as shift
FROM retail_sales
)
SELECT 
      shift,
	  COUNT(*) as total_orders
	  FROM hourly_sale
	  GROUP BY shift


--end of project
	  
