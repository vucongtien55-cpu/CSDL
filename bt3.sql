CREATE TABLE sales.customers (
    customer_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR NOT NULL UNIQUE,
    phone VARCHAR
);

CREATE TABLE sales.products (
    product_id SERIAL PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    price REAL NOT NULL,
    stock_quantity INTEGER NOT NULL
);

CREATE TABLE sales.orders (
    order_id SERIAL PRIMARY KEY,
    customer_id INTEGER REFERENCES sales.customers(customer_id),
    order_date DATE NOT NULL
);

CREATE TABLE sales.order_items (
    order_item_id SERIAL PRIMARY KEY,
    order_id INTEGER REFERENCES sales.orders(order_id),
    product_id INTEGER REFERENCES sales.products(product_id),
    quantity INTEGER NOT NULL CHECK (quantity >= 1)
);
-- xem danh sach database 
SELECT datname FROM pg_database;

--xem danh sach schema
SELECT schema_name
FROM information_schema.schemata;

