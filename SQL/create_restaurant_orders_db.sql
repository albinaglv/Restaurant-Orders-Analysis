-- Step 1: Create a database
-- Drops the schema if it already exists to ensure no conflicts and creates a new schema for the restaurant orders database.


DROP SCHEMA IF EXISTS restaurant_orders_db;
CREATE SCHEMA restaurant_orders_db;
USE restaurant_orders_db;

-- Step 2: Create table structures for importing CSV files
-- Defines the necessary table structures to store data from the CSV files.

-- Table structure for `menu_items`
-- This table will store information about menu items.

CREATE TABLE menu_items (
  menu_item_id SMALLINT NOT NULL,
  item_name VARCHAR(45),
  category VARCHAR(45),
  price DECIMAL(5,2),
  PRIMARY KEY (menu_item_id)
);


-- Table structure for `order_details`
-- This table will store details about orders placed.

CREATE TABLE order_details (
  order_details_id SMALLINT NOT NULL,
  order_id SMALLINT NOT NULL,
  order_date DATE,
  order_time TIME,
  item_id SMALLINT,
  PRIMARY KEY (order_details_id)
);

-- Step 3: Import CSV files into tables
-- Use the Table Data Import Wizard to import data from two CSV files into the `menu_items` and `order_details` tables.
-- Ensure that the CSV files are formatted correctly and correspond to the table structures defined above.


