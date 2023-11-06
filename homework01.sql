--1:
select ProductName, QuantityPerUnit from products


--2:
select ProductID, ProductName from Products
where Discontinued = 1


--3:
select ProductID, ProductName, Discontinued as discProduct from Products
where Discontinued = 1


--4:
select ProductID, ProductName, UnitPrice from Products
where UnitPrice < 20


--5:
select ProductID, ProductName, UnitPrice from Products
where UnitPrice between 15 and 25


--6:
select ProductName, UnitsInStock, UnitsOnOrder from products
where UnitsInStock < UnitsOnOrder


--7:
select * from products
where ProductName like 'a%'


--8:
select * from products
where ProductName like '%i'


--9:
select 
ProductID,
ProductName,
UnitPrice + ((UnitPrice * 18) / 100) as UnitPriceKDV
from products


--10:
select count(*) from Products
where UnitPrice > 30


--11
select lower (productName), UnitPrice from Products
order by UnitPrice desc


--12:
select Concat(FirstName, ' ', LastName) as fullName from Employees


--13:
select count(*) from Suppliers 
where region is null


--14:
select count(*) from Suppliers 
where region is not null


--15:
select 
concat('TR' , ' ', upper(ProductName))
from Products


--16:
select 
concat('TR' , ' ', upper(ProductName))
from Products
where UnitPrice < 20


--17:
select ProductName from Products
where UnitPrice = (select max(UnitPrice) from Products)


--18:
select top 10 ProductName, max(UnitPrice) from Products
group by ProductName
order by max(UnitPrice) desc


--19:
select ProductName, UnitPrice from Products
where UnitPrice > (select avg(UnitPrice) from Products)


--20:
select productName, (UnitsInStock * UnitPrice) from Products


--21:
select Discontinued ,count(Discontinued) from Products
group by Discontinued


--22:
select ProductName, CategoryName from Products p
inner join Categories c
on p.CategoryID = c.CategoryID


--23:
select c.CategoryName, avg(p.UnitPrice) from Products p
inner join Categories c
on p.CategoryID = c.CategoryID
group by c.CategoryName


--24:
select p.ProductName, c.CategoryName, p.UnitPrice from Products p
inner join Categories c
on p.CategoryID = c.CategoryID
where p.UnitPrice = (select MAX(UnitPrice) from Products)


--25:
select top 1 p.ProductName, c.CategoryName, s.CompanyName, p.UnitsOnOrder from Products p
inner join Categories c
on p.CategoryID = c.CategoryID
inner join Suppliers s
on  p.SupplierID = s.SupplierID
order by p.UnitsOnOrder desc


--26:
select p.ProductID, p.ProductName, s.CompanyName, s.Phone from Products p
inner join Suppliers s
on p.SupplierID = s.SupplierID
where UnitsInStock = 0


--27:
select o.ShipAddress, e.FirstName, e.LastName from orders o
inner join Employees e
on o.EmployeeID = e.EmployeeID
where YEAR(OrderDate) = 1998 and MONTH(OrderDate) = 3


--28:
select count(*) from Orders
where YEAR(OrderDate) = 1997 and MONTH(OrderDate) = 2


--29:
select * from Orders
where YEAR(OrderDate) = 1998 and ShipCity like '%London%'


--30:
select c.ContactName, c.Phone from Customers c
inner join orders o
on c.CustomerID = o.CustomerID
where YEAR(o.OrderDate) = 1997


--31: 
select * from orders
where Freight > 40


--32:
select o.ShipCity, c.CompanyName from orders o 
inner join Customers c
on o.CustomerID = c.CustomerID
where Freight >= 40


--33:
select o.OrderDate, o.ShipCity, concat(upper(e.FirstName), ' ', upper(e.LastName)) from orders o
inner join Employees e
on o.EmployeeID = e.EmployeeID
where YEAR(OrderDate) = 1997


--34: Dön tekrar
select c.ContactName, c.Phone from Customers c
inner join Orders o
on c.CustomerID = o.CustomerID
where year(o.OrderDate) = 1997


--35:
select o.OrderDate, c.ContactName, e.FirstName, e.LastName from orders o
inner join customers c
on o.CustomerID = c.CustomerID
inner join employees e
on o.EmployeeID = e.EmployeeID


--36:
select * from orders
where ShippedDate < RequiredDate


--37: 
select o.OrderDate, c.CompanyName from orders o
inner join Customers c
on o.CustomerID = c.CustomerID
where ShippedDate < RequiredDate


--38: 
select p.ProductName, c.CategoryName, od.Quantity from [Order Details] od
inner join Orders o
on od.OrderID = o.OrderID
inner join Products p
on od.ProductID = p.ProductID
inner join Categories c
on p.CategoryID = c.CategoryID
where o.OrderID = 10248


--39:
select p.ProductName, s.CompanyName from [Order Details] od
inner join Orders o
on od.OrderID = o.OrderID
inner join Products p
on od.ProductID = p.ProductID
inner join Suppliers s
on p.SupplierID = s.SupplierID
where o.OrderID = 10248


--40: 
select p.ProductName, od.Quantity from [Order Details] od
inner join Orders o
on od.OrderID = o.OrderID
inner join Products p
on od.ProductID = p.ProductID
inner join Employees e
on o.EmployeeID = e.EmployeeID
where e.EmployeeID = 3 and YEAR(o.OrderDate) = 1997


--41:
select top 1 e.EmployeeID, e.FirstName, e.LastName, o.OrderDate, (od.UnitPrice * od.Quantity)  TotalSales from [Order Details] od
inner join Orders o
on od.OrderID = o.OrderID
inner join Products p
on od.ProductID = p.ProductID
inner join Employees e
on o.EmployeeID = e.EmployeeID
where YEAR(o.OrderDate) = 1997 
order by TotalSales desc


--42:
select top 1 e.EmployeeID, e.FirstName, e.LastName, sum((od.UnitPrice * od.Quantity)) as total from [Order Details] od
inner join Orders o
on od.OrderID = o.OrderID
inner join Employees e
on o.EmployeeID = e.EmployeeID
where YEAR(o.OrderDate) = 1997
group by e.EmployeeID, e.FirstName, e.LastName
order by total desc


--43: 
select p.ProductName, p.UnitPrice, c.CategoryName  from Products p
inner join Categories c
on p.CategoryID = c.CategoryID
where p.UnitPrice = (select max(UnitPrice) from Products)


--44: Soru enteresan
select top 1 e.FirstName, e.LastName, o.OrderDate, o.OrderID from [Order Details] od
inner join Orders o
on od.OrderID = o.OrderID
inner join Products p
on od.ProductID = p.ProductID
inner join Employees e
on o.EmployeeID = e.EmployeeID
where p.UnitPrice = (select max(UnitPrice) from Products)
order by o.OrderDate 


--45:
select o.OrderID, avg(od.UnitPrice * od.Quantity) from [Order Details] od 
inner join (select top 5 * from Orders order by OrderDate desc) o
on od.OrderID = o.OrderID
group by o.OrderID


--46:
select p.ProductName, c.CategoryName, sum(od.Quantity) from Orders o
inner join [Order Details] od
on o.OrderID = od.OrderID
inner join Products p
on od.ProductID = p.ProductID
inner join Categories c
on p.CategoryID = c.CategoryID
where month(OrderDate) = 1 
group by p.ProductName, c.CategoryName


--47: 
select * from [Order Details] od
inner join Orders o
on od.OrderID = o.OrderID
where od.Quantity > (select avg(Quantity) from [Order Details])


--48: 
select p.ProductName, c.CategoryName, s.CompanyName, od.Quantity from Orders o
inner join [Order Details] od
on o.OrderID = od.OrderID
inner join Products p
on od.ProductID = p.ProductID
inner join Categories c
on p.CategoryID = c.CategoryID
inner join Suppliers s
on p.SupplierID = s.SupplierID
where od.Quantity = (select max(Quantity) from [Order Details])


--49: 
select count(distinct Country) from Customers


--50:
select sum((od.Quantity * od.UnitPrice)) as total_sales  from [Order Details] od
inner join orders o
on od.OrderID = o.OrderID
inner join Employees e
on o.EmployeeID = e.EmployeeID
where e.EmployeeID = 3 and o.OrderDate between '1998-01-01' and GETDATE()


--51:
select p.ProductName, c.CategoryName, od.Quantity from orders o
inner join [Order Details] od
on o.OrderID = od.OrderID
inner join Products p
on od.ProductID = p.ProductID
inner join Categories c
on p.CategoryID = c.CategoryID
where o.OrderID = 10248

 
--52:
select p.ProductName, s.CompanyName from orders o
inner join [Order Details] od
on o.OrderID = od.OrderID
inner join Products p
on od.ProductID = p.ProductID
inner join Suppliers s
on p.SupplierID = s.SupplierID
where o.OrderID = 10248


--53:
select p.ProductName, od.Quantity from [Order Details] od
inner join Orders o
on od.OrderID = o.OrderID
inner join Employees e
on o.EmployeeID = e.EmployeeID
inner join Products p
on od.ProductID = p.ProductID
where e.EmployeeID = 3 and YEAR(o.OrderDate) = 1997


--54:
select top 1 e.EmployeeID, e.FirstName, e.LastName, o.OrderDate, (od.UnitPrice * od.Quantity)  TotalSales from [Order Details] od
inner join Orders o
on od.OrderID = o.OrderID
inner join Products p
on od.ProductID = p.ProductID
inner join Employees e
on o.EmployeeID = e.EmployeeID
where YEAR(o.OrderDate) = 1997 
order by TotalSales desc


--55:
select top 1 e.EmployeeID, e.FirstName, e.LastName, sum((od.UnitPrice * od.Quantity)) as total from [Order Details] od
inner join Orders o
on od.OrderID = o.OrderID
inner join Employees e
on o.EmployeeID = e.EmployeeID
where YEAR(o.OrderDate) = 1997
group by e.EmployeeID, e.FirstName, e.LastName
order by total desc


--56:
select p.ProductName, p.UnitPrice, c.CategoryName  from Products p
inner join Categories c
on p.CategoryID = c.CategoryID
where p.UnitPrice = (select max(UnitPrice) from Products)


--57:
select top 1 e.FirstName, e.LastName, o.OrderDate, o.OrderID from [Order Details] od
inner join Orders o
on od.OrderID = o.OrderID
inner join Products p
on od.ProductID = p.ProductID
inner join Employees e
on o.EmployeeID = e.EmployeeID
where p.UnitPrice = (select max(UnitPrice) from Products)
order by o.OrderDate 


--58:
select o.OrderID, avg(od.UnitPrice * od.Quantity) from [Order Details] od 
inner join (select top 5 * from Orders order by OrderDate desc) o
on od.OrderID = o.OrderID
group by o.OrderID


--59:
select p.ProductName, c.CategoryName, sum(od.Quantity) from Orders o
inner join [Order Details] od
on o.OrderID = od.OrderID
inner join Products p
on od.ProductID = p.ProductID
inner join Categories c
on p.CategoryID = c.CategoryID
where month(OrderDate) = 1 
group by p.ProductName, c.CategoryName


--60:
select * from [Order Details] od
inner join Orders o
on od.OrderID = o.OrderID
where od.Quantity > (select avg(Quantity) from [Order Details])
