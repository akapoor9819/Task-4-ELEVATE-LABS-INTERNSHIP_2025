DROP TABLE IF EXISTS df_payments;

CREATE TABLE df_payments(
order_id TEXT PRIMARY KEY,
payment_sequential INT,
payment_type VARCHAR(20),
payment_installments INT,
payment_value FLOAT
);