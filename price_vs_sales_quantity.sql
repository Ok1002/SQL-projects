SELECT description, unitprice, SUM(quantity) AS volume_sold, (unitprice*SUM(quantity)) AS revenue,
		SUM(unitprice*SUM(quantity)) OVER (PARTITION BY description) AS prod_total_rev
FROM ecommerce_data
GROUP BY description, unitprice
ORDER BY description ASC, SUM(quantity) DESC

--how many sales for each product at different price points
