/* 1) Presentes las ventas por categorías y productos, desde enero de 1996 a agosto de 1996. 
Solo puede mostrar los volúmenes que pasen de 100 unidades y total vendido 20,000 
(Puede ajustar los rangos de no existir con esos criterios). */

SELECT c.CategoryName, p.ProductName, SUM(od.Quantity) AS Total_Unidades, SUM(od.UnitPrice * od.Quantity) AS Total_Vendido
FROM Categories c
JOIN Products p ON c.CategoryID = p.CategoryID
JOIN [Order Details] od ON p.ProductID = od.ProductID
JOIN Orders o ON od.OrderID = o.OrderID
WHERE o.OrderDate BETWEEN '1996-01-01' AND '1996-08-31'
GROUP BY c.CategoryName, p.ProductName
HAVING SUM(od.Quantity) > 100 AND SUM(od.UnitPrice * od.Quantity) > 20000;


/* 2) Northwind, presente las ventas totales por shippers, año, mes, semana. 
Coloque el nombre del mes y diga cuantos días promedios transcurrieron para la entrega. */

SELECT s.CompanyName AS Shipper, 
YEAR(o.OrderDate) AS Año, 
MONTH(o.OrderDate) AS Mes, 
DATENAME(MONTH, o.OrderDate) AS Nombre_Mes, 
DATEPART(WEEK, o.OrderDate) AS Semana, 
COUNT(o.OrderID) AS Total_Ventas, 
AVG(DATEDIFF(DAY, o.OrderDate, o.ShippedDate)) AS Promedio_Dias_Entrega
FROM Orders o
JOIN Shippers s ON o.ShipVia = s.ShipperID
WHERE o.ShippedDate IS NOT NULL
GROUP BY s.CompanyName, YEAR(o.OrderDate), MONTH(o.OrderDate), DATENAME(MONTH, o.OrderDate), DATEPART(WEEK, o.OrderDate);