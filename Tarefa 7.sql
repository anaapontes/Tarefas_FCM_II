SELECT
	brand,
	MAX(price), 
	MIN(price)
FROM sales.products
GROUP BY brand

