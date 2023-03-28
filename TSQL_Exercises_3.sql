USE TSQLV4

-- Exercise 1
SELECT orderid, orderdate, custid, empid
FROM Sales.Orders
WHERE orderdate IN (
    SELECT MAX(o.orderdate)
    FROM Sales.Orders AS o
)
