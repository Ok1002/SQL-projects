WITH quart AS (
	SELECT
	NTILE(4) OVER (ORDER BY SUM(quantity*unitprice) DESC) AS quartile,
    customerid,
	SUM(quantity*unitprice) AS revenue
  FROM ecommerce_data
  WHERE customerid IS NOT NULL
  GROUP BY customerid),
  
 
q1rev AS (SELECT SUM(revenue) AS top25rev
  from quart
  WHERE quartile =1)
  
SELECT SUM(quantity*unitprice) AS totalrev, 
	(SELECT SUM(revenue)
  	from quart
  	WHERE quartile =1)  AS top25rev,
	((SELECT SUM(revenue)
  	from quart
  	WHERE quartile =1)/SUM(quantity*unitprice) * 100) AS perc_rev
FROM ecommerce_data

--percentage of revenue from top 25% of customers vs total revenue
--top 25% calculated based on revenue generated