-- CTE example

WITH cte_sales_amounts (staff, sales, year) AS (
    SELECT    
        first_name + ' ' + last_name, 
        SUM(quantity * list_price * (1 - discount)),
        YEAR(order_date)
    FROM sales.orders o
    INNER JOIN sales.order_items i ON i.order_id = o.order_id
    INNER JOIN sales.staffs s ON s.staff_id = o.staff_id
    GROUP BY 
        first_name + ' ' + last_name,
        year(order_date)
)
SELECT
    staff, 
    sales
FROM cte_sales_amounts
WHERE year = 2018
ORDER BY sales DESC;


-- This subquery shows number of sales by staff member, without NULL results and in descending order
-- It works but is too long and too complicated because subquery is copied three times

SELECT 
first_name + ' ' + last_name AS 'Name',
(
    SELECT COUNT(order_id) order_count
    FROM sales.orders o
    WHERE o.staff_id = s.staff_id
    AND order_status = 4
    GROUP BY staff_id
) AS 'Total sales'
FROM
sales.staffs s
WHERE
(
    SELECT COUNT(order_id) order_count
    FROM sales.orders o
    WHERE o.staff_id = s.staff_id
    AND order_status = 4
    GROUP BY staff_id
) >= 0
ORDER BY
(
    SELECT COUNT(order_id) order_count
    FROM sales.orders o
    WHERE o.staff_id = s.staff_id
    AND order_status = 4
    GROUP BY staff_id
) DESC

-- same query but with CTE
WITH cte_total_sales (staff, sales) AS (
SELECT 
first_name + ' ' + last_name AS 'Name',
(
    SELECT COUNT(o.order_id) order_count
    FROM sales.orders o
    WHERE o.staff_id = s.staff_id
    AND order_status = 4
    GROUP BY staff_id
)
FROM sales.staffs s
)
SELECT staff, sales
FROM cte_total_sales
WHERE sales >= 0
ORDER BY sales DESC;
-- much better

-- recursive CTE example
WITH cte_numbers(n, weekday) 
AS (
    SELECT 
        0, 
        DATENAME(DW, 0)
    UNION ALL
    SELECT    
        n + 1, 
        DATENAME(DW, n + 1)
    FROM cte_numbers
    WHERE n < 6
)
SELECT weekday
FROM cte_numbers;

--
SELECT count(order_id)
FROM sales.orders

SELECT SUM(list_price)
FROM sales.order_items
WHERE order_id = 1


-- COALESCE example
SELECT 
    first_name, 
    last_name, 
    COALESCE(phone,'N/A') phone, --COALESCE replaces any NULL with N/A
    email
FROM 
    sales.customers
ORDER BY 
    first_name, 
    last_name;

-- CASE examples
SELECT    
    CASE order_status
        WHEN 1 THEN 'Pending'
        WHEN 2 THEN 'Processing'
        WHEN 3 THEN 'Rejected'
        WHEN 4 THEN 'Completed'
    END AS order_status, 
    COUNT(order_id) order_count
FROM    
    sales.orders
WHERE 
    YEAR(order_date) = 2018
GROUP BY 
    order_status;

--
SELECT    
    SUM(CASE
            WHEN order_status = 1
            THEN 1
            ELSE 0
        END) AS 'Pending', 
    SUM(CASE
            WHEN order_status = 2
            THEN 1
            ELSE 0
        END) AS 'Processing', 
    SUM(CASE
            WHEN order_status = 3
            THEN 1
            ELSE 0
        END) AS 'Rejected', 
    SUM(CASE
            WHEN order_status = 4
            THEN 1
            ELSE 0
        END) AS 'Completed', 
    COUNT(*) AS Total
FROM    
    sales.orders
WHERE 
    YEAR(order_date) = 2018;