-- Exercise: 1
-- Find the model number, speed and hard drive capacity for all the PCs with prices below $500.
-- Result set: model, speed, hd.
    
select model, speed, hd
from PC
where price <500
  
-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    
-- Exercise: 2
-- List all printer makers. Result set: maker. 
  
select DISTINCT maker from Product
where type = 'Printer'
  
-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    
-- Exercise: 3
-- Find the model number, RAM and screen size of the laptops with prices over $1000. 

Select model, ram, screen from Laptop
where price > 1000

-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    
-- Exercise: 4
-- Find all records from the Printer table containing data about color printers. 

Select * from Printer
where color = 'y'
  
-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    
-- Exercise: 5
-- Find the model number, speed and hard drive capacity of PCs cheaper than $600 having a 12x or a 24x CD drive.   
  
Select model, speed, hd from PC
where price < 600 and (cd = '12x' or cd = '24x')  
  
-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    
-- Exercise: 6  
-- For each maker producing laptops with a hard drive capacity of 10 Gb or higher, find the speed of such laptops. Result set: maker, speed.   
  
select DISTINCT maker, speed from Product
join Laptop on Product.model = Laptop.model
where hd >= 10  
  
-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    
-- Exercise: 7 
-- Get the models and prices for all commercially available products (of any type) produced by maker B.   
  
select model, price from PC
where model in
(SELECT model from Product
where maker = 'B')
union
select model, price from Laptop
where model in
(SELECT model from Product
where maker = 'B')
union
select model, price from Printer
where model in
(SELECT model from Product
where maker = 'B')  
  
-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    
-- Exercise:8
-- Find the makers producing PCs but not laptops.  
    
SELECT DISTINCT maker
FROM Product
WHERE type = 'PC' AND 
maker NOT IN (SELECT maker 
FROM Product 
WHERE type = 'Laptop')  
  
-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    
-- Exercise:9  
-- Find the makers of PCs with a processor speed of 450 MHz or more. Result set: maker.   
  
select DISTINCT maker from Product
where model in
(select model from PC
where speed >=450)  
  
-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    
-- Exercise:10  
-- Find the printer models having the highest price. Result set: model, price.   
  
select model,price from Printer
where price = 
(select max(price) from Printer)  
  
-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    
-- Exercise:11  
-- Find out the average speed of PCs.   
  
Select avg(speed) from PC  
  
-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    
-- Exercise:12  
-- Find out the average speed of the laptops priced over $1000.  
  
select avg(speed) from Laptop
where price >1000  
  
-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    
-- Exercise:13  
-- Find out the average speed of the PCs produced by maker A.   
  
select avg(speed) AS Avg_speed from PC
where model in
(select model from Product
where maker = 'A')  
  
-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    
-- Exercise:14  
-- For the ships in the Ships table that have at least 10 guns, get the class, name, and country.  
  
select Ships.class, name, country
from Ships
join Classes on Ships.class = Classes.class
where numGuns >=10  
  
-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    
-- Exercise:15  
-- Get hard drive capacities that are identical for two or more PCs.
-- Result set: hd.   
  
select hd from PC
group by hd
having count(hd) > 1  
  
-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    
-- Exercise:16  
-- Get pairs of PC models with identical speeds and the same RAM capacity. Each resulting pair should be displayed only once, i.e. (i, j) but not (j, i).
-- Result set: model with the bigger number, model with the smaller number, speed, and RAM.   
  
select distinct A.model AS model_1, B.model AS model_2, A.speed, A.ram
    from PC AS A, PC B
    where A.speed = B.speed AND 
          A.ram = B.ram AND 
          A.model > B.model  
  
-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    
-- Exercise:17
-- Get the laptop models that have a speed smaller than the speed of any PC.
-- Result set: type, model, speed.   
  
select distinct type, Laptop.model, speed from Laptop
join Product on Laptop.model = Product.model
where speed <
all (select speed from PC)  
  
-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    
-- Exercise:18  
-- Find the makers of the cheapest color printers.
-- Result set: maker, price.  
  
select distinct product.maker, printer.price
from product, printer
where product.model = printer.model
and printer.color = 'y'
and printer.price = (
select min(price) from printer
where printer.color = 'y'
)  
  
-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    
-- Exercise:19 
-- For each maker having models in the Laptop table, find out the average screen size of the laptops he produces.
-- Result set: maker, average screen size.   
  
select DISTINCT maker, AVG(screen)
from Product
join Laptop on Product.model = Laptop.model
group BY maker  
  
-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    
-- Exercise:20
-- Find the makers producing at least three distinct models of PCs.
-- Result set: maker, number of PC models.

select maker, count(model)
from product
where type='pc'
group by maker
having count(model)>=3

-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    
-- Exercise:21
-- Find out the maximum PC price for each maker having models in the PC table. Result set: maker, maximum price. 

select maker, max(price)
from Product
join PC on product.model = pc.model
group by maker

-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    
-- Exercise:22
-- For each value of PC speed that exceeds 600 MHz, find out the average price of PCs with identical speeds.
-- Result set: speed, average price. 

select speed, avg(price) from PC
group by speed
having speed in (
select distinct(speed) from PC 
where speed > 600)

-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    
-- Exercise:23
-- Get the makers producing both PCs having a speed of 750 MHz or higher and laptops with a speed of 750 MHz or higher.
-- Result set: maker 

select maker 
from Product join PC on Product.model = PC.model 
where speed >= 750  
intersect  
select maker 
from Product join Laptop on Product.model = Laptop.model   
where speed >= 750

-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    
-- Exercise:24
-- List the models of any type having the highest price of all products present in the database. 

select model from
(select price, model from PC
union
select price, model from Laptop
union
select price, model from Printer) querry_1
where price = 
(select max(price)
from
(select price, model from PC
union
select price, model from Laptop
union
select price, model from Printer) querry_1)

-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    
-- Exercise:25
-- Find the printer makers also producing PCs with the lowest RAM capacity and the highest processor speed of all PCs having the lowest RAM capacity.
-- Result set: maker. 

select distinct maker from Product
where type = 'PC' and model in
(select model from PC where speed in
(select max(speed) from PC where ram =
(select min(ram) from PC))
and ram in (select min(ram) from PC))
intersect
select distinct maker from Product
where type = 'Printer'

-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    
-- Exercise:26
-- Find out the average price of PCs and laptops produced by maker A.
-- Result set: one overall average price for all items. 

select avg(price)
from
(select price from PC
join Product on PC.model = Product.model
where maker = 'A'
union all
select price from Laptop
join Product on Laptop.model = Product.model
where maker = 'A') querry_in

-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    
-- Exercise:27
-- Find out the average hard disk drive capacity of PCs produced by makers who also manufacture printers.
-- Result set: maker, average HDD capacity. 

select maker, avg(hd)
from Product
join PC on Product.model = PC.model
where maker in(
select maker from product 
where type = 'Printer')
group by maker

-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    
-- Exercise:28
-- Using Product table, find out the number of makers who produce only one model.

select count(maker)
from 
(Select maker from Product
group by maker
having count(model) = 1) querry_1
