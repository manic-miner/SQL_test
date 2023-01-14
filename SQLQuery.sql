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
    GROUP BY staff_id
) AS 'Total sales'
FROM
sales.staffs s
WHERE
(
    SELECT COUNT(order_id) order_count
    FROM sales.orders o
    WHERE o.staff_id = s.staff_id
    GROUP BY staff_id
) >= 0
ORDER BY
(
    SELECT COUNT(order_id) order_count
    FROM sales.orders o
    WHERE o.staff_id = s.staff_id
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

