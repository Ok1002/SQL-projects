WITH product_sales AS
	(SELECT description, SUM(quantity) AS volume, country
		FROM ecommerce_data
		GROUP BY country, description),

country_total_volume AS (
    SELECT
        country,
        SUM(volume) AS total_country_volume
    FROM
        product_sales
    GROUP BY
        country),
		
ranked_ps AS 
	(SELECT ROW_NUMBER() OVER(PARTITION BY country ORDER BY volume DESC) AS rank,
	description, 
	volume, 
	country
	FROM product_sales)
--top 10 selling items per country	
SELECT rank,
	description, 
	volume,  
	country
FROM ranked_ps
JOIN country_total_volume USING (country)
WHERE rank < 11
ORDER BY total_country_volume DESC, country, rank
