-- Food Delivery Analytics | SQL Analysis
-- Designed for PostgreSQL

-- 01. Overall KPIs
SELECT
    COUNT(*) FILTER (WHERE order_status = 'Delivered') AS delivered_orders,
    COUNT(*) AS total_orders,
    ROUND(SUM(total_amount) FILTER (WHERE order_status = 'Delivered'), 2) AS revenue,
    ROUND(AVG(total_amount) FILTER (WHERE order_status = 'Delivered'), 2) AS avg_order_value,
    ROUND(AVG(delivery_time_minutes) FILTER (WHERE order_status = 'Delivered'), 2) AS avg_delivery_time,
    ROUND(100.0 * COUNT(*) FILTER (WHERE order_status = 'Cancelled') / COUNT(*), 2) AS cancellation_rate_pct
FROM orders;

-- 02. Monthly revenue and orders
SELECT
    DATE_TRUNC('month', order_datetime)::date AS month,
    COUNT(*) FILTER (WHERE order_status = 'Delivered') AS delivered_orders,
    ROUND(SUM(total_amount) FILTER (WHERE order_status = 'Delivered'), 2) AS revenue
FROM orders
GROUP BY 1
ORDER BY 1;

-- 03. Revenue by city
SELECT
    c.city,
    COUNT(*) FILTER (WHERE o.order_status = 'Delivered') AS orders,
    ROUND(SUM(o.total_amount) FILTER (WHERE o.order_status = 'Delivered'), 2) AS revenue,
    ROUND(AVG(o.total_amount) FILTER (WHERE o.order_status = 'Delivered'), 2) AS avg_order_value
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
GROUP BY c.city
ORDER BY revenue DESC;

-- 04. Top restaurants by revenue
SELECT
    r.restaurant_name,
    r.city,
    r.cuisine,
    COUNT(o.order_id) AS delivered_orders,
    ROUND(SUM(o.total_amount), 2) AS revenue
FROM orders o
JOIN restaurants r ON o.restaurant_id = r.restaurant_id
WHERE o.order_status = 'Delivered'
GROUP BY r.restaurant_id, r.restaurant_name, r.city, r.cuisine
ORDER BY revenue DESC
LIMIT 10;

-- 05. Cuisine performance
SELECT
    r.cuisine,
    COUNT(o.order_id) AS delivered_orders,
    ROUND(SUM(o.total_amount), 2) AS revenue,
    ROUND(AVG(o.rating), 2) AS avg_rating
FROM orders o
JOIN restaurants r ON o.restaurant_id = r.restaurant_id
WHERE o.order_status = 'Delivered'
GROUP BY r.cuisine
ORDER BY revenue DESC;

-- 06. Peak ordering hours
SELECT
    EXTRACT(HOUR FROM order_datetime) AS order_hour,
    COUNT(*) AS total_orders
FROM orders
GROUP BY 1
ORDER BY total_orders DESC;

-- 07. Customer order frequency
SELECT
    customer_id,
    COUNT(*) FILTER (WHERE order_status = 'Delivered') AS delivered_orders,
    ROUND(SUM(total_amount) FILTER (WHERE order_status = 'Delivered'), 2) AS customer_revenue
FROM orders
GROUP BY customer_id
ORDER BY delivered_orders DESC, customer_revenue DESC
LIMIT 20;

-- 08. Repeat customer rate
WITH customer_orders AS (
    SELECT customer_id,
           COUNT(*) FILTER (WHERE order_status = 'Delivered') AS delivered_orders
    FROM orders
    GROUP BY customer_id
)
SELECT
    COUNT(*) AS customers,
    COUNT(*) FILTER (WHERE delivered_orders >= 2) AS repeat_customers,
    ROUND(100.0 * COUNT(*) FILTER (WHERE delivered_orders >= 2) / COUNT(*), 2) AS repeat_customer_rate_pct
FROM customer_orders;

-- 09. Cancellation analysis by city
SELECT
    c.city,
    COUNT(*) AS total_orders,
    COUNT(*) FILTER (WHERE o.order_status = 'Cancelled') AS cancelled_orders,
    ROUND(100.0 * COUNT(*) FILTER (WHERE o.order_status = 'Cancelled') / COUNT(*), 2) AS cancellation_rate_pct
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
GROUP BY c.city
ORDER BY cancellation_rate_pct DESC;

-- 10. Delivery performance
SELECT
    r.city,
    ROUND(AVG(o.delivery_time_minutes), 2) AS avg_delivery_minutes,
    ROUND(AVG(o.rating), 2) AS avg_rating
FROM orders o
JOIN restaurants r ON o.restaurant_id = r.restaurant_id
WHERE o.order_status = 'Delivered'
GROUP BY r.city
ORDER BY avg_delivery_minutes;

-- 11. Rating distribution
SELECT rating, COUNT(*) AS rating_count
FROM orders
WHERE order_status = 'Delivered' AND rating IS NOT NULL
GROUP BY rating
ORDER BY rating;

-- 12. Best-selling food items by quantity
SELECT
    m.item_name,
    m.cuisine,
    SUM(oi.quantity) AS units_sold,
    ROUND(SUM(oi.quantity * oi.unit_price), 2) AS item_sales
FROM order_items oi
JOIN orders o ON oi.order_id = o.order_id
JOIN menu_items m ON oi.item_id = m.item_id
WHERE o.order_status = 'Delivered'
GROUP BY m.item_id, m.item_name, m.cuisine
ORDER BY units_sold DESC
LIMIT 15;

-- 13. Average order value by payment method
SELECT
    payment_method,
    COUNT(*) AS delivered_orders,
    ROUND(AVG(total_amount), 2) AS avg_order_value,
    ROUND(SUM(total_amount), 2) AS revenue
FROM orders
WHERE order_status = 'Delivered'
GROUP BY payment_method
ORDER BY revenue DESC;

-- 14. High-value customers
SELECT
    c.customer_id,
    c.customer_name,
    c.city,
    COUNT(o.order_id) AS orders,
    ROUND(SUM(o.total_amount), 2) AS lifetime_value
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
WHERE o.order_status = 'Delivered'
GROUP BY c.customer_id, c.customer_name, c.city
HAVING SUM(o.total_amount) > 10000
ORDER BY lifetime_value DESC;

-- 15. Restaurant ranking within each city
WITH restaurant_revenue AS (
    SELECT
        r.restaurant_id,
        r.restaurant_name,
        r.city,
        SUM(o.total_amount) AS revenue
    FROM restaurants r
    JOIN orders o ON r.restaurant_id = o.restaurant_id
    WHERE o.order_status = 'Delivered'
    GROUP BY r.restaurant_id, r.restaurant_name, r.city
)
SELECT *,
       DENSE_RANK() OVER (PARTITION BY city ORDER BY revenue DESC) AS city_rank
FROM restaurant_revenue
ORDER BY city, city_rank;

-- 16. Month-over-month revenue growth
WITH monthly AS (
    SELECT
        DATE_TRUNC('month', order_datetime)::date AS month,
        SUM(total_amount) FILTER (WHERE order_status = 'Delivered') AS revenue
    FROM orders
    GROUP BY 1
)
SELECT
    month,
    ROUND(revenue, 2) AS revenue,
    ROUND(LAG(revenue) OVER (ORDER BY month), 2) AS previous_month_revenue,
    ROUND(
        100.0 * (revenue - LAG(revenue) OVER (ORDER BY month))
        / NULLIF(LAG(revenue) OVER (ORDER BY month), 0), 2
    ) AS mom_growth_pct
FROM monthly
ORDER BY month;

-- 17. Customer segmentation
WITH spend AS (
    SELECT
        customer_id,
        COUNT(*) FILTER (WHERE order_status = 'Delivered') AS orders,
        SUM(total_amount) FILTER (WHERE order_status = 'Delivered') AS revenue
    FROM orders
    GROUP BY customer_id
)
SELECT
    customer_id,
    orders,
    ROUND(revenue, 2) AS revenue,
    CASE
        WHEN revenue >= 15000 THEN 'High Value'
        WHEN revenue >= 7000 THEN 'Medium Value'
        ELSE 'Low Value'
    END AS customer_segment
FROM spend
ORDER BY revenue DESC;

-- 18. Discount impact
SELECT
    CASE WHEN discount > 0 THEN 'Discount Used' ELSE 'No Discount' END AS discount_group,
    COUNT(*) FILTER (WHERE order_status = 'Delivered') AS orders,
    ROUND(AVG(total_amount) FILTER (WHERE order_status = 'Delivered'), 2) AS avg_order_value
FROM orders
GROUP BY 1;

-- 19. Weekend vs weekday performance
SELECT
    CASE
        WHEN EXTRACT(ISODOW FROM order_datetime) IN (6,7) THEN 'Weekend'
        ELSE 'Weekday'
    END AS day_type,
    COUNT(*) FILTER (WHERE order_status = 'Delivered') AS orders,
    ROUND(SUM(total_amount) FILTER (WHERE order_status = 'Delivered'), 2) AS revenue
FROM orders
GROUP BY 1;

-- 20. Restaurants with strong ratings and high order volume
SELECT
    r.restaurant_name,
    r.city,
    COUNT(o.order_id) AS delivered_orders,
    ROUND(AVG(o.rating), 2) AS avg_rating,
    ROUND(SUM(o.total_amount), 2) AS revenue
FROM restaurants r
JOIN orders o ON r.restaurant_id = o.restaurant_id
WHERE o.order_status = 'Delivered'
GROUP BY r.restaurant_id, r.restaurant_name, r.city
HAVING COUNT(o.order_id) >= 20
ORDER BY avg_rating DESC, revenue DESC;
