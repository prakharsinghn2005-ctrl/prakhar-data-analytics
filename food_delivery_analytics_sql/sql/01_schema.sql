-- Food Delivery Analytics | PostgreSQL
-- Create tables in this order.

DROP TABLE IF EXISTS order_items, orders, menu_items, restaurants, customers CASCADE;

CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100),
    city VARCHAR(50),
    area VARCHAR(100),
    signup_date DATE,
    gender VARCHAR(20)
);

CREATE TABLE restaurants (
    restaurant_id INT PRIMARY KEY,
    restaurant_name VARCHAR(100),
    city VARCHAR(50),
    area VARCHAR(100),
    cuisine VARCHAR(50),
    price_segment VARCHAR(30)
);

CREATE TABLE menu_items (
    item_id INT PRIMARY KEY,
    restaurant_id INT REFERENCES restaurants(restaurant_id),
    item_name VARCHAR(100),
    cuisine VARCHAR(50),
    price DECIMAL(10,2)
);

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT REFERENCES customers(customer_id),
    restaurant_id INT REFERENCES restaurants(restaurant_id),
    order_datetime TIMESTAMP,
    order_status VARCHAR(30),
    payment_method VARCHAR(30),
    delivery_time_minutes INT,
    rating INT,
    subtotal DECIMAL(10,2),
    delivery_fee DECIMAL(10,2),
    discount DECIMAL(10,2),
    total_amount DECIMAL(10,2)
);

CREATE TABLE order_items (
    order_id INT REFERENCES orders(order_id),
    item_id INT REFERENCES menu_items(item_id),
    quantity INT,
    unit_price DECIMAL(10,2),
    PRIMARY KEY (order_id, item_id)
);
