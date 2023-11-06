--87. En Pahalı 5 ürün
select product_name, unit_price from products
order by unit_price desc limit 5

--88. ALFKI CustomerID’sine sahip müşterimin sipariş sayısı..?
select * from orders
where exists (select customers.customer_id from customers
				where customers.customer_id = orders.customer_id and
				customers.customer_id = 'ALFKI')

--89. Ürünlerimin toplam maliyeti
select sum(unit_price * units_in_stock) from products

--90. Şirketim, şimdiye kadar ne kadar ciro yapmış..?
select sum(unit_price * quantity) from order_details

--91. Ortalama Ürün Fiyatım
select avg(unit_price) from products

--92. En Pahalı Ürünün Adı
select product_name from products
where unit_price = any(select max(unit_price) from products)

--93. En az kazandıran sipariş
select min(unit_price * quantity) from order_details

--94. Müşterilerimin içinde en uzun isimli müşteri
select company_name from customers
where length(company_name) = all(select max(length(company_name)) from customers)

--95. Çalışanlarımın Ad, Soyad ve Yaşları
select first_name, last_name, (date_part('year',current_date)-date_part('year',birth_date)) as Age from employees

--96. Hangi üründen toplam kaç adet alınmış..?
select p.product_name, od.quantity from order_details od
inner join products p
on p.product_id = od.product_id

--97. Hangi siparişte toplam ne kadar kazanmışım..?
select order_id, sum(unit_price * quantity) as kazanc from order_details
group by order_id
order by kazanc desc

--98. Hangi kategoride toplam kaç adet ürün bulunuyor..?
select category_id, count(product_id) from products
where category_id = all(select category_id from categories
					   where categories.category_id = products.category_id)
group by products.category_id


select category_name, count(product_id) from products p
inner join categories c
on c.category_id = p.category_id
group by category_name

--99. 1000 Adetten fazla satılan ürünler?
select product_name, sum(od.quantity) from products p
inner join order_details od
on od.product_id = p.product_id
group by p.product_name, od.product_id
having sum(od.quantity) > 1000

--100. Hangi Müşterilerim hiç sipariş vermemiş..?
select * from customers
where customer_id != all(select customer_id from orders)

select * from customers c
full join orders o
on c.customer_id = o.customer_id
where o.customer_id is null

--101. Hangi tedarikçi hangi ürünü sağlıyor ?
select company_name, p.product_name from suppliers s
inner join products p
on p.supplier_id = s.supplier_id
order by company_name

--102. Hangi sipariş hangi kargo şirketi ile ne zaman gönderilmiş..?
select o.order_id, sh.company_name, o.shipped_date from shippers sh
inner join orders o
on o.ship_via = sh.shipper_id

--103. Hangi siparişi hangi müşteri verir..?
select company_name, o.order_id from customers c
inner join orders o
on o.customer_id = c.customer_id

--104. Hangi çalışan, toplam kaç sipariş almış..?
select first_name, last_name, count(*) from employees e
inner join orders o
on e.employee_id = o.employee_id
group by e.employee_id

--105. En fazla siparişi kim almış..?
select first_name, last_name, count(*) from employees e
inner join orders o
on e.employee_id = o.employee_id
group by e.employee_id
order by count desc limit 1

--106. Hangi siparişi, hangi çalışan, hangi müşteri vermiştir..?
select e.first_name, e.last_name, company_name, o.order_id from customers c
inner join orders o
on o.customer_id = c.customer_id
inner join employees e
on o.employee_id = e.employee_id

--107. Hangi ürün, hangi kategoride bulunmaktadır..? Bu ürünü kim tedarik etmektedir..?
select p.product_name, c.category_name, s.company_name from products p
inner join suppliers s
on s.supplier_id = p.supplier_id
inner join categories c
on p.category_id = c.category_id

--108. Hangi siparişi hangi müşteri vermiş, hangi çalışan almış, hangi tarihte, hangi kargo şirketi tarafından gönderilmiş hangi üründen kaç adet alınmış, hangi fiyattan alınmış, ürün hangi kategorideymiş bu ürünü hangi tedarikçi sağlamış

select o.order_id as "OrderID", cu.company_name as "Customer",
	(e.first_name||' '||e.last_name) as "Employee",
	o.shipped_date as "ShippedDate", sh.company_name as "Shipper",
	p.product_name as "Product", od.quantity as "Quantity",
	od.unit_price as "UnitPrice", cat.category_name as "Category", 
	s.company_name as "Supplier" from customers cu
inner join orders o
on o.customer_id = cu.customer_id
inner join employees e
on o.employee_id = e.employee_id
inner join shippers sh
on sh.shipper_id = o.ship_via
inner join order_details od
on od.order_id = o.order_id
inner join products p
on p.product_id = od.product_id
inner join categories cat
on p.category_id = cat.category_id
inner join suppliers s
on s.supplier_id = p.supplier_id

--109. Altında ürün bulunmayan kategoriler
select category_name from categories
where not exists (select products.category_id from products)

select category_name from categories
where category_id = any(select products.category_id from products
						where units_in_stock = 0)

--110. Manager ünvanına sahip tüm müşterileri listeleyiniz.
select * from customers
where contact_title like '%Manager%'

--111. FR ile başlayan 5 karekter olan tüm müşterileri listeleyiniz.
select * from customers
where customer_id like 'FR%___'

--112. (171) alan kodlu telefon numarasına sahip müşterileri listeleyiniz.
select * from customers
where phone like '(171)%'

--113. BirimdekiMiktar alanında boxes geçen tüm ürünleri listeleyiniz.
select * from products
where quantity_per_unit like '%boxes%'

--114. Fransa ve Almanyadaki (France,Germany) Müdürlerin (Manager) Adını ve Telefonunu listeleyiniz.(MusteriAdi,Telefon)
select contact_name, phone from customers
where country in('France', 'Germany') and
contact_title like '%Manager%'

--115. En yüksek birim fiyata sahip 10 ürünü listeleyiniz.
select * from products
order by unit_price desc limit 10

--116. Müşterileri ülke ve şehir bilgisine göre sıralayıp listeleyiniz.
select * from customers
order by country, city 

--117. Personellerin ad,soyad ve yaş bilgilerini listeleyiniz.
select first_name, last_name, (date_part('year',current_date)-date_part('year',birth_date)) as Age from employees

--118. 35 gün içinde sevk edilmeyen satışları listeleyiniz.
select * from orders
where (shipped_date - order_date) = 35

--119. Birim fiyatı en yüksek olan ürünün kategori adını listeleyiniz. (Alt Sorgu)
select category_name from categories
where category_id = any(select products.category_id from products
						order by unit_price desc limit 1)

--120. Kategori adında 'on' geçen kategorilerin ürünlerini listeleyiniz. (Alt Sorgu)
select * from products
where category_id = any(select category_id from categories
					   where category_name like '%on%')

--121. Konbu adlı üründen kaç adet satılmıştır.
select sum(quantity) from order_details
where product_id = any(select product_id from products
					  where product_name = 'Konbu')

--122. Japonyadan kaç farklı ürün tedarik edilmektedir.
select count(*) from products
where supplier_id = any(select supplier_id from suppliers
					  where country = 'Japan')

--123. 1997 yılında yapılmış satışların en yüksek, en düşük ve ortalama nakliye ücretlisi ne kadardır?
select min(freight) as "En düşük", max(freight) as "En yüksek", avg(freight) as "Ortalama" from orders
where date_part('year', order_date) = 1997

--124. Faks numarası olan tüm müşterileri listeleyiniz.
select * from customers
where fax is not null

--125. 1996-07-16 ile 1996-07-30 arasında sevk edilen satışları listeleyiniz.
select * from orders
where shipped_date between '1996-07-16' and '1996-07-30'
