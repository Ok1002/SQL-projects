With orders AS 
		(SELECT customerid, 
		 description, 
		 invoicedate::DATE AS first_order, 
		 LEAD(invoicedate::DATE) OVER(PARTITION BY customerid ORDER BY invoicedate ASC) AS next_order
		FROM ecommerce_data
		ORDER BY customerid, invoicedate ASC),

diff AS 
		(SELECT customerid, 
		 first_order, 
		 next_order, 
		 (next_order-first_order) AS diff
		FROM orders
		WHERE first_order != next_order ),

rev AS 
		(SELECT customerid, invoicedate, SUM(quantity*unitprice) AS rev1
		FROM ecommerce_data
		GROUP BY customerid, invoicedate),
			
avg_rev AS 
		(SELECT customerid,  ROUND(AVG(rev1),02) AS avg_rev_per_order, COUNT(*) AS num_orders
		FROM rev
		GROUP BY customerid)


SELECT customerid, ROUND(AVG(diff),02) AS avg_time_diff, avg_rev_per_order, num_orders
FROM diff
LEFT JOIN avg_rev USING (customerid)
GROUP BY customerid, avg_rev_per_order, num_orders
ORDER BY num_orders DESC

---This query shows the average time between orders per customer, along with the average revenue per order, and total number of orders
---We assume there are variable costs associated with each time an order is processed ---Consider cost per order (wages, logistics, packaging, shipping etc)
---If they order frequently, can we encourage them to order more in one go to help us reduce variable costs and increase profit margins?
