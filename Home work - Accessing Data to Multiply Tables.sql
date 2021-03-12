--TASK 1
--1
SELECT FirstName, LastName, City
FROM Employees
WHERE City IN ('Seattle', 'Redmond') 

--2
SELECT CompanyName, ContactTitle, City, Country
FROM Customers 
WHERE Country IN ('Mexico', 'Spain') AND City NOT IN ('Madrid')

-- TASK 2
--1
 SELECT LastName, OrderID
FROM Employees
LEFT OUTER JOIN Orders ON Employees.EmployeeID=Orders.EmployeeID  

--2
SELECT *
FROM Suppliers FULL OUTER JOIN Products
ON Suppliers.SupplierID=Products.ProductID 

-- TASK 3 
--1
SELECT FirstName, LastName, COUNT (OrderID) as NumOrders
FROM Employees JOIN Orders
ON Employees.EmployeeID=Orders.EmployeeID
WHERE Year (OrderDate) = 1997
GROUP BY FirstName, LastName
--2
SELECT FirstName, LastName, COUNT (OrderID) as NumOrders
FROM Employees JOIN Orders
ON Employees.EmployeeID=Orders.EmployeeID
WHERE ShippedDate>RequiredDate AND Year (OrderDate) = 1997
GROUP BY FirstName, LastName


--TASK 4 
--1
SELECT DISTINCT Customers.CompanyName 
FROM Customers JOIN Orders ON Customers.CustomerID=Orders.CustomerID
	JOIN [Order Details] ON Orders.OrderID=[Order Details].OrderId
	JOIN Products ON Products.ProductID=[Order Details].ProductID
	JOIN Suppliers ON Products.SupplierID=Suppliers.SupplierID
WHERE Customers.Country = 'France' and Suppliers.Country <> 'France'
--2
SELECT Suppliers.CompanyName, Products.ProductName, Categories.CategoryName
FROM Suppliers 
	JOIN Products ON Suppliers.SupplierId=Products.SupplierID
	JOIN Categories ON Categories.CategoryID=Products.CategoryID

--TASK 5 
--1
SELECT A.ContactName, A.City
FROM Customers A, Customers B
WHERE A.ContactName <> B.ContactName AND A.City=B.City AND A.Country = 'France' AND B.Country = 'France'
--2
SELECT DISTINCT A.ContactName, A.City
FROM Suppliers A, Suppliers B
WHERE A.ContactName <> B.ContactName AND A.City<>B.City AND A.Country = 'Germany' AND B.Country = 'Germany'

-- TASK 6 
--1
SELECT A.FirstName as EmployeeName,
	A.LastName as EmployeeLastName,
	B.FirstName as ManagerName, 
	B.LastName as ManagerLastName
FROM Employees A, Employees B
WHERE A.ReportsTo=B.EmployeeID
 
 --TASK 7 
 --1
 SELECT CompanyName, COUNT (OrderID) as NumOrders
 FROM Customers
	JOIN Orders ON Customers.CustomerID= Orders.CustomerID
 WHERE Customers.Country= 'France'
 GROUP BY CompanyName 
 ORDER BY COUNT (OrderID) DESC
 --2
 SELECT CompanyName, COUNT (OrderID) as NumOrders
 FROM Customers
	JOIN Orders ON Customers.CustomerID= Orders.CustomerID
 WHERE Customers.Country= 'France'
 GROUP BY CompanyName 
 HAVING COUNT (OrderID) >1
 ORDER BY COUNT (OrderID) DESC

 --TASK 8
 --1
 SELECT CompanyName
 FROM Customers 
	JOIN Orders ON Customers.CustomerID=Orders.CustomerID
	JOIN [Order Details] ON Orders.OrderID=[Order Details].OrderID
	JOIN Products ON Products.ProductID=[Order Details].ProductID
 WHERE ProductName = 'Tofu'
  --2
 SELECT DISTINCT Customers.CompanyName 
FROM Customers 
	JOIN Orders ON Customers.CustomerID=Orders.CustomerID
	JOIN [Order Details] ON Orders.OrderID=[Order Details].OrderId
	JOIN Products ON Products.ProductID=[Order Details].ProductID
	JOIN Suppliers ON Products.SupplierID=Suppliers.SupplierID
WHERE Customers.Country = 'France' and Suppliers.Country <> 'France'
--3
SELECT DISTINCT Customers.CompanyName 
FROM Customers JOIN Orders ON Customers.CustomerID=Orders.CustomerID
	JOIN [Order Details] ON Orders.OrderID=[Order Details].OrderId
	JOIN Products ON Products.ProductID=[Order Details].ProductID
	JOIN Suppliers ON Products.SupplierID=Suppliers.SupplierID
WHERE Customers.Country = 'France' AND Suppliers.Country ='France'

--Home Work
--1
SELECT	Customers.Country,	COUNT (OrderID) as NumOrders
FROM Customers 
	JOIN Orders ON Customers.CustomerID=Orders.CustomerID
GROUP BY Customers.Country
ORDER BY COUNT (OrderID) DESC

--2
SELECT 	Customers.Country, 
	SUM (CASE WHEN Suppliers.Country=Customers.Country then 1 else 0 end) as NumOrdersDomestic,
	SUM (CASE WHEN Suppliers.Country<>Customers.Country then 1 else 0 end) as NumOrdersInternational
FROM Customers
	JOIN Orders ON Customers.CustomerID=Orders.CustomerID
	JOIN [Order Details] ON Orders.OrderID=[Order Details].OrderID
	JOIN Products ON Products.ProductID=[Order Details].ProductID
	JOIN Suppliers ON Suppliers.SupplierID=Products.SupplierID
GROUP BY Customers.Country
ORDER BY count (Orders.OrderID) DESC 


--3
SELECT 	Categories.CategoryName, 
	SUM (Orders.OrderID) as NumOrders
FROM Orders
	JOIN [Order Details] ON Orders.OrderID=[Order Details].OrderID
	JOIN Products ON Products.ProductID=[Order Details].ProductID
	JOIN Categories ON Categories.CategoryID=Products.CategoryID
WHERE YEAR (OrderDate) = 1997
GROUP BY Categories.CategoryName

--4
SELECT 	DISTINCT ProductName, 
	Products.UnitPrice, 
	[Order Details].UnitPrice as 'Historical Price'
FROM Products
LEFT JOIN [Order Details] ON Products.ProductID=[Order Details].ProductID AND [Order Details].UnitPrice <> Products.UnitPrice
ORDER BY ProductName
