/* ============================================================
   PROJECT 3: SQL DATA ANALYSIS
   DecodeLabs Industrial Training Kit - Batch 2026
   Dataset: orders (1,200 rows, 14 columns)
   Author : Meem (Fatema Kamal)
   ============================================================
   Table schema (loaded from Dataset_for_Data_Analytics.xlsx)
   ------------------------------------------------------------
   OrderID          TEXT     e.g. ORD200000
   Date             TEXT     YYYY-MM-DD
   CustomerID       TEXT     e.g. C72649
   Product          TEXT     Monitor, Phone, Tablet, Chair,
                              Printer, Laptop, Desk
   Quantity         INTEGER
   UnitPrice        REAL
   ShippingAddress  TEXT
   PaymentMethod    TEXT     Debit Card, Online, Credit Card,
                              Gift Card, Cash
   OrderStatus      TEXT     Shipped, Cancelled, Returned,
                              Delivered, Pending
   TrackingNumber   TEXT
   ItemsInCart      INTEGER
   CouponCode       TEXT     SAVE10, FREESHIP, WINTER15, NULL
   ReferralSource   TEXT     Instagram, Referral, Email,
                              Facebook, Google
   TotalPrice       REAL
   ============================================================ */


/* ------------------------------------------------------------
   SECTION 1: BASIC SELECT QUERIES
   ------------------------------------------------------------ */

-- 1.1 Preview the raw data
SELECT *
FROM orders
LIMIT 10;

-- 1.2 Select specific columns with clean aliases
SELECT
    OrderID         AS order_id,
    Product         AS product,
    Quantity        AS qty,
    TotalPrice      AS total_price
FROM orders;

-- 1.3 Distinct product list
SELECT DISTINCT Product
FROM orders;

-- 1.4 Distinct order statuses
SELECT DISTINCT OrderStatus
FROM orders;


/* ------------------------------------------------------------
   SECTION 2: FILTERING WITH WHERE
   ------------------------------------------------------------ */

-- 2.1 Equality filter: all Laptop orders
SELECT OrderID, Product, Quantity, TotalPrice
FROM orders
WHERE Product = 'Laptop';

-- 2.2 Comparison filter: high-value orders
SELECT OrderID, Product, TotalPrice
FROM orders
WHERE TotalPrice >= 2000
ORDER BY TotalPrice DESC;

-- 2.3 Multiple conditions (AND): delivered credit card orders
SELECT OrderID, Product, PaymentMethod, OrderStatus, TotalPrice
FROM orders
WHERE OrderStatus = 'Delivered'
  AND PaymentMethod = 'Credit Card';

-- 2.4 Multiple conditions (OR): cancelled or returned orders
SELECT OrderID, Product, OrderStatus, TotalPrice
FROM orders
WHERE OrderStatus = 'Cancelled' OR OrderStatus = 'Returned';

-- 2.5 Pattern matching with LIKE: shipping addresses on Main St
SELECT OrderID, ShippingAddress
FROM orders
WHERE ShippingAddress LIKE '%Main St%'
LIMIT 20;

-- 2.6 NULL filter: orders with no coupon applied
SELECT OrderID, Product, CouponCode, TotalPrice
FROM orders
WHERE CouponCode IS NULL;

-- 2.7 NOT NULL filter: orders where a coupon WAS applied
SELECT OrderID, Product, CouponCode, TotalPrice
FROM orders
WHERE CouponCode IS NOT NULL;

-- 2.8 Range filter with BETWEEN
SELECT OrderID, Date, TotalPrice
FROM orders
WHERE Date BETWEEN '2024-01-01' AND '2024-12-31';

-- 2.9 Set membership with IN
SELECT OrderID, Product, TotalPrice
FROM orders
WHERE Product IN ('Laptop', 'Phone', 'Tablet');


/* ------------------------------------------------------------
   SECTION 3: SORTING WITH ORDER BY
   ------------------------------------------------------------ */

-- 3.1 Highest value orders first
SELECT OrderID, Product, TotalPrice
FROM orders
ORDER BY TotalPrice DESC
LIMIT 10;

-- 3.2 Sort by multiple columns
SELECT OrderID, Product, OrderStatus, TotalPrice
FROM orders
ORDER BY Product ASC, TotalPrice DESC;

-- 3.3 Sort using a computed alias (only legal AFTER SELECT executes)
SELECT
    OrderID,
    Quantity,
    UnitPrice,
    ROUND(Quantity * UnitPrice, 2) AS calculated_total
FROM orders
ORDER BY calculated_total DESC
LIMIT 10;


/* ------------------------------------------------------------
   SECTION 4: GROUPING + AGGREGATIONS
   (COUNT, SUM, AVG, MIN, MAX)
   ------------------------------------------------------------ */

-- 4.1 Total number of orders per product
SELECT
    Product,
    COUNT(*) AS order_count
FROM orders
GROUP BY Product
ORDER BY order_count DESC;

-- 4.2 Total revenue per product
SELECT
    Product,
    SUM(TotalPrice) AS total_revenue
FROM orders
GROUP BY Product
ORDER BY total_revenue DESC;

-- 4.3 Average order value per payment method
SELECT
    PaymentMethod,
    ROUND(AVG(TotalPrice), 2) AS avg_order_value,
    COUNT(*)                  AS num_orders
FROM orders
GROUP BY PaymentMethod
ORDER BY avg_order_value DESC;

-- 4.4 Orders and revenue by status
SELECT
    OrderStatus,
    COUNT(*)               AS num_orders,
    SUM(TotalPrice)         AS total_revenue,
    ROUND(AVG(TotalPrice),2) AS avg_order_value
FROM orders
GROUP BY OrderStatus
ORDER BY num_orders DESC;

-- 4.5 Min / max order value per product
SELECT
    Product,
    MIN(TotalPrice) AS min_order_value,
    MAX(TotalPrice) AS max_order_value
FROM orders
GROUP BY Product;

-- 4.6 Revenue by referral source, filtered to delivered orders only
SELECT
    ReferralSource,
    COUNT(*)         AS delivered_orders,
    SUM(TotalPrice)   AS revenue_from_delivered
FROM orders
WHERE OrderStatus = 'Delivered'
GROUP BY ReferralSource
ORDER BY revenue_from_delivered DESC;

-- 4.7 Monthly order volume and revenue (uses SQLite date functions)
SELECT
    strftime('%Y-%m', Date) AS order_month,
    COUNT(*)                 AS num_orders,
    SUM(TotalPrice)           AS monthly_revenue
FROM orders
GROUP BY order_month
ORDER BY order_month;


/* ------------------------------------------------------------
   SECTION 5: FILTERING GROUPS WITH HAVING
   ------------------------------------------------------------ */

-- 5.1 Products that generated more than $150,000 in total revenue
SELECT
    Product,
    SUM(TotalPrice) AS total_revenue
FROM orders
GROUP BY Product
HAVING SUM(TotalPrice) > 150000
ORDER BY total_revenue DESC;

-- 5.2 Payment methods used in more than 200 orders
SELECT
    PaymentMethod,
    COUNT(*) AS num_orders
FROM orders
GROUP BY PaymentMethod
HAVING COUNT(*) > 200
ORDER BY num_orders DESC;

-- 5.3 Referral sources with an average order value above the overall average
SELECT
    ReferralSource,
    ROUND(AVG(TotalPrice), 2) AS avg_order_value
FROM orders
GROUP BY ReferralSource
HAVING AVG(TotalPrice) > (SELECT AVG(TotalPrice) FROM orders)
ORDER BY avg_order_value DESC;


/* ------------------------------------------------------------
   SECTION 6: ADVANCED / BONUS ANALYSIS
   (percentage contribution, coupon impact, customer insights)
   ------------------------------------------------------------ */

-- 6.1 Percentage contribution of each product to total revenue
SELECT
    Product,
    SUM(TotalPrice) AS product_revenue,
    ROUND(
        100.0 * SUM(TotalPrice) / (SELECT SUM(TotalPrice) FROM orders), 2
    ) AS pct_of_total_revenue
FROM orders
GROUP BY Product
ORDER BY pct_of_total_revenue DESC;

-- 6.2 Percentage of orders by status (order-mix funnel)
SELECT
    OrderStatus,
    COUNT(*) AS num_orders,
    ROUND(100.0 * COUNT(*) / (SELECT COUNT(*) FROM orders), 2) AS pct_of_orders
FROM orders
GROUP BY OrderStatus
ORDER BY pct_of_orders DESC;

-- 6.3 Coupon impact: average order value with vs. without a coupon
SELECT
    CASE WHEN CouponCode IS NULL THEN 'No Coupon' ELSE CouponCode END AS coupon_group,
    COUNT(*)                  AS num_orders,
    ROUND(AVG(TotalPrice), 2) AS avg_order_value
FROM orders
GROUP BY coupon_group
ORDER BY avg_order_value DESC;

-- 6.4 Top 10 customers by total spend
SELECT
    CustomerID,
    COUNT(*)         AS num_orders,
    SUM(TotalPrice)   AS total_spend
FROM orders
GROUP BY CustomerID
ORDER BY total_spend DESC
LIMIT 10;

-- 6.5 Cancellation / return rate by product (risk analysis)
SELECT
    Product,
    COUNT(*) AS total_orders,
    SUM(CASE WHEN OrderStatus IN ('Cancelled','Returned') THEN 1 ELSE 0 END) AS problem_orders,
    ROUND(
        100.0 * SUM(CASE WHEN OrderStatus IN ('Cancelled','Returned') THEN 1 ELSE 0 END)
        / COUNT(*), 2
    ) AS problem_rate_pct
FROM orders
GROUP BY Product
ORDER BY problem_rate_pct DESC;

-- 6.6 Best performing referral source by conversion to "Delivered"
SELECT
    ReferralSource,
    COUNT(*) AS total_orders,
    SUM(CASE WHEN OrderStatus = 'Delivered' THEN 1 ELSE 0 END) AS delivered_orders,
    ROUND(
        100.0 * SUM(CASE WHEN OrderStatus = 'Delivered' THEN 1 ELSE 0 END)
        / COUNT(*), 2
    ) AS delivery_rate_pct
FROM orders
GROUP BY ReferralSource
ORDER BY delivery_rate_pct DESC;

/* ============================================================
   END OF SOLUTION
   ============================================================ */
