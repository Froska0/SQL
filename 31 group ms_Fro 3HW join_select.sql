select * from employees;
select * from salary;
select * from employee_salary;
select * from roles;
select * from roles_employee;

select roles.id, role_name, salary.id, monthly_salary, employees.id, employee_name
from roles
full join roles_employee on roles.id = roles_employee.role_id
full join employees on roles_employee.employee_id = employees.id 
full join employee_salary on employees.id = employee_salary.employee_id 
full join salary on employee_salary.salary_id = salary.id
order by employees.id

 --1. Вывести всех работников чьи зарплаты есть в базе, вместе с зарплатами.
select employee_name, monthly_salary
from employees
join employee_salary on employees.id = employee_salary.employee_id 
join salary on employee_salary.salary_id = salary.id
order by employee_name;

-- 2. Вывести всех работников у которых ЗП меньше 2000.
select employee_name, monthly_salary
from employees
join employee_salary on employees.id = employee_salary.employee_id 
join salary on employee_salary.salary_id = salary.id
where monthly_salary < 2000
order by employee_name;

-- 3. Вывести все зарплатные позиции, но работник по ним не назначен. (ЗП есть, но не понятно кто её получает.)
select monthly_salary, employee_name
from salary
join employee_salary on  salary.id = employee_salary.salary_id 
left join employees on employee_salary.employee_id = employees.id
where employee_name is null;

-- 4. Вывести все зарплатные позиции  меньше 2000 но работник по ним не назначен. (ЗП есть, но не понятно кто её получает.)
select monthly_salary, employee_name
from salary
join employee_salary on  salary.id = employee_salary.salary_id 
left join employees on employee_salary.employee_id = employees.id
where employee_name is null and monthly_salary < 2000;

--5. Найти всех работников кому не начислена ЗП.
select employee_name, monthly_salary
from employees e 
left join employee_salary es on e.id = es.employee_id 
left join salary s on es.salary_id = s.id 
where monthly_salary is null 
order by employee_name;

--6. Вывести всех работников с названиями их должности.
select employee_name, role_name
from employees e 
left join roles_employee re on e.id = re.employee_id 
left join roles r on re.role_id = r.id 
order by employee_name;

--7. Вывести имена и должность только Java разработчиков.
select employee_name, role_name
from employees e 
left join roles_employee re on e.id = re.employee_id 
left join roles r on re.role_id = r.id
where role_name LIKE '%Java developer'
order by role_name;

 --8. Вывести имена и должность только Python разработчиков.
select employee_name, role_name
from employees e 
left join roles_employee re on e.id = re.employee_id 
left join roles r on re.role_id = r.id
where role_name LIKE '%Python developer'
order by role_name;

 --9. Вывести имена и должность всех QA инженеров.
select employee_name, role_name
from employees e 
left join roles_employee re on e.id = re.employee_id 
left join roles r on re.role_id = r.id
where role_name LIKE '%QA engineer'
order by role_name;


 --10. Вывести имена и должность ручных QA инженеров.
select employee_name, role_name
from employees e 
left join roles_employee re on e.id = re.employee_id 
left join roles r on re.role_id = r.id
where role_name LIKE '%Manual QA engineer'
order by role_name;

 --11. Вывести имена и должность автоматизаторов QA
select employee_name, role_name
from employees e 
left join roles_employee re on e.id = re.employee_id 
left join roles r on re.role_id = r.id
where role_name LIKE '%Automation QA engineer'
order by role_name;

 --12. Вывести имена и зарплаты Junior специалистов
--вариант 1 через вложенный запрос (так быстрее запрос обработается на сервере)
select employee_name, monthly_salary
from employees
left join employee_salary on employees.id = employee_salary.employee_id 
left join salary on employee_salary.salary_id = salary.id
where employee_name in
(select employee_name
from employees e 
left join roles_employee re on e.id = re.employee_id 
left join roles r on re.role_id = r.id
where role_name LIKE '%Junior%')
order by employee_name;

 --12. Вывести имена и зарплаты Junior специалистов
--вариант 2 через join всех таблиц, если требуется указать role_name
select role_name, monthly_salary, employee_name
from roles
join roles_employee on roles.id = roles_employee.role_id
join employees on roles_employee.employee_id = employees.id 
left join employee_salary on employees.id = employee_salary.employee_id 
left join salary on employee_salary.salary_id = salary.id
where role_name LIKE '%Junior%'
order by employee_name;

 --13. Вывести имена и зарплаты Middle специалистов
select role_name, monthly_salary, employee_name
from roles
join roles_employee on roles.id = roles_employee.role_id
join employees on roles_employee.employee_id = employees.id 
left join employee_salary on employees.id = employee_salary.employee_id 
left join salary on employee_salary.salary_id = salary.id
where role_name LIKE '%Middle%'
order by employee_name;

 --14. Вывести имена и зарплаты Senior специалистов
select role_name, monthly_salary, employee_name
from roles
join roles_employee on roles.id = roles_employee.role_id
join employees on roles_employee.employee_id = employees.id 
left join employee_salary on employees.id = employee_salary.employee_id 
left join salary on employee_salary.salary_id = salary.id
where role_name LIKE '%Senior%'
order by employee_name;

 --15. Вывести зарплаты Java разработчиков
select role_name, monthly_salary
from roles
join roles_employee on roles.id = roles_employee.role_id
join employees on roles_employee.employee_id = employees.id 
left join employee_salary on employees.id = employee_salary.employee_id 
left join salary on employee_salary.salary_id = salary.id
where role_name LIKE '%Java developer%'
order by role_name;

 --16. Вывести зарплаты Python разработчиков
select role_name, monthly_salary
from roles
join roles_employee on roles.id = roles_employee.role_id
join employees on roles_employee.employee_id = employees.id 
left join employee_salary on employees.id = employee_salary.employee_id 
left join salary on employee_salary.salary_id = salary.id
where role_name LIKE '%Python developer%'
order by role_name;

 --17. Вывести имена и зарплаты Junior Python разработчиков
select role_name, monthly_salary, employee_name
from roles
join roles_employee on roles.id = roles_employee.role_id
join employees on roles_employee.employee_id = employees.id 
left join employee_salary on employees.id = employee_salary.employee_id 
left join salary on employee_salary.salary_id = salary.id
where role_name = 'Junior Python developer'
order by employee_name;

 --18. Вывести имена и зарплаты Middle JS разработчиков
select role_name, monthly_salary, employee_name
from roles
join roles_employee on roles.id = roles_employee.role_id
join employees on roles_employee.employee_id = employees.id 
left join employee_salary on employees.id = employee_salary.employee_id 
left join salary on employee_salary.salary_id = salary.id
where role_name = 'Middle JavaScript developer'
order by employee_name;

 --19. Вывести имена и зарплаты Senior Java разработчиков
select role_name, monthly_salary, employee_name
from roles
join roles_employee on roles.id = roles_employee.role_id
join employees on roles_employee.employee_id = employees.id 
left join employee_salary on employees.id = employee_salary.employee_id 
left join salary on employee_salary.salary_id = salary.id
where role_name = 'Senior Java developer'
order by employee_name;

 --20. Вывести зарплаты Junior QA инженеров
select role_name, monthly_salary
from roles
join roles_employee on roles.id = roles_employee.role_id
join employees on roles_employee.employee_id = employees.id 
left join employee_salary on employees.id = employee_salary.employee_id 
left join salary on employee_salary.salary_id = salary.id
where role_name LIKE '%Junior % QA engineer%'
order by role_name;

--21. Вывести среднюю зарплату всех Junior специалистов
select avg(monthly_salary)
from roles
join roles_employee on roles.id = roles_employee.role_id
join employees on roles_employee.employee_id = employees.id 
left join employee_salary on employees.id = employee_salary.employee_id 
left join salary on employee_salary.salary_id = salary.id
where role_name LIKE '%Junior%%';

-- 22. Вывести сумму зарплат JS разработчиков
select sum(monthly_salary)
from roles
join roles_employee on roles.id = roles_employee.role_id
join employees on roles_employee.employee_id = employees.id 
left join employee_salary on employees.id = employee_salary.employee_id 
left join salary on employee_salary.salary_id = salary.id
where role_name LIKE '%JavaScript dev%';
 
-- 23. Вывести минимальную ЗП QA инженеров
select min(monthly_salary)
from roles
join roles_employee on roles.id = roles_employee.role_id
join employees on roles_employee.employee_id = employees.id 
left join employee_salary on employees.id = employee_salary.employee_id 
left join salary on employee_salary.salary_id = salary.id
where role_name LIKE '%QA%engineer%';
 
 --24. Вывести максимальную ЗП QA инженеров
select max(monthly_salary)
from roles
join roles_employee on roles.id = roles_employee.role_id
join employees on roles_employee.employee_id = employees.id 
left join employee_salary on employees.id = employee_salary.employee_id 
left join salary on employee_salary.salary_id = salary.id
where role_name LIKE '%QA%engineer%'; 

-- 25. Вывести количество QA инженеров
select count(role_name)
from employees e 
left join roles_employee re on e.id = re.employee_id 
left join roles r on re.role_id = r.id
where role_name LIKE '%QA engineer'; 
 
-- 26. Вывести количество Middle специалистов.
select count(role_name)
from employees e 
left join roles_employee re on e.id = re.employee_id 
left join roles r on re.role_id = r.id
where role_name LIKE '%Middle%'; 
 
-- 27. Вывести количество разработчиков
select count(role_name)
from employees e 
left join roles_employee re on e.id = re.employee_id 
left join roles r on re.role_id = r.id
where role_name LIKE '%Middle%';
 
--28. Вывести фонд (сумму) зарплаты разработчиков.
select sum(monthly_salary)
from roles
join roles_employee on roles.id = roles_employee.role_id
join employees on roles_employee.employee_id = employees.id 
left join employee_salary on employees.id = employee_salary.employee_id 
left join salary on employee_salary.salary_id = salary.id
where role_name LIKE '%developer%';
 
--29. Вывести имена, должности и ЗП всех специалистов по возрастанию
select employee_name, role_name, monthly_salary 
from roles
join roles_employee on roles.id = roles_employee.role_id
full join employees on roles_employee.employee_id = employees.id 
full join employee_salary on employees.id = employee_salary.employee_id 
left join salary on employee_salary.salary_id = salary.id
order by monthly_salary; 

 --30. Вывести имена, должности и ЗП всех специалистов по возрастанию у специалистов у которых ЗП от 1700 до 2300
select employee_name, role_name, monthly_salary 
from roles
join roles_employee on roles.id = roles_employee.role_id
full join employees on roles_employee.employee_id = employees.id 
full join employee_salary on employees.id = employee_salary.employee_id 
left join salary on employee_salary.salary_id = salary.id
where monthly_salary between 1700 and 2300
order by monthly_salary; 

 --31. Вывести имена, должности и ЗП всех специалистов по возрастанию у специалистов у которых ЗП меньше 2300
select employee_name, role_name, monthly_salary 
from roles
join roles_employee on roles.id = roles_employee.role_id
full join employees on roles_employee.employee_id = employees.id 
full join employee_salary on employees.id = employee_salary.employee_id 
left join salary on employee_salary.salary_id = salary.id
where monthly_salary < 2300
order by monthly_salary; 

 --32. Вывести имена, должности и ЗП всех специалистов по возрастанию у специалистов у которых ЗП равна 1100, 1500, 2000
select employee_name, role_name, monthly_salary 
from roles
join roles_employee on roles.id = roles_employee.role_id
full join employees on roles_employee.employee_id = employees.id 
full join employee_salary on employees.id = employee_salary.employee_id 
left join salary on employee_salary.salary_id = salary.id
where monthly_salary in (1100, 1500, 2000)
order by monthly_salary; 




