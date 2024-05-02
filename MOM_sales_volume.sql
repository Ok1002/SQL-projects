WITH t1 AS (SELECT EXTRACT(YEAR FROM invoicedate) AS year,
				EXTRACT(month FROM invoicedate) AS month, 
			SUM(quantity) AS sales
FROM ecommerce_data
		GROUP BY year, month
		ORDER BY year ASC, month ASC),
		
 t2 AS 
		(SELECT year, 
		 month, 
		 sales, 
		 LEAD(sales) OVER(ORDER BY year ASC, month ASC) AS sales2
		FROM t1
		ORDER BY year ASC, month ASC)

SELECT year, month, sales, sales2, ROUND(((sales2::NUMERIC-sales::NUMERIC)/sales::NUMERIC)*100,2) AS perc_diff
FROM t2

--units sold