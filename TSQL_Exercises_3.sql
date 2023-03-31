USE TSQLV4

-- Exercise 1
SELECT orderid, orderdate, custid, empid
FROM Sales.Orders
WHERE orderdate IN (
    SELECT MAX(o.orderdate)
    FROM Sales.Orders AS o
);

-- Exercise 2
SELECT custid, orderid, orderdate, empid
FROM Sales.Orders AS o
WHERE o.custid IN (
    SELECT TOP 1 WITH TIES custid
    FROM Sales.Orders
    GROUP BY custid
    ORDER BY COUNT(*) DESC
);

-- Exercise 3



-- Exercise 4