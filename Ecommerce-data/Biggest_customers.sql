--largest customers by number of orders
WITH orders AS (SELECT COUNT(*), customerid, country
FROM ecommerce_data
GROUP BY customerid,country
ORDER BY COUNT(*) DESC)

--largest customers by units purchased
SELECT SUM(quantity), customerid, country
FROM ecommerce_data
GROUP BY customerid,country
ORDER BY SUM(quantity) DESC