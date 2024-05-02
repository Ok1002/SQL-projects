--largest customers by number of orders
WITH orders AS (SELECT COUNT(*), customerid, country
FROM ecommerce_data
GROUP BY customerid,country
ORDER BY COUNT(*) DESC),

--largest customers by units purchased
volume AS (SELECT SUM(quantity), customerid, country
FROM ecommerce_data
GROUP BY customerid,country
ORDER BY SUM(quantity) DESC)

--largest customers by revenue
SELECT SUM(quantity*unitprice) AS revenue, customerid, country
FROM ecommerce_data
GROUP BY customerid,country
ORDER BY SUM(quantity*unitprice) DESC