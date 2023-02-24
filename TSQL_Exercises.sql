-- Itzik Ben-Gan T-SQL Fundamentals
-- Chapter 2
-- Exercise 1
SELECT orderid, orderdate, custid, empid
FROM Sales.Orders
WHERE YEAR(orderdate) = 2015 AND MONTH(orderdate) = 06;

-- Exercise 2
SELECT orderid, orderdate, custid, empid
FROM Sales.Orders
WHERE orderdate = EOMONTH(orderdate);

-- Exercise 3
SELECT empid, firstname, lastname
FROM HR.Employees
WHERE firstname LIKE ('%a%a%');

-- Exercise 4
SELECT orderid, SUM(qty * unitprice) AS totalvalue
FROM Sales.OrderDetails
GROUP BY orderid
HAVING SUM(qty * unitprice) > 10000
ORDER BY totalvalue DESC;

-- Exercise 5
SELECT empid, lastname
FROM HR.Employees
WHERE lastname COLLATE Latin1_General_CS_AS LIKE ('[abcdefghijklmnopqrstuvwxyz]%');

-- Exercise 6
-- explain difference between two queries:
SELECT empid, COUNT(*) AS numorders
FROM Sales.Orders
WHERE orderdate < '20160501'
GROUP BY empid;

SELECT empid, COUNT(*) AS numorders
FROM Sales.Orders
GROUP BY empid
HAVING MAX(orderdate) < '20160501';

-- Exercise 7
SELECT TOP (3) shipcountry, AVG(freight) AS avgfreight
FROM Sales.Orders
WHERE YEAR(orderdate) = 2015
GROUP BY shipcountry
HAVING AVG(freight) > 0
ORDER by avgfreight DESC;

-- Exercise 8
