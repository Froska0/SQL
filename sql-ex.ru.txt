Exercise: 1
Find the model number, speed and hard drive capacity for all the PCs with prices below $500.
Result set: model, speed, hd.
    
select model, speed, hd
from PC
where price <500
  
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    
Exercise: 2
List all printer makers. Result set: maker. 
  
select DISTINCT maker from Product
where type = 'Printer'
  
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    
Exercise: 3
Find the model number, RAM and screen size of the laptops with prices over $1000. 

Select model, ram, screen from Laptop
where price > 1000

+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    
Exercise: 4
Select * from Printer
where color = 'y'
  
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    
Exercise: 5
Find the model number, speed and hard drive capacity of PCs cheaper than $600 having a 12x or a 24x CD drive.   
  
Select model, speed, hd from PC
where price < 600 and (cd = '12x' or cd = '24x')  
  
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    
Exercise: 6  
For each maker producing laptops with a hard drive capacity of 10 Gb or higher, find the speed of such laptops. Result set: maker, speed.   
  
select DISTINCT maker, speed from Product
join Laptop on Product.model = Laptop.model
where hd >= 10  
  
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    
Exercise: 7 
Get the models and prices for all commercially available products (of any type) produced by maker B.   
  
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
  
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    
Exercise:8
Find the makers producing PCs but not laptops.  
    
SELECT DISTINCT maker
FROM Product
WHERE type = 'PC' AND 
maker NOT IN (SELECT maker 
FROM Product 
WHERE type = 'Laptop')  
  
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    
Exercise:9  
Find the makers of PCs with a processor speed of 450 MHz or more. Result set: maker.   
  
select DISTINCT maker from Product
where model in
(select model from PC
where speed >=450)  
  
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    
Exercise:10  
Find the printer models having the highest price. Result set: model, price.   
  
select model,price from Printer
where price = 
(select max(price) from Printer)  
  
  
  
  
  
  
  
