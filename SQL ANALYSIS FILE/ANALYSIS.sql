SELECT * FROM df_customers
LIMIT 10;

SELECT * FROM df_order_items
LIMIT 10;

SELECT * FROM df_orders
LIMIT 10;

SELECT * FROM df_payments
LIMIT 10;

SELECT * FROM df_products
LIMIT 10;


-- ----------------------------1. Customers Count by City---------------------------------
CREATE VIEW customers_count_by_city AS
SELECT
	customer_city,
	COUNT(customer_id) AS total_count_of_customers
FROM df_customers
GROUP BY customer_city
ORDER BY total_count_of_customers DESC;

SELECT * FROM customers_count_by_city;


-- ---------------------2. Orders with Customer Names (INNER JOIN)-----------------------
CREATE VIEW orders_with_customer_names AS
SELECT
	o.order_id,
	c.customer_id,
	c.customer_city
FROM df_orders o
JOIN df_customers c ON o.customer_id = c.customer_id;

SELECT * FROM orders_with_customer_names;


-- ---------------------3. Total Sales per Customers (Multiple JOINS)---------------------
CREATE VIEW total_sales_per_customers AS
SELECT
	c.customer_id,
	c.customer_city,
	SUM(oi.price * oi.shipping_charges) AS total_sales
FROM df_customers c
JOIN df_orders o ON o.customer_id = c.customer_id
JOIN df_order_items oi ON oi.order_id = o.order_id
GROUP BY c.customer_id, c.customer_city
ORDER BY total_sales DESC;

SELECT * FROM total_sales_per_customers;


-- ------------------------------4. Average Payment per Order----------------------------
CREATE VIEW average_payment_per_order AS
SELECT
	AVG(payment_value) AS avg_payment
FROM df_payments;

SELECT * FROM average_payment_per_order;


-- ---------------------5. Top Selling Products (JOIN & Aggregation)--------------------
CREATE VIEW top_selling_products AS
SELECT
	p.product_id,
	p.product_category_name,
	SUM(oi.price) AS total_revenue
FROM df_products p
JOIN df_order_items oi ON oi.product_id = p.product_id
GROUP BY p.product_id, p.product_category_name
ORDER BY total_revenue DESC
LIMIT 10;

SELECT * FROM top_selling_products;


-- ---------------------------6. Orders Placed in a Date Range--------------------------
CREATE VIEW orders_placed_between_date_range AS
SELECT
	COUNT(order_id) AS orders_count
FROM df_orders
WHERE order_purchase_timestamp BETWEEN '2018-01-01'
AND '2018-12-31';

SELECT * FROM orders_placed_between_date_range;


-- ----------------------------7. Payment Type Distribution------------------------------
CREATE VIEW payment_type_distribution AS
SELECT
	payment_type,
	COUNT(order_id) AS payment_count
FROM df_payments
GROUP BY payment_type
ORDER BY payment_count DESC;

SELECT * FROM payment_type_distribution;


-- ---------------------------8. Delivered vs Not Delivered Orders-----------------------
CREATE VIEW delivered_vs_not_delivered_orders AS
SELECT
	order_status,
	COUNT(order_id) AS num_of_orders
FROM df_orders
GROUP BY order_status
ORDER BY num_of_orders DESC;

SELECT * FROM delivered_vs_not_delivered_orders;


-- ---------------------9. Customers with No Orders (LEFT JOIN)--------------------------
CREATE VIEW customers_with_no_orders AS
SELECT
	c.customer_id,
	c.customer_city,
	COUNT(o.order_id) AS total_orders
FROM df_customers c
LEFT JOIN df_orders o ON o.customer_id = c.customer_id
GROUP BY c.customer_id, c.customer_city
HAVING COUNT(o.order_id) = 0;

SELECT * FROM customers_with_no_orders;


-- -----------------------------10. Monthly Order Trend---------------------------------
CREATE VIEW monthly_order_trend AS
SELECT
	EXTRACT(YEAR FROM order_purchase_timestamp) AS year,
	EXTRACT(MONTH FROM order_purchase_timestamp) AS month,
	COUNT(order_id) AS orders_count
FROM df_orders
GROUP BY year, month
ORDER BY orders_count DESC;

SELECT * FROM monthly_order_trend;


-- ----------------------------11. Average Delivery Days--------------------------------
CREATE VIEW avg_delivery_days AS
SELECT
	AVG(order_delivered_timestamp - order_purchase_timestamp) AS avg_delivery_time
FROM df_orders
WHERE order_delivered_timestamp IS NOT NULL;

SELECT * FROM avg_delivery_days;


-- -----------------------------12. Payment type Popularity----------------------------
CREATE VIEW payment_type_popularity AS
SELECT
	payment_type,
	COUNT(payment_type) AS payment_count
FROM df_payments
GROUP BY payment_type
ORDER BY payment_count DESC;

SELECT * FROM payment_type_popularity;


-- -----------------------------13. Top Seller Analysis---------------------------------
CREATE VIEW top_seller AS
SELECT
	seller_id,
	SUM(price) AS total_revenue
FROM df_order_items
GROUP BY seller_id
ORDER BY total_revenue DESC
LIMIT 5;

SELECT * FROM top_seller;


-- -------------------------14. Most Sold Product Category------------------------------
CREATE VIEW most_sold_product_category AS
SELECT
	product_category_name,
	COUNT(product_id) AS product_sold
FROM df_products
GROUP BY product_category_name
ORDER BY product_sold DESC
LIMIT 5;

SELECT * FROM most_sold_product_category;


-- ----------------------15. Total Shipping Charges by City-----------------------------
CREATE VIEW total_shipping_charges_by_cities AS
SELECT
	c.customer_city,
	SUM(oi.shipping_charges) AS total_shipping
FROM df_customers c
JOIN df_orders o ON c.customer_id = o.customer_id
JOIN df_order_items oi ON oi.order_id = o.order_id
GROUP BY c.customer_city
ORDER BY total_shipping DESC;

SELECT * FROM total_shipping_charges_by_cities;


-- -------------------------16. Fastest Delivery Cities--------------------------------
CREATE VIEW fastest_delivery_cities AS
SELECT
	customer_city,
	AVG(order_delivered_timestamp - order_purchase_timestamp) AS avg_days
FROM df_orders o
JOIN df_customers c ON o.customer_id = c.customer_id
WHERE order_delivered_timestamp IS NOT NULL
GROUP BY customer_city
ORDER BY avg_days ASC
LIMIT 10;

SELECT * FROM fastest_delivery_cities;