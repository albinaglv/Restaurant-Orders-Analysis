
-- OBJECTIVE 1. Menu Analysis: Examine the menu items to understand the restaurant's offerings and pricing structure  

-- Step 1. Explore the menu_items table 
SELECT *  
FROM menu_items;

-- 2. The number of distinct items on the menu 
-- This query provides a simple metric to understand the overall variety of the restaurant's menu.
SELECT COUNT(DISTINCT menu_item_id) AS total_menu_items
FROM menu_items;

-- What are the least and most expensive items on the menu?
-- It helps in understanding the price range of menu items.
SELECT item_name, price
FROM menu_items
WHERE price = (SELECT MIN(price) FROM menu_items)
   OR price = (SELECT MAX(price) FROM menu_items);
   
   
-- Determine the type of cuisine served by the restaurant
SELECT DISTINCT category
FROM menu_items;

-- Explore each category. 
SELECT 
        item_name,
        price,
        category,
        COUNT(order_details_id) AS num_items_ordered
    FROM 
        order_details 
	LEFT JOIN 
        menu_items ON order_details.item_id = menu_items.menu_item_id
    WHERE category = 'Italian' -- Replace 'Italian' with other categories as needed
    GROUP BY 
        item_name, price, category
	ORDER BY num_items_ordered DESC;

-- How many dishes are in each category? 
-- What is the average dish price within each category?
-- This query provides insights into the composition and pricing of menu items within each category.
SELECT 
	category,
    COUNT(DISTINCT(menu_item_id)) AS num_items,
    ROUND(AVG(price),2) AS avg_price
FROM menu_items
GROUP BY category 
ORDER BY avg_price ASC;  -- Results: Italian category is the most expensive one, with the highest average dish price.  

-- Identify the least and most expensive dishes in the Italian category. 
-- This query uses DENSE_RANK() to rank Italian menu items by price in ascending and descending order.
-- DENSE_RANK() assigns consecutive ranks to rows with identical prices, ensuring accurate ranking.

   WITH ItalianRankedItems AS (
    SELECT 
        item_name,
        price,
        DENSE_RANK() OVER (ORDER BY price) AS price_rank_asc, 
        DENSE_RANK() OVER (ORDER BY price DESC) AS price_rank_desc
    FROM 
        menu_items
    WHERE 
        category = 'Italian'
)
SELECT 
    item_name,
    price
FROM 
    ItalianRankedItems
WHERE 
    price_rank_asc = 1 OR price_rank_desc = 1;

    
