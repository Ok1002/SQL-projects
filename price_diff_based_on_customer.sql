WITH test AS (SELECT description, quantity, unitprice, customerid, country
FROM ecommerce_data
WHERE description LIKE 'REGENCY CAKESTAND 3 TIER'),

test2 AS (SELECT description, AVG(unitprice)
FROM test
WHERE description LIKE 'REGENCY CAKESTAND 3 TIER' AND customerid IS NULL
GROUP BY description),

biggest_cust AS (SELECT SUM(quantity*unitprice) AS revenue, customerid, country
FROM ecommerce_data
GROUP BY customerid,country
ORDER BY SUM(quantity*unitprice) DESC)

SELECT  customerid, SUM(quantity) AS volume, ROUND(AVG(unitprice), 02) AS cust_avg_price, ROUND(AVG(unitprice) OVER(), 02) AS total_avg_price, revenue AS total_cust_rev
FROM ecommerce_data
LEFT JOIN biggest_cust USING (customerid)
WHERE description LIKE 'REGENCY CAKESTAND 3 TIER'
GROUP BY customerid, unitprice, revenue
ORDER BY SUM(quantity) DESC


---price largerly determined by number of units purchased