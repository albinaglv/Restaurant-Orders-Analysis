# 🍽️ Restaurant Orders Analysis 

## Table of Contents
- [Project Overview](#project-overview)
- [Dataset](#dataset)
- [Methodology](#methodology)
- [Tools Used](#tools-used)
- [Objectives](#objectives)
- [SQL Queries](#sql-queries)
- [Summary of Key Findings](#summary-of-key-findings)
- [Recommendations](#recommendations)
- [Limitations](#limitations)
- [Links](#links)

### 📁 Project Overview
Welcome to the **Taste of the World Café** analysis project! This project involves a comprehensive SQL analysis of restaurant orders from January 1, 2023, to March 31, 2023, using a fictional dataset. The aim is to uncover insights into menu performance and customer preferences following the introduction of a new menu at the beginning of the year. 

### 📊 Dataset
The dataset used in this project is sourced from [Maven Analytics: Data Playground](https://mavenanalytics.io/data-playground?page=4&pageSize=5). It includes data on menu items, their prices and order information. 
The data is available in CSV format and consists of two files: 
- **menu_items.csv**: This file contains the following columns: `menu_item_id`, `item_name`, `category`, `price`.
- **order_details.csv**: This file includes columns such as `order_details_id`, `order_id`, `order_date`, `order_time`, `item_id`.

### 🔍 Methodology

- **Data Extraction**:
Utilized SQL queries to extract data from menu_items.csv and order_details.csv.

- **Data Transformation**:
Transformed raw data using SQL to derive insights on menu performance, order trends, and customer preferences.

- **Data Analysis**:
Applied SQL aggregations, joins, subqueies and filters to analyse:
	- Menu item popularity and profitability
	- Order volumes and peak times
	- Customer spending trends and category preferences.

- **Assumptions**:
	- Data integrity and consistency assumed for the provided dataset.
	- Pricing strategies assumed to be consistent throughout the analysis period.

### 🛠️ Tools Used

- **MySQL**: The primary database management system used for querying and data analysis.

### 🎯 Objectives

In a competitive restaurant industry, understanding customer preferences and menu performance is crucial for maintaining profitability and customer satisfaction. This project aims to provide actionable insights that can help restaurant owners optimize their menu offerings, improve operational efficiency, and ultimately enhance customer experiences.

The primary objectives of this project are:
1. **Menu Performance Evaluation**: Assess the popularity and profitability of new menu items.
   
2. **Order Trends Analysis**: Identify purchasing patterns, peak order times, and the distribution of orders across different menu categories to assess the impact of the new menu on customer behaviour.
   
3. **Customer Preference Insights**: Analyse customer preferences and spending trends to understand the reception of the new menu items.

### 💻 SQL Queries
Here are the key SQL queries used for analysing the restaurant orders dataset:

**Query 1: Menu Performance Evaluation**
```sql
-- Count the number of unique menu items and calculate the average price per category
SELECT 
    category,
    COUNT(DISTINCT menu_item_id) AS num_items,  -- Number of unique menu items
    ROUND(AVG(price), 2) AS avg_price  -- Average price rounded to two decimal places
FROM 
    menu_items
GROUP BY 
    category 
ORDER BY 
    avg_price ASC;  -- Sort categories by average price in ascending order
```
**Purpose:**
This query analyses the variety and pricing distribution across menu categories. It provides insights into average pricing and menu composition, supporting decisions on pricing strategies, promotions, and overall menu performance to optimise customer satisfaction.

**Query 2: Menu Performance Evaluation**
```sql
-- Calculate the revenue for each menu category
SELECT 
    category,
    SUM(price) AS total_sales  -- Calculate total sales revenue
FROM 
    order_details 
INNER JOIN 
    menu_items ON order_details.item_id = menu_items.menu_item_id
GROUP BY 
    category
ORDER BY 
    total_sales DESC;  -- Order categories by total sales revenue in descending order
```
**Purpose**: 
This query analyses the sales revenue generated by each menu category. It offers insights into the financial performance of menu categories, identifying top revenue contributors. 

**Query 3: Order Trends Analysis** 
```sql
-- Identify the order volumes for each hour of the day to determine peak and off-peak times.
SELECT 
    DATE_FORMAT(order_time, '%H:00') AS order_hour,  -- Format the order time to hour intervals
    COUNT(*) AS num_orders 
FROM 
    order_details
GROUP BY 
    DATE_FORMAT(order_time, '%H:00')  -- Group the results by hour intervals
ORDER BY 
    num_orders DESC;  -- Order the results by the number of orders in descending order
```
**Purpose**: 
The query aims to identify the order volumes for each hour of the day, which helps in determining peak and off-peak times of customer activity

**Query 4: Order Trends Analysis**
```sql
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
) AS number_of_orders;
```
**Purpose**
This query helps in understanding the frequency of larger orders within the dataset, which can be valuable for operational planning, inventory management, and identifying patterns in customer purchasing behaviour.

**Query 5: Customer Insights**
```sql
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
```
**Purpose**: 
This query provides insights into the popularity of menu items by counting the number of orders for each item across different menu categories. It helps identify both the most popular and least popular items, which is crucial for understanding customer preferences and optimising menu offerings to enhance customer satisfaction and profitability.

**Query 6: Customer Insights**
```sql
-- Count the total number of orders per category from high-spending orders
SELECT 
    category,
    COUNT(item_id) AS number_of_orders
FROM 
    order_details
LEFT JOIN 
    menu_items ON order_details.item_id = menu_items.menu_item_id
WHERE 
    order_id IN (440, 2075, 1957, 330, 2675)
GROUP BY 
    category
ORDER BY 
    number_of_orders DESC;
```
**Purpose**:
The purpose of this query is to identify the popularity of different menu categories among high-spending customers. This analysis is crucial for identifying revenue-driving categories, allowing restaurants to prioritise and refine their offerings to enhance profitability and meet customer preferences effectively.

### 🌟 Summary of Key Findings

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

### 💡 Recommendations

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

### 🚧 Limitations

**Limited Timeframe:**

The analysis is based on data spanning three months from January to March 2023. This timeframe allows for a detailed examination of menu performance and customer preferences shortly after the introduction of a new menu. However, it may not capture seasonal variations or long-term trends in customer behavior and menu popularity. The absence of historical data before the new menu's introduction makes it challenging to compare menu performance over time and assess the sustained impact of the changes.

**Lack of Real-World Variability:**

The analysis relies on a fictional dataset sourced from [Maven Analytics: Data Playground](https://mavenanalytics.io/data-playground?page=4&pageSize=5), which may not fully reflect the complexities and nuances of real-world restaurant operations. Certain variables or factors influencing customer behavior, such as external economic conditions or local events, are not captured in the dataset, potentially limiting the depth of insights that can be derived.

**Lack of Direct Feedback:**
 
The analysis does not incorporate direct customer feedback or satisfaction metrics, which are crucial for understanding the qualitative aspects of menu performance and customer experience.

**Lack of Detailed Customer Data:**

 The dataset does not provide detailed customer demographics, such as age, gender, or income level, which could offer deeper insights into customer preferences and behavior.

### 🔗 Links
- [Dataset](https://mavenanalytics.io/data-playground?page=4&pageSize=5)
- [SQL Scripts]()
