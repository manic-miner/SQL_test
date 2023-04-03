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
);

-- Exercise 5
SELECT custid, orderid, orderdate, empid
FROM Sales.Orders o1
WHERE orderdate IN (
    SELECT MAX(orderdate) FROM Sales.Orders o2
    WHERE o1.custid = o2.custid
);

-- Exercise 6
SELECT custid, companyname
FROM Sales.Customers AS c
WHERE EXISTS (
    SELECT *
    FROM Sales.Orders AS o
    WHERE orderdate LIKE '%2015%'
    AND o.custid = c.custid
)
AND NOT EXISTS (
    SELECT *
    FROM Sales.Orders AS o
    WHERE orderdate LIKE '%2016%'
    AND o.custid = c.custid
);

--