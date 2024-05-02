WITH sales_rev AS (SELECT EXTRACT(YEAR FROM invoicedate) AS year,
				EXTRACT(month FROM invoicedate) AS month, 
			SUM(quantity*unitprice) AS revenue
		FROM ecommerce_data
		GROUP BY year, month
		ORDER BY year ASC, month ASC)
		
SELECT year, month, revenue,
		LEAD(revenue) OVER(ORDER BY year ASC, month ASC) AS rev2,
		ROUND(((((LEAD(revenue) OVER(ORDER BY year ASC, month ASC))-revenue)/revenue)*100), 02) AS perc_diff
FROM sales_rev		