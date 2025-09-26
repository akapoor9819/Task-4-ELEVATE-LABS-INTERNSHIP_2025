DROP TABLE IF EXISTS df_customers;

CREATE TABLE df_customers(
customer_id TEXT,
customer_zip_code_prefix INT,
customer_city VARCHAR(60),
customer_state VARCHAR(5)
);