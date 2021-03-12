--TASK 1

SELECT *
FROM Employees
WHERE EmployeeID=8

SELECT FirstName, LastName
FROM Employees
WHERE City = 'London'

SELECT FirstName, LastName
FROM Employees
WHERE FirstName LIKE 'A%'

SELECT FirstName, LastName, (YEAR (GETDATE())- YEAR (BirthDate)) as Age
FROM Employees
WHERE ( YEAR (GETDATE())- Year (BirthDate)) > 55
ORDER BY LastName

SELECT COUNT(EmployeeID)
FROM Employees
WHERE City = 'London'

--TASK 2

SELECT MAX (YEAR (GETDATE())- YEAR (BirthDate)) as Max_Age, 
MIN (YEAR (GETDATE())- YEAR (BirthDate)) as Min_Age, 
AVG (YEAR (GETDATE())- YEAR (BirthDate)) as Avg_Age
FROM Employees
WHERE City = 'London'

SELECT City,
MAX (YEAR (GETDATE())- YEAR (BirthDate)) as Max_Age, 
MIN (YEAR (GETDATE())- YEAR (BirthDate)) as Min_Age, 
AVG (YEAR (GETDATE())- YEAR (BirthDate)) as Avg_Age
FROM Employees
Group by City

SELECT City,
AVG (YEAR (GETDATE())- YEAR (BirthDate)) as Avg_Age
FROM Employees
Group by City
HAVING AVG (YEAR (GETDATE())- YEAR (BirthDate)) > 60 

SELECT TOP (1) FirstName, LastName FROM (
SELECT FirstName, LastName, (YEAR (GETDATE())- YEAR (BirthDate)) as Age
FROM Employees
) A
Order by Age DESC

SELECT TOP 3 * FROM (
SELECT FirstName, LastName,  (YEAR (GETDATE())- YEAR (BirthDate)) as Age
FROM Employees
) Age
Order by Age DESC


-- Home Work

SELECT ProductName, QuantityPerUnit
FROM Products

SELECT ProductID, ProductName
FROM Products
WHERE Discontinued = 0

SELECT ProductID, ProductName
FROM Products
WHERE Discontinued = 1

SELECT ProductName, UnitPrice 
FROM Products 
WHERE UnitPrice = (SELECT MIN (UnitPrice) FROM Products)
UNION 
SELECT ProductName, UnitPrice 
FROM Products
WHERE UnitPrice = (SELECT MAX (UnitPrice) FROM Products)

SELECT ProductId, ProductName, UnitPrice
FROM Products
WHERE UnitPrice < 20

SELECT ProductId, ProductName, UnitPrice
FROM Products
WHERE UnitPrice BETWEEN 15 AND 25

SELECT ProductName, UnitPrice
FROM Products
WHERE UnitPrice > (SELECT AVG (UnitPrice) FROM Products)

SELECT TOP 10 ProductName, UnitPrice
FROM Products
Order by UnitPrice DESC

SELECT COUNT (Discontinued) as 'Num_Discontinued'
FROM Products
WHERE Discontinued <> 0

SELECT COUNT (Discontinued) as 'Num_Current'
FROM Products
WHERE Discontinued = 0

SELECT ProductName, UnitsOnOrder, UnitsInStock
FROM Products
WHERE UnitsInStock<UnitsOnOrder

