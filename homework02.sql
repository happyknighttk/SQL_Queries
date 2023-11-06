--61. En çok satılan ürünümün(adet bazında) adı, kategorisinin adı ve tedarikçisinin adı

select p.product_name, sum(od.quantity) as "Ürünün satış miktarı", c.category_name, s.company_name from products p
inner join order_details od
on p.product_id = od.product_id
inner join categories c
on c.category_id = p.category_id
inner join suppliers s
on s.supplier_id = p.supplier_id
group by p.product_name, c.category_name, s.company_name
order by sum(od.quantity) desc
limit 1

--62. Kaç ülkeden müşterim var

select count(distinct country) from customers

--63. Hangi ülkeden kaç müşterimiz var

select country, count(country) from customers
group by country

--64. 3 numaralı ID ye sahip çalışan (employee) son Ocak ayından BUGÜNE toplamda ne kadarlık ürün sattı?

select e.employee_id, e.first_name || ' ' || e.last_name as Name, round(sum(od.unit_price * od.quantity)) as "Toplam gelir" from employees e
inner join orders o
on o.employee_id = e.employee_id
inner join order_details od
on o.order_id = od.order_id
where e.employee_id = 3 and o.order_date between '1998-01-01' and '2023-11-03'
group by e.employee_id

select * from employees

--65. 10 numaralı ID ye sahip ürünümden son 3 ayda ne kadarlık ciro sağladım?

select round(sum(od.unit_price * od.quantity)) as "Ciro" from products p
inner join order_details od
on p.product_id = od.product_id
inner join orders o
on od.order_id = o.order_id
where p.product_id = 10 and o.order_date between '1998-02-06' and '1998-05-06'

select * from orders

--66. Hangi çalışan şimdiye kadar toplam kaç sipariş almış..?

select e.employee_id, (e.first_name || ' ' || e.last_name) as Fullname, count(e.employee_id) from employees e
inner join orders o
on e.employee_id = o.employee_id
group by e.employee_id

--67. 91 müşterim var. Sadece 89’u sipariş vermiş. Sipariş vermeyen 2 kişiyi bulun

select * from customers c
full join orders o
on c.customer_id = o.customer_id
where o.customer_id is null

--68. Brazil’de bulunan müşterilerin Şirket Adı, TemsilciAdi, Adres, Şehir, Ülke bilgileri

select company_name, contact_name, address, city, country from customers
where country like 'Bra%'

--69. Brezilya’da olmayan müşteriler

select company_name, contact_name, address, city, country from customers
where country not like 'Bra%'

--70. Ülkesi (Country) YA Spain, Ya France, Ya da Germany olan müşteriler

select company_name, country from customers
where country in('Germany', 'France', 'Spain')

--71. Faks numarasını bilmediğim müşteriler

select company_name from customers
where fax is null

--72. Londra’da ya da Paris’de bulunan müşterilerim

select company_name, city from customers
where city in('London', 'Paris')

--73. Hem Mexico D.F’da ikamet eden HEM DE ContactTitle bilgisi ‘owner’ olan müşteriler

select * from customers
where contact_title = 'Owner' and city = 'México D.F.'

--74. C ile başlayan ürünlerimin isimleri ve fiyatları

select product_name, unit_price from products
where product_name like 'C%'

--75. Adı (FirstName) ‘A’ harfiyle başlayan çalışanların (Employees); Ad, Soyad ve Doğum Tarihleri

select first_name, last_name, birth_date from employees
where first_name like 'A%'

--76. İsminde ‘RESTAURANT’ geçen müşterilerimin şirket adları

select * from customers
where company_name ilike '%RESTAURANT%'

--77. 50$ ile 100$ arasında bulunan tüm ürünlerin adları ve fiyatları

select product_name, unit_price from products
where unit_price between 50 and 100

--78. 1 temmuz 1996 ile 31 Aralık 1996 tarihleri arasındaki siparişlerin (Orders), SiparişID (OrderID) ve SiparişTarihi (OrderDate) bilgileri

select order_id, order_date from orders
where order_date between '1996-07-01' and '1996-12-31'

--79. Ülkesi (Country) YA Spain, Ya France, Ya da Germany olan müşteriler

select company_name from customers
where country in('Spain', 'France', 'Germany')

--80. Faks numarasını bilmediğim müşteriler

select company_name, fax from customers
where fax is null

--81. Müşterilerimi ülkeye göre sıralıyorum:

select * from customers
order by country desc

--82. Ürünlerimi en pahalıdan en ucuza doğru sıralama, sonuç olarak ürün adı ve fiyatını istiyoruz

select product_name, unit_price from products
order by unit_price desc

--83. Ürünlerimi en pahalıdan en ucuza doğru sıralasın, ama stoklarını küçükten-büyüğe doğru göstersin sonuç olarak ürün adı ve fiyatını istiyoruz

select product_name, unit_price, units_in_stock from products
order by unit_price desc, units_in_stock asc

--84. 1 Numaralı kategoride kaç ürün vardır..?

select count(*) from products p
inner join categories c
on c.category_id = p.category_id
where p.category_id = 1

--85. Kaç farklı ülkeye ihracat yapıyorum..?

select count(distinct ship_country) from orders
