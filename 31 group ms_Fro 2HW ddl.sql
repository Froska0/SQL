--Создать таблицу employees
-- id. serial,  primary key,
-- employee_name. Varchar(50), not null
--Наполнить таблицу employee 70 строками.


create table employees(
	id serial PRIMARY KEY,
	employee_name Varchar(50) not null
);

select * from employees;

insert into employees(employee_name) values
	('Fro1'),
	('Fro2'),
	('Fro3'),
	('Fro4'),
	('Fro5'),
	('Fro6'),
	('Fro7'),
	('Fro8'),
	('Fro9'),
	('Fro10'),
	('Fro11'),
	('Fro12'),
	('Fro13'),
	('Fro14'),
	('Fro15'),
	('Fro16'),
	('Fro17'),
	('Fro18'),
	('Fro19'),
	('Fro20'),
	('Fro21'),
	('Fro22'),
	('Fro23'),
	('Fro24'),
	('Fro25'),
	('Fro26'),
	('Fro27'),
	('Fro28'),
	('Fro29'),
	('Fro30'),
	('Fro31'),
	('Fro32'),
	('Fro33'),
	('Fro34'),
	('Fro35'),
	('Fro36'),
	('Fro37'),
	('Fro38'),
	('Fro39'),
	('Fro40'),
	('Fro41'),
	('Fro42'),
	('Fro43'),
	('Fro44'),
	('Fro45'),
	('Fro46'),
	('Fro47'),
	('Fro48'),
	('Fro49'),
	('Fro50'),
	('Fro51'),
	('Fro52'),
	('Fro53'),
	('Fro54'),
	('Fro55'),
	('Fro56'),
	('Fro57'),
	('Fro58'),
	('Fro59'),
	('Fro60'),
	('Fro61'),
	('Fro62'),
	('Fro63'),
	('Fro64'),
	('Fro65'),
	('Fro66'),
	('Fro67'),
	('Fro68'),
	('Fro69'),
	('Fro70');

select * from employees;

--Создать таблицу salary
-- id. Serial  primary key,
-- monthly_salary. Int, not null
--Наполнить таблицу salary 15 строками:
-- 1000
-- 1100
-- 1200
-- 1300
-- 1400
-- 1500
-- 1600
-- 1700
-- 1800
-- 1900
-- 2000
-- 2100
-- 2200
-- 2300
-- 2400
-- 2500

create table salary(
	id serial PRIMARY KEY,
	monthly_salary int not null
);

select * from salary;

insert into salary(monthly_salary) values
	(1000),
	(1100),
	(1200),
	(1300),
	(1400),
	(1500),
	(1600),
	(1700),
	(1800),
	(1900),
	(2000),
	(2100),
	(2200),
	(2300),
	(2400),
	(2500);
	
select * from salary;

--Создать таблицу employee_salary
-- id. Serial  primary key,
-- employee_id. Int, not null, unique
-- salary_id. Int, not null

create table employee_salary(
	id serial PRIMARY KEY,
	employee_id int not null unique,
	salary_id Int not null
);

select * from employee_salary;

--Наполнить таблицу employee_salary 40 строками:
-- в 10 строк из 40 вставить несуществующие employee_id

insert into employee_salary(employee_id, salary_id) values
	(71, 16),
	(72, 14),
	(73, 12),
	(74, 10),
	(75, 8),
	(76, 6),
	(77, 4),
	(78, 2),
	(79, 1),
	(80, 3),
	(1, 5),
	(4, 7),
	(7, 9),
	(10, 11),
	(13, 13),
	(16, 15),
	(19, 1),
	(61, 2),
	(51, 3),
	(41, 4),
	(31, 5),
	(21, 6),
	(25, 7),
	(35, 8),
	(45, 9),
	(55, 10),
	(65, 11),
	(70, 12),
	(59, 13),
	(58, 14),
	(57, 15),
	(56, 16),
	(54, 15),
	(53, 14),
	(52, 13),
	(44, 12),
	(66, 11),
	(33, 8),
	(22, 3),
	(38, 6);
	
select * from employee_salary;

--Создать таблицу roles
-- id. Serial  primary key,
-- role_name. int, not null, unique

create table roles(
	id serial PRIMARY KEY,
	role_name int not null unique
);

select * from roles;

--Поменять тип столба role_name с int на varchar(30)

ALTER TABLE roles ALTER COLUMN role_name type Varchar(30);

select * from roles;

Наполнить таблицу roles 20 строками:

--id
--role_name
--1
--Junior Python developer
--2
--Middle Python developer
--3
--Senior Python developer
--4
--Junior Java developer
--5
--Middle Java developer
--6
--Senior Java developer
--7
--Junior JavaScript developer
--8
--Middle JavaScript developer
--9
--Senior JavaScript developer
--10
--Junior Manual QA engineer
--11
--Middle Manual QA engineer
--12
--Senior Manual QA engineer
--13
--Project Manager
--14
--Designer
--15
--HR
--16
--CEO
--17
--Sales manager
--18
--Junior Automation QA engineer
--19
--Middle Automation QA engineer
--20
--Senior Automation QA engineer

insert into roles(role_name) values
	('Junior Python developer'),
	('Middle Python developer'),
	('Senior Python developer'),
	('Junior Java developer'),
	('Middle Java developer'),
	('Senior Java developer'),
	('Junior JavaScript developer'),
	('Middle JavaScript developer'),
	('Senior JavaScript developer'),
	('Junior Manual QA engineer'),
	('Middle Manual QA engineer'),
	('Senior Manual QA engineer'),
	('Project Manager'),
	('Designer'),
	('HR'),
	('CEO'),
	('Sales manager'),
	('Junior Automation QA engineer'),
	('Middle Automation QA engineer'),
	('Senior Automation QA engineer');

select * from roles;

--Создать таблицу roles_employee
-- id. Serial  primary key,
-- employee_id. Int, not null, unique (внешний ключ для таблицы employees, поле id)
-- role_id. Int, not null (внешний ключ для таблицы roles, поле id)

create table roles_employee(
	id serial PRIMARY KEY,
	employee_id int not null unique, 
	role_id int not null,
	foreign key (employee_id) references employees(id),
	foreign key (role_id) references roles(id)
);

select * from roles_employee;

--Наполнить таблицу roles_employee 40 строками

insert into roles_employee(employee_id, role_id) values
	(2,20),
	(4,19),
	(6,18),
	(8,17),
	(10,16),
	(12,15),
	(14,14),
	(16,13),
	(18,12),
	(20,11),
	(22,10),
	(24,1),
	(26,2),
	(28,3),
	(30,4),
	(32,5),
	(34,6),
	(36,7),
	(38,8),
	(40,9),
	(68,15),
	(66,5),
	(64,11),
	(62,17),
	(61,16),
	(69,8),
	(67,2),
	(65,3),
	(63,20),
	(27,6),
	(59,14),
	(57,17),
	(55,19),
	(53,8),
	(51,13),
	(49,17),
	(47,12),
	(45,2),
	(43,9),
	(41,10);

select * from roles_employee;


