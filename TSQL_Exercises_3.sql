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
SELECT empid, firstname, lastname
FROM HR.Employees
WHERE empid NOT IN (
    SELECT empid FROM Sales.Orders
    WHERE orderdate >= '2016-05-01'
);

-- Exercise 4
SELECT DISTINCT country
FROM Sales.Customers
WHERE country NOT IN (
    SELECT country
    FROM HR.Employees
)