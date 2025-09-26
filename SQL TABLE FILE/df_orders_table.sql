DROP TABLE IF EXISTS df_orders;

CREATE TABLE df_orders(
order_id TEXT PRIMARY KEY,
customer_id TEXT,
order_status VARCHAR(30),
order_purchase_timestamp TIMESTAMP,
order_approved_at TIMESTAMP,
order_delivered_timestamp TIMESTAMP,
order_estimated_delivery_date DATE
);