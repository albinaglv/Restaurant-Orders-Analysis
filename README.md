# Restaurant Orders Analysis

## Table of Contents
- [Project Overview](#project-overview)
- [Dataset](#dataset)
- [Tools Used](#tools-used)
- [Objectives](#objectives)
- [SQL Queries](#sql-queries)
- [Summary of Key Findings](#summary-of-key-findings)
- [Recommendations](#recommendations)
- [Limitations](#limitations)


### Project Overview
Welcome to the Taste of the World Café analysis project! This project involves a detailed exploration of the café's operations using a fictional dataset provided by [Maven Analytics: Data Playground](https://mavenanalytics.io/data-playground?page=4&pageSize=5). The objective is to gain actionable insights into menu performance and customer preferences following the introduction of a new menu at the beginning of the year.

### Dataset
The data used for this analysis consists of two files:

- menu_items.csv: Provides details about the menu items, including their names, categories, and prices.
- order_details.csv: Contains customer order information, capturing the date, time, and specifics of each order.

### Tools Used

- MySQL: The primary database management system used for querying and data analysis.

### Objectives

- Menu Analysis: Examine menu items and pricing structure.
- Order Analysis: Analyse order details to identify purchasing patterns.
- Customer Behaviour Analysis: Uncover popular items, high-spending orders, and customer trends.

### SQL Queries

**Example:** Join `order_details` and `menu_items` tables

**Techniques Used:** `LEFT JOIN`
```sql
SELECT * FROM order_details AS od
LEFT JOIN menu_items AS mi
ON od.item_id = mi.menu_item_id;
```
**Explanation:** The LEFT JOIN ensures all records from `order_details` are retained.
 Combining these tables is essential for obtaining a comprehensive view of all orders and their related menu items.
 


**Example:** Identify the least and most expensive dishes in the Italian category. 

**Techniques Used:** CTE, Window function (`DENSE_RANK`)
```sql
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
```
**Explanation**: This query identifies the least and most expensive dishes within the Italian cuisine category using a CTE (`ItalianRankedItems`) to rank menu items by price with `DENSE_RANK()`. By separating the ranking logic into a CTE, the main query focuses solely on selecting items with the lowest and highest ranks (`price_rank_asc = 1` or `price_rank_desc = 1`). This approach ensures clarity, maintains code modularity, and leverages `DENSE_RANK()` to accurately handle ties in pricing, providing valuable insights into pricing dynamics specific to Italian dishes.



**Example:** Counting orders with more Than 12 items

**Techniques Used:** Subquery

```sql
SELECT COUNT(*) AS orders_with_more_than_12_items
FROM (
	SELECT 
	order_id, 
	COUNT(item_id) AS total_items_ordered
	FROM order_details
	GROUP BY order_id
    HAVING COUNT(item_id) > 12
) AS number_of_orders
```
**Explanation**: This query calculates the number of orders that contain more than 12 items. It uses a subquery to first group the `order_details` by `order_id` and counts the total number of items for each order. The `HAVING` clause filters out orders with 12 or fewer items, and only those with more than 12 items are considered. The outer query then counts these filtered orders, giving the total number of orders with more than 12 items. This analysis helps in identifying larger orders, which could be useful for understanding customer purchasing behavior or optimizing inventory management.

### Summary of Key Findings

**Menu Variability:** 

The menu includes 32 distinct items across four categories: American, Asian, Italian, and Mexican, catering to diverse culinary tastes.

**Popular Menu Items and Categories:**
- Most Ordered Item: Hamburger (622 orders).
- Least Ordered Item: Chicken Tacos (123 orders).
- Most Ordered Category: Asian and Italian

**Asian Cuisine:**
- Top Items: Edamame (620), Korean Beef Bowl (588), Tofu Pad Thai (562).
- Average Price: $14.48.
- Summary: The most popular category, with a broad appeal due to variety and pricing.
  
**American Cuisine:**
- Top Items: Hamburger (622), Cheeseburger (583), French Fries (571).
- Average Price: $10.68.
- Summary: High sales for affordable items indicate a strong preference for American cuisine.

**Italian Cuisine:**
- Top Items: Spaghetti & Meatballs (470), Eggplant Parmesan (420), Spaghetti (367).
- Average Price: $16.47.
- Summary: A top revenue driver with high-priced items attracting customers seeking premium dining.

**Mexican Cuisine:**
- Top Items: Steak Torta (489), Chips & Salsa (461), Chicken Burrito (455).
- Average Price: $11.90.
- Summary: Overall strong performance, but items like Chicken Tacos underperform, indicating a need for targeted promotions.

**Revenue Analysis by Menu Category:**
- Italian Cuisine: $49,462.70
- Asian Cuisine: $46,720.65
- Mexican Cuisine: $34,796.80
- American Cuisine: $28,237.75

**Customer Spending Patterns:**
- High-spending orders typically include a mix of Italian and Asian dishes, showing a preference for premium categories.

**Peak Order Times and Days:**

**Busiest Days:**
- Monday: 2010 orders
- Friday: 1822 orders
- Tuesday: 1788 orders
  
**Least Busy Days:**
- Wednesday: 1531 orders
- Saturday: 1618 orders

**Peak Order Times:**
The highest order volumes occur during the following hours:
- Midday: 12:00 PM to 2:00 PM
- Evening: 4:00 PM to 7:00 PM

### Recommendations

**Promote High-Performing Categories:**

- Enhance menu visibility for top items like Spaghetti & Meatballs and Korean Beef Bowl.
- Introduce limited-time offers on high-margin items.
- Host events such as wine tasting and cultural festivals featuring popular dishes.
- Use targeted email campaigns to offer exclusive discounts to high-spending customers.

**Boost Sales of Underperforming Items:**

- Implement limited-time promotions and combo meal offers for items like Chicken Tacos.
- Highlight these items in newsletters and gather customer feedback for improvement.

**Leverage Social Media:**

- Regularly post updates, menu highlights, and special offers.
- Share engaging visual content and run interactive campaigns to increase customer engagement.

**Optimise Operations:**

- Align staffing and inventory with peak order times to ensure efficient service and customer satisfaction.

### Limitations

**Limited Timeframe:**

The analysis is based on data spanning three months from January to March, which may not capture seasonal variations or long-term trends in customer behavior and menu popularity.

**Lack of Real-World Variability:**

 The dataset used for this project is fictional and may not capture the full complexity and unpredictability of actual restaurant operations. This can limit the applicability of the findings to real-world scenarios.

**Lack of Direct Feedback:**
 
The analysis does not incorporate direct customer feedback or satisfaction metrics, which are crucial for understanding the qualitative aspects of menu performance and customer experience.

**Lack of Detailed Customer Data:**

 The dataset does not provide detailed customer demographics, such as age, gender, or income level, which could offer deeper insights into customer preferences and behavior.

