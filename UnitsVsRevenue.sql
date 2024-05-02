--top prod rev shows which products bring the most revenue
WITH top_prod_rev AS 
		(SELECT
			description,
			SUM(quantity * unitprice) AS rev_per_product
		FROM
			ecommerce_data
		GROUP BY
			description
		ORDER BY
			rev_per_product DESC),
			
--top prod volume shows which products we sold the largest amount of
top_prod_volume AS 
		(SELECT description, SUM(quantity) AS volume
		FROM ecommerce_data 
		GROUP BY description
		ORDER BY SUM(quantity) DESC)
		

SELECT description,
			SUM(quantity * unitprice) AS revenue,
			SUM(quantity) AS volume,
			((quantity * unitprice)/quantity) AS rev_per_item
		FROM
			ecommerce_data
		GROUP BY
			description, quantity, unitprice
		ORDER BY revenue DESC
		

		