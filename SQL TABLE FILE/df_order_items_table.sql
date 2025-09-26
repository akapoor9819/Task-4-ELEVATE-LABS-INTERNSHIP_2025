DROP TABLE IF EXISTS df_order_items;

CREATE TABLE df_order_items(
order_id TEXT PRIMARY KEY,
product_id TEXT,
seller_id TEXT,
price FLOAT,
shipping_charges FLOAT
);