-- CTE example

WITH cte_sales_amounts (staff, sales, year) AS (
    SELECT    
        first_name + ' ' + last_name, 
        SUM(quantity * list_price * (1 - discount)),
        YEAR(order_date)
    FROM    
        sales.orders o
    INNER JOIN sales.order_items i ON i.order_id = o.order_id
    INNER JOIN sales.staffs s ON s.staff_id = o.staff_id
    GROUP BY 
        first_name + ' ' + last_name,
        year(order_date)
)
SELECT
    staff, 
    sales
FROM 
    cte_sales_amounts
WHERE
    year = 2018
ORDER BY
    sales DESC;

SELECT * FROM sales.orders

--
-- This subquery counts number of orders/sales by staff member 
-- it's included in the results, staff that have done no sales (NULL) is filtered out
-- and it's sorted by number of sales in descending order
-- The query is quite long because subquery is copied three times
-- I should try to use CTE here as well

SELECT 
first_name + ' ' + last_name AS 'Name',
(
    SELECT 
	COUNT(order_id) order_count
    FROM 
	sales.orders o
    WHERE
    o.staff_id = s.staff_id
    GROUP BY 
	staff_id
) AS 'Total sales'
FROM
sales.staffs s
WHERE
(
    SELECT 
	COUNT(order_id) order_count
    FROM 
	sales.orders o
    WHERE
    o.staff_id = s.staff_id
    GROUP BY 
	staff_id
) >= 0
ORDER BY
(
    SELECT 
	COUNT(order_id) order_count
    FROM 
	sales.orders o
    WHERE
    o.staff_id = s.staff_id
    GROUP BY 
	staff_id
) DESC

--

