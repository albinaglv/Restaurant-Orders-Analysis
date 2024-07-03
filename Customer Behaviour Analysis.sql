-- OBJECTIVE 3: Cutomer Behaviour Analysis
-- This objective focuses on analyzing customer behavior by examining order patterns, item preferences, and spending habits.

-- JOIN two tables: order_details and menu_items.
 -- This query performs a LEFT JOIN to combine data from order_details and menu_items.
-- The LEFT JOIN ensures all records from order_details are retained
-- Combining these tables is essential for obtaining a comprehensive view of all orders and their related menu items.

SELECT 
    *
FROM 
    order_details AS od
LEFT JOIN 
    menu_items AS mi ON od.item_id = mi.menu_item_id;
    
 -- Identify the most popular menu categories based on the total number of items ordered.
SELECT 
    mi.category,
    COUNT(od.order_details_id) AS num_items_ordered
FROM 
    order_details od
INNER JOIN 
    menu_items mi ON od.item_id = mi.menu_item_id
WHERE 
    mi.category IS NOT NULL  -- Exclude null categories
GROUP BY 
    mi.category
ORDER BY 
    num_items_ordered DESC;
   
-- Analyze the frequency of orders across different menu categories to identify the most and least popular items.
SELECT 
    mi.item_name,
    mi.category,
    COUNT(od.order_details_id) AS num_items_ordered
FROM 
    order_details od
LEFT JOIN 
    menu_items mi ON od.item_id = mi.menu_item_id
GROUP BY 
    mi.item_name, mi.category
ORDER BY 
    num_items_ordered DESC;
    
-- Alternative method using CTE and window functions to identify top-performing and underperforming items from the entire menu.
    WITH ranked_items AS (
    SELECT 
        mi.item_name,
        mi.price,
        mi.category,
        COUNT(od.order_details_id) AS num_items_ordered,
        RANK() OVER (ORDER BY COUNT(od.order_details_id) DESC) AS rank_desc,
        RANK() OVER (ORDER BY COUNT(od.order_details_id) ASC) AS rank_asc
    FROM 
        order_details od
    JOIN 
        menu_items mi ON od.item_id = mi.menu_item_id
    WHERE 
        mi.category IS NOT NULL
    GROUP BY 
        mi.item_name, mi.price, mi.category
)
    SELECT 
    'Most Ordered' AS category,
    item_name,
    price,
    num_items_ordered
FROM 
    ranked_items
WHERE 
    rank_desc = 1

UNION ALL

SELECT 
    'Least Ordered' AS category,
    item_name,
    price,
    num_items_ordered
FROM 
    ranked_items
WHERE 
    rank_asc = 1;
    

-- TOP 5 Orders that spent the most money
SELECT 
    order_id,
    SUM(price) AS total_spent
FROM 
    order_details
LEFT JOIN 
    menu_items ON order_details.item_id = menu_items.menu_item_id
GROUP BY 
    order_id
ORDER BY 
    total_spent DESC
LIMIT 5;
    
-- Details of the highest spend orders by category
SELECT 
    category,
    COUNT(item_id) AS number_of_items
FROM 
    order_details
LEFT JOIN 
    menu_items ON order_details.item_id = menu_items.menu_item_id
WHERE 
    order_id IN (440, 2075, 1957, 330, 2675)
GROUP BY 
    category
ORDER BY 
    number_of_items DESC;
    
-- Result: The Italian category is the most popular among high-spending customers 

 -- Explore the most popular Italian dishes
SELECT 
    item_name,
    category,
    COUNT(order_details_id) AS num_items_ordered
FROM 
    order_details 
LEFT JOIN 
    menu_items ON order_details.item_id = menu_items.menu_item_id
WHERE 
    category = 'Italian'
GROUP BY 
    item_name, category
ORDER BY 
    num_items_ordered DESC;
    

 -- Evaluate order patterns across different days of the week.
SELECT 
    DAYNAME(order_date) AS day_of_week,
    COUNT(*) AS num_orders
FROM 
    order_details
GROUP BY 
    day_of_week;
    

-- Identify the order volumes for each hour of the day to determine peak and off-peak times.
   SELECT 
    DATE_FORMAT(order_time, '%H:00') AS order_hour,
    COUNT(*) AS num_orders
FROM 
    order_details
GROUP BY 
    DATE_FORMAT(order_time, '%H:00')
ORDER BY 
    num_orders DESC;
    

-- Calculate the total sales revenue for each menu category.
SELECT 
    category,
    SUM(price) AS total_sales
FROM order_details 
INNER JOIN menu_items ON order_details.item_id = menu_items.menu_item_id
GROUP BY 
	category
ORDER BY 
	total_sales DESC;
