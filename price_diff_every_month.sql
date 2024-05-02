WITH t1 AS (SELECT description, unitprice, COUNT(unitprice), EXTRACT(month FROM invoicedate)AS month, EXTRACT(year FROM invoicedate) AS year
FROM ecommerce_data
WHERE description='REGENCY CAKESTAND 3 TIER'
GROUP BY unitprice, invoicedate, description
ORDER BY MONTH ASC)

SELECT year, month, description, unitprice, COUNT(unitprice)
FROM t1
GROUP BY unitprice,year, month, description
ORDER BY year, MONTH ASC

---Looks like each month has the same prices more or less - month not a factor in price changes