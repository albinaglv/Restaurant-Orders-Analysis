-- OBJECTIVE 2: Explore the orders table
/* The purpose of these queries is to analyze the `order_details` table to understand the order patterns and key metrics such as the date range of the orders, 
the number of items ordered, and the distribution of item quantities across orders. 
This analysis helps in identifying trends and patterns in customer ordering behavior, which can be valuable for inventory management and sales forecasting.
*/

-- Explore the orders_table 
SELECT * 
FROM order_details;

-- Determine the date range of the order_details table.
SELECT
MIN(order_date) AS min_date,
MAX(order_date) AS max_date   
FROM order_details;  

/*Result: 
min_date:2023-01-01 
max_date:2023_03_31 
*/ 

-- Number of items ordered within this date range
SELECT COUNT(*) AS number_of_items
FROM order_details;


-- Which orders had the most number of items?
-- This query counts the total number of items for each order and sorts the orders by the number of items in descending order.

SELECT 
	order_id, 
	COUNT(item_id) AS total_items_ordered
FROM order_details
GROUP BY order_id
ORDER BY total_items_ordered DESC;
    
-- Number of orders with more than 12 items 
-- The threshold of 12 items is arbitrary and can be adjusted as needed.

SELECT COUNT(*) AS orders_with_more_than_12_items
FROM (
	SELECT 
	order_id, 
	COUNT(item_id) AS total_items_ordered
	FROM order_details
	GROUP BY order_id
    HAVING COUNT(item_id) > 12
) AS number_of_orders

