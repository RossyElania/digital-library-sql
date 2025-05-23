
											/* El Misterio del Declive de Ventas en Northwind */

/* La Llamada del Director Financiero.Era un lunes por la ma�ana cuando Emma Rodr�guez, directora financiera de Northwind Traders, 
convoc� a una reuni�n urgente con el equipo de an�lisis de datos. Las cifras del �ltimo trimestre no eran alentadoras: 
las ventas hab�an ca�do en un 15% respecto al a�o anterior, algunos clientes habituales parec�an haber desaparecido, 
y ciertos productos que antes lideraban el mercado ahora acumulaban polvo en el inventario.

"Necesitamos respuestas y las necesitamos ya", dijo Emma con tono firme. 
"�Qu� est� pasando con nuestras ventas? �Qu� clientes hemos perdido? 
�Hay productos que ya no funcionan? Necesito un informe detallado lo antes posible".

Con la presi�n sobre sus hombros, el equipo de an�lisis de datos, liderado por Luis M�ndez, se puso manos a la obra. */

														/* Entregable:*/

/* An�lisis 1: Clientes M�s Rentables por A�o realizar una Interpretaci�n de los Datos (Querys y an�lisis) */

SELECT 
YEAR(Ordenes.OrderDate) AS Anio,
Ordenes.CustomerID,
Clientes.CompanyName AS Cliente,
SUM(Ordenes_Detalles.UnitPrice * Ordenes_Detalles.Quantity * (1 - Ordenes_Detalles.Discount)) AS Ingresos_Totales,
COUNT(Ordenes.OrderID) AS NumeroPedidos
FROM dbo.Orders AS Ordenes
JOIN dbo.[Order Details] AS Ordenes_Detalles ON Ordenes.OrderID = Ordenes_Detalles.OrderID
JOIN dbo.Customers AS Clientes ON Ordenes.CustomerID = Clientes.CustomerID
GROUP BY YEAR(Ordenes.OrderDate), Ordenes.CustomerID, Clientes.CompanyName
ORDER BY Anio, Ingresos_Totales DESC;

/* Clientes mas Rentables por A�o
Esta vista mostro que algunos de los clientes que solian comprar frecuentemente redujeron la frecuencia o dejaron de comprar. 
Tambien se puede analizar que hay clientes nuevos pero las compras de estos no son tan significativos como los antiguos. 
Esto la competencia esta ofreciendo mejores ofertas o que estos clientes dejaron de necesitar nuestros productos; para confirmar estas teorias
podriamos llamar a estos clientes y realizarles una encuenta sobre cual fue el motivo. */


/* An�lisis 2: Productos con Mayor Rentabilidad por Categor�a realizar una Interpretaci�n de los Datos (Querys y an�lisis) */

SELECT 
Categorias.CategoryID,
Categorias.CategoryName AS Categoria,
Productos.ProductID,
Productos.ProductName AS Producto,
SUM(Ordenes_Detalles.UnitPrice * Ordenes_Detalles.Quantity * (1 - Ordenes_Detalles.Discount)) AS Ingresos_Totales,
SUM((Ordenes_Detalles.UnitPrice - Productos.UnitPrice) * Ordenes_Detalles.Quantity) AS Ganancia_Neta,
COUNT(Ordenes_Detalles.OrderID) AS NumeroVentas
FROM dbo.[Order Details] AS Ordenes_Detalles
JOIN dbo.Products AS Productos ON Ordenes_Detalles.ProductID = Productos.ProductID
JOIN dbo.Categories AS Categorias ON Productos.CategoryID = Categorias.CategoryID
GROUP BY Categorias.CategoryID, Categorias.CategoryName, Productos.ProductID, Productos.ProductName
ORDER BY Categoria, Ganancia_Neta DESC;

/* Productos con Mayor Rentabilidad por Categoria
Esta vista mostro que algunos productos que antes lideraba en ventas hoy en dia tienen muy poca demanda. 
Algunas categorias siguen generando buenos ingresos, pero otras se han reducido significativamente bajado bastante. 
Lo que puede indicar cambios en el mercado o nuevos competidores. */


/* An�lisis 3: Ventas por Mes y A�o realizar una Interpretaci�n de los Datos (Querys y an�lisis) */

SELECT 
YEAR(Ordenes.OrderDate) AS Anio,
MONTH(Ordenes.OrderDate) AS Mes,
SUM(Ordenes_Detalles.UnitPrice * Ordenes_Detalles.Quantity * (1 - Ordenes_Detalles.Discount)) AS Ingresos_Totales,
COUNT(Ordenes.OrderID) AS Numero_Pedidos
FROM dbo.Orders AS Ordenes
JOIN dbo.[Order Details] AS Ordenes_Detalles ON Ordenes.OrderID = Ordenes_Detalles.OrderID
GROUP BY YEAR(Ordenes.OrderDate), MONTH(Ordenes.OrderDate)
ORDER BY Anio, Mes;

/* Ventas por Mes y A�o
Las ventas mensuales se han reducido, sin embargo, algunos meses muestran menos ventas que los demas. 
Lo que muestra que hay epocas de receccion o bajas o que nuestros productos no generan esa sensacion de necesidad en todas las epocas. */


/* El an�lsiis y lso querys deben ser entregados en formato SQL */

/* El problema principal de Northwind Traders es que no puede mantener su cartera de clientes importantes.
Otro problema podria ser que sus productos han perdido relevancia en el mercado; ya sea porque no se reinventan o adaptan al paso del tiempo.
Al igual que no generan sentimientos de necesidad en todas las epocas, es decir, se vuelven irrelevantes en meses especificos.

Mis recomendaciones son:
Intentar recuperar sus clientes antiguos con ofertas o promociones.
Analizar y/o reinventar los productos que ya no se venden.
Lanzar campa�as en los meses con menos ventas. */

