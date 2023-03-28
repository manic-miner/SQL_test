USE TSQLV4

-- Exercise 3
SELECT  c.custid,
        COUNT(DISTINCT o.orderid) AS numorders,
        SUM(d.qty) AS totalqty
FROM Sales.Customers c
INNER JOIN Sales.Orders o
ON c.custid = o.custid
INNER JOIN Sales.OrderDetails d
ON o.orderid = d.orderid
WHERE c.country = 'USA'
GROUP BY c.custid;

-- Exercise 4
SELECT c.custid, c.companyname, o.orderid, o.orderdate
FROM Sales.Customers c
FULL JOIN Sales.Orders o
ON c.custid = o.custid;

-- Exercise 5
SELECT c.custid, c.companyname
FROM Sales.Customers c
LEFT JOIN Sales.Orders o
ON c.custid = o.custid
WHERE o.orderid IS NULL;

-- Exercise 6
SELECT c.custid, c.companyname, o.orderid, o.orderdate
FROM Sales.Customers c
INNER JOIN Sales.Orders o
ON c.custid = o.custid
WHERE o.orderdate = '20160212';

-- Exercise 7
SELECT c.custid, c.companyname, o.orderid, o.orderdate
FROM Sales.Customers c
LEFT JOIN Sales.Orders o
ON c.custid = o.custid
AND o.orderdate = '20160212';

-- Exercise 9
SELECT c.custid,
    c.companyname,
    CASE
    WHEN o.orderid IS NULL THEN 'No'
    WHEN o.orderid IS NOT NULL THEN 'Yes'
    END AS HasOrderOn20160212
FROM Sales.Customers c
LEFT JOIN Sales.Orders o
ON c.custid = o.custid
AND o.orderdate = '20160212';
