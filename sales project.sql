use sales;

select * from sales.customers;
select * from sales.companies;
select * from sales.date;
select * from sales.markets;
select * from sales.products;
select * from sales.transactions;

-- knowing the customer type and the number of each customer type 

select customer_type,count(*) from customers group by customer_type;

-- knowing the number of transactions where the mode of transaction is USD and not INR

select * from transactions where currency ='USD';

-- finding noise in the transation table where sales_amount is negative(not possible)

select * from transactions where sales_amount<0;

-- finding number of order each year

SELECT YEAR(order_date) AS year,
       COUNT(order_date) AS order_count
FROM transactions
GROUP BY YEAR(order_date);

-- knowing the zones and the markets each zone has

select zone,count(markets_name)
from markets
group by zone;

-- knowing the name of markets from each zone

select markets_name from markets
where zone="south";
select markets_name from markets
where zone="north";
select markets_name from markets
where zone="central";

-- percentage of maket in each zone

WITH total_market AS (
    SELECT COUNT(*) AS total_count
    FROM markets
)
SELECT t1.zone, t1.count_market *100/ total_market.total_count AS market_percentage
FROM (
    SELECT COUNT(*) AS count_market, zone
    FROM markets
    GROUP BY zone
) AS t1
CROSS JOIN total_market
GROUP BY t1.zone, t1.count_market, total_market.total_count;

-- count of each product sorted in descending order

select product_code,count(product_code) as count_product
from transactions
group by product_code
order by count_product desc;

-- joining sales and transaction table

select d.*,t.*
from date d
join transactions t
on d.date=t.order_date;

-- number of products sold each month

with cte1 as(
		select d.*,t.*
		from date d
		join transactions t
		on d.date=t.order_date
	)

select month_name, count(*) as count_month
from cte1
group by month_name
order by count_month desc;

-- count of products sold each year

with cte1 as(
		select d.*,t.*
		from date d
		join transactions t
		on d.date=t.order_date
	)
    
select year, count(*) as count_year
from cte1
group by year
order by count_year desc;

-- sum of all the sales quantity

with cte1 as(
		select d.*,t.*
		from date d
		join transactions t
		on d.date=t.order_date
	)
    
select year, sum(sales_qty) as sum_qty
from cte1
group by year
order by sum_qty desc;
    


