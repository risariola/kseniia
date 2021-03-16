--TASK 1
--1
SELECT E.FirstName, E.LastName, O.Freight
FROM Employees E, Orders O
WHERE O.Freight = (SELECT (MAX (Freight)) From Orders)
	AND O.EmployeeID=E.EmployeeID

--2
SELECT E.FirstName, E.LastName, O.Freight
FROM Employees E, Orders O
WHERE O.Freight > (SELECT (AVG (Freight)) From Orders)
	AND O.EmployeeID=E.EmployeeID

--3
SELECT ProductName
FROM Products
WHERE UnitPrice = (SELECT (MAX (UnitPrice)) as MaxPrice FROM Products)

--4
SELECT C.CompanyName, O.Freight
FROM Customers C, Orders O
WHERE C.CustomerID=O.CustomerID 
		AND Freight > (SELECT AVG (Freight) FROM Orders)

--5
SELECT S.CompanyName
FROM Suppliers S, Products P
WHERE S.SupplierID=P.SupplierID 
	AND UnitPrice = (SELECT MIN (UnitPrice) FROM Products)

--TASK 2
--1
SELECT C.CategoryName, AVG (UnitPrice) as AvgPrice
FROM Products P, Categories C
WHERE P.CategoryID=C.CategoryID 
GROUP BY C.CategoryName
HAVING AVG (UnitPrice) > (SELECT AVG (UnitPrice) FROM Products)

--2
SELECT S.CompanyName
FROM Suppliers S, Products P
WHERE S.SupplierID=P.SupplierID 
GROUP BY S.CompanyName
HAVING AVG (UnitPrice) < (SELECT AVG (UnitPrice) FROM Products)

--3
 SELECT DISTINCT r.RegionDescription
FROM Employees E, EmployeeTerritories et, Territories t, Region r 
WHERE E.EmployeeID=et.EmployeeID
	AND t.TerritoryID=et.TerritoryID
	AND t.RegionID=r.RegionID
GROUP BY  r.RegionDescription
HAVING AVG (YEAR (GETDATE())-YEAR(BirthDate)) > (SELECT AVG (YEAR (GETDATE())-YEAR(BirthDate))
FROM Employees)

--4
SELECT CompanyName, MAX (Freight)
FROM Customers C, Orders O
WHERE O.CustomerID=C.CustomerID
GROUP BY CompanyName
HAVING MAX (Freight) < (SELECT AVG (Freight) FROM Orders)

--5
SELECT CategoryName, AVG (Discount) AS AvgDiscount
FROM Categories C, Products P, [Order Details] D
WHERE C.CategoryID=P.CategoryID 
	AND P.ProductID=D.ProductID
GROUP BY CategoryName
HAVING AVG (Discount) > (SELECT AVG (Discount) FROM [Order Details])

--TASK 3
--1
SELECT AVG (Freight) AvgFreigt
FROM Orders O, Employees E, EmployeeTerritories ET, Territories T, Region R
WHERE O.EmployeeID=E.EmployeeID
	AND	E.EmployeeID=ET.EmployeeID
	AND ET.TerritoryID=T.TerritoryID
	AND T.RegionID=R.RegionID
	AND RegionDescription NOT IN ('Western')

--2
SELECT E.FirstName, E.LastName, O.ShipCity, O.ShipCountry
FROM Employees E, Orders O
WHERE E.EmployeeID=O.EmployeeID
	AND ShipCountry IN ('USA')

--3
SELECT P.ProductName, SUM (D.UnitPrice) AS TotalCost
FROM Products P, Suppliers S, [Order Details] D
WHERE P.SupplierID=S.SupplierID
	AND D.ProductID=P.ProductID
	AND S.Country = 'Germany'
GROUP BY P.ProductName 

--4
SELECT DISTINCT FirstName, LastName
FROM Orders O, Employees E, EmployeeTerritories ET, Territories T, Region R
WHERE O.EmployeeID=E.EmployeeID
	AND	E.EmployeeID=ET.EmployeeID
	AND ET.TerritoryID=T.TerritoryID
	AND T.RegionID=R.RegionID
	AND RegionDescription NOT IN ('Eastern')

--5
SELECT C.CompanyName
FROM Customers C, Orders O, [Order Details] D, Products P, Suppliers S
WHERE O.CustomerID=C.CustomerID
	AND O.OrderID=D.OrderID
	AND D.ProductID=P.ProductID
	AND P.SupplierID=S.SupplierID
	AND C.Country<>S.Country

--TASK 4
--1
SELECT DISTINCT E.FirstName, E.LastName
FROM Employees E, Orders O
WHERE E.EmployeeID=O.EmployeeID
	AND O.ShipCountry = 'USA'

--2
SELECT O.OrderID, P.ProductName, P.UnitPrice
FROM Customers C, Orders O, [Order Details] D, Products P, Suppliers S
WHERE O.CustomerID=C.CustomerID
	AND O.OrderID=D.OrderID
	AND D.ProductID=P.ProductID
	AND P.SupplierID=S.SupplierID
	AND ShipCountry = 'USA'
	AND P.UnitPrice = (SELECT MIN (UnitPrice) FROM Products)

--3
SELECT DISTINCT C.CompanyName
FROM Customers C, Orders O, [Order Details] D,  Products P, Categories Ct
WHERE O.CustomerID=C.CustomerID
	AND O.OrderID=D.OrderID
	AND D.ProductID=P.ProductID
	AND P.CategoryID=Ct.CategoryID
	AND CategoryName LIKE '%Meat%'
	AND NOT EXISTS (
		SELECT *
		FROM Orders O2, [Order Details] D2, Products P2, Categories Ct2
		WHERE
			O2.CustomerID=C.CustomerID
			AND O2.OrderID=D2.OrderID
			AND D2.ProductID=P2.ProductID
			AND P2.CategoryID=Ct2.CategoryID
			AND Ct2.CategoryName = 'Beverages')

--4
SELECT DISTINCT E.City AS EmployeeCity,
		C.City AS CustomerCity, 
		O.ShipCity AS OrderCity
FROM Employees E, Customers C, Orders O
WHERE E.EmployeeID=O.EmployeeID
	AND C.CustomerID=O.CustomerID

--5
SELECT P.ProductName
FROM Products P, [Order Details] D
WHERE P.ProductID=D.ProductID
AND D.Quantity=100

--TASK5
--1
SELECT S.CompanyName
FROM Suppliers S, Products P
WHERE S.SupplierID=P.SupplierID
	AND UnitPrice =10

--2
SELECT E.LastName, E.FirstName, Freight
FROM Employees E, Orders O
WHERE E.EmployeeID=O.EmployeeID
	AND Freight=1000

--3
SELECT DISTINCT C.CompanyName
FROM Customers C, Orders O
WHERE C.CustomerID=O.CustomerID
	AND YEAR (OrderDate) = 1997

--4
SELECT DISTINCT P.ProductName
FROM Products P, Categories C
WHERE P.CategoryID 
	IN (SELECT CategoryID 
		FROM Categories 
		WHERE CategoryName = 'Seafood') 

--5
SELECT DISTINCT C.CompanyName
FROM Customers C, Orders O, [Order Details] D, Products P, Categories Ct
WHERE O.CustomerID=C.CustomerID
	AND O.OrderID=D.OrderID
	AND D.ProductID=P.ProductID
	AND P.CategoryID=Ct.CategoryID
	AND CategoryName = 'Dairy Products'

--Home Work
--1
SELECT P. ProductName, S.SupplierID
FROM Suppliers S, Products P
WHERE S.SupplierID=P.SupplierID
	AND S.SupplierID 
		IN ( SELECT SupplierID FROM Suppliers
			WHERE CompanyName IN ('Exotic Liquids', 'Grandma Kelly''s Homestead',' Tokyo Traders'))

--2
SELECT P. ProductName
FROM Suppliers S, Products P
WHERE S.SupplierID=P.SupplierID
	AND S.SupplierID 
		IN ( SELECT SupplierID FROM Suppliers
			WHERE CompanyName = 'Pavlova, LTD.')

--3
SELECT O.OrderID, C.City
FROM Orders O, Customers C
WHERE C.CustomerID= O.CustomerID
	AND C.CustomerID
	NOT IN (SELECT CustomerID
			FROM Customers
			WHERE City = 'London')

--4
SELECT C.CustomerID, COUNT (C.CustomerID) AS NumOrders
FROM Orders O, Customers C
WHERE C.CustomerID= O.CustomerID
	AND ShipCity = 'London'
GROUP BY C.CustomerID
HAVING COUNT (C.CustomerID) >30

--5
SELECT O.OrderID, E.City, O.ShipCity
FROM Orders O, Employees E
WHERE E.EmployeeID=O.EmployeeID
	AND E.City= O.ShipCity