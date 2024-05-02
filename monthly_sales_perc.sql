WITH sales_month AS 
		(SELECT EXTRACT(YEAR FROM invoicedate) AS year,
				EXTRACT(month FROM invoicedate) AS month, 
			SUM(quantity) AS sales,
		 (SELECT SUM(quantity)
						   FROM ecommerce_data
							WHERE EXTRACT(year FROM invoicedate) = 2011) AS sales2011
		FROM ecommerce_data
		GROUP BY year, month
		ORDER BY year ASC, month ASC)
		
SELECT year, month, sales, sales2011, 
ROUND(100 * (sales::NUMERIC / sales2011::NUMERIC), 2) AS perc
FROM sales_month
WHERE year=2011

---What percentage of 2011 sales came in each month - units moved - sales volume!
						