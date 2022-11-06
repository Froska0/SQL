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

 --1. ������� ���� ���������� ��� �������� ���� � ����, ������ � ����������.
select employee_name, monthly_salary
from employees
join employee_salary on employees.id = employee_salary.employee_id 
join salary on employee_salary.salary_id = salary.id
order by employee_name;

-- 2. ������� ���� ���������� � ������� �� ������ 2000.
select employee_name, monthly_salary
from employees
join employee_salary on employees.id = employee_salary.employee_id 
join salary on employee_salary.salary_id = salary.id
where monthly_salary < 2000
order by employee_name;

-- 3. ������� ��� ���������� �������, �� �������� �� ��� �� ��������. (�� ����, �� �� ������� ��� � ��������.)
select monthly_salary, employee_name
from salary
join employee_salary on  salary.id = employee_salary.salary_id 
left join employees on employee_salary.employee_id = employees.id
where employee_name is null;

-- 4. ������� ��� ���������� �������  ������ 2000 �� �������� �� ��� �� ��������. (�� ����, �� �� ������� ��� � ��������.)
select monthly_salary, employee_name
from salary
join employee_salary on  salary.id = employee_salary.salary_id 
left join employees on employee_salary.employee_id = employees.id
where employee_name is null and monthly_salary < 2000;

--5. ����� ���� ���������� ���� �� ��������� ��.
select employee_name, monthly_salary
from employees e 
left join employee_salary es on e.id = es.employee_id 
left join salary s on es.salary_id = s.id 
where monthly_salary is null 
order by employee_name;

--6. ������� ���� ���������� � ���������� �� ���������.
select employee_name, role_name
from employees e 
left join roles_employee re on e.id = re.employee_id 
left join roles r on re.role_id = r.id 
order by employee_name;

--7. ������� ����� � ��������� ������ Java �������������.
select employee_name, role_name
from employees e 
left join roles_employee re on e.id = re.employee_id 
left join roles r on re.role_id = r.id
where role_name LIKE '%Java developer'
order by role_name;

 --8. ������� ����� � ��������� ������ Python �������������.
select employee_name, role_name
from employees e 
left join roles_employee re on e.id = re.employee_id 
left join roles r on re.role_id = r.id
where role_name LIKE '%Python developer'
order by role_name;

 --9. ������� ����� � ��������� ���� QA ���������.
select employee_name, role_name
from employees e 
left join roles_employee re on e.id = re.employee_id 
left join roles r on re.role_id = r.id
where role_name LIKE '%QA engineer'
order by role_name;


 --10. ������� ����� � ��������� ������ QA ���������.
select employee_name, role_name
from employees e 
left join roles_employee re on e.id = re.employee_id 
left join roles r on re.role_id = r.id
where role_name LIKE '%Manual QA engineer'
order by role_name;

 --11. ������� ����� � ��������� ��������������� QA
select employee_name, role_name
from employees e 
left join roles_employee re on e.id = re.employee_id 
left join roles r on re.role_id = r.id
where role_name LIKE '%Automation QA engineer'
order by role_name;

 --12. ������� ����� � �������� Junior ������������
--������� 1 ����� ��������� ������ (��� ������� ������ ������������ �� �������)
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

 --12. ������� ����� � �������� Junior ������������
--������� 2 ����� join ���� ������, ���� ��������� ������� role_name
select role_name, monthly_salary, employee_name
from roles
join roles_employee on roles.id = roles_employee.role_id
join employees on roles_employee.employee_id = employees.id 
left join employee_salary on employees.id = employee_salary.employee_id 
left join salary on employee_salary.salary_id = salary.id
where role_name LIKE '%Junior%'
order by employee_name;

 --13. ������� ����� � �������� Middle ������������
select role_name, monthly_salary, employee_name
from roles
join roles_employee on roles.id = roles_employee.role_id
join employees on roles_employee.employee_id = employees.id 
left join employee_salary on employees.id = employee_salary.employee_id 
left join salary on employee_salary.salary_id = salary.id
where role_name LIKE '%Middle%'
order by employee_name;

 --14. ������� ����� � �������� Senior ������������
select role_name, monthly_salary, employee_name
from roles
join roles_employee on roles.id = roles_employee.role_id
join employees on roles_employee.employee_id = employees.id 
left join employee_salary on employees.id = employee_salary.employee_id 
left join salary on employee_salary.salary_id = salary.id
where role_name LIKE '%Senior%'
order by employee_name;

 --15. ������� �������� Java �������������
select role_name, monthly_salary
from roles
join roles_employee on roles.id = roles_employee.role_id
join employees on roles_employee.employee_id = employees.id 
left join employee_salary on employees.id = employee_salary.employee_id 
left join salary on employee_salary.salary_id = salary.id
where role_name LIKE '%Java developer%'
order by role_name;

 --16. ������� �������� Python �������������
select role_name, monthly_salary
from roles
join roles_employee on roles.id = roles_employee.role_id
join employees on roles_employee.employee_id = employees.id 
left join employee_salary on employees.id = employee_salary.employee_id 
left join salary on employee_salary.salary_id = salary.id
where role_name LIKE '%Python developer%'
order by role_name;

 --17. ������� ����� � �������� Junior Python �������������
select role_name, monthly_salary, employee_name
from roles
join roles_employee on roles.id = roles_employee.role_id
join employees on roles_employee.employee_id = employees.id 
left join employee_salary on employees.id = employee_salary.employee_id 
left join salary on employee_salary.salary_id = salary.id
where role_name = 'Junior Python developer'
order by employee_name;

 --18. ������� ����� � �������� Middle JS �������������
select role_name, monthly_salary, employee_name
from roles
join roles_employee on roles.id = roles_employee.role_id
join employees on roles_employee.employee_id = employees.id 
left join employee_salary on employees.id = employee_salary.employee_id 
left join salary on employee_salary.salary_id = salary.id
where role_name = 'Middle JavaScript developer'
order by employee_name;

 --19. ������� ����� � �������� Senior Java �������������
select role_name, monthly_salary, employee_name
from roles
join roles_employee on roles.id = roles_employee.role_id
join employees on roles_employee.employee_id = employees.id 
left join employee_salary on employees.id = employee_salary.employee_id 
left join salary on employee_salary.salary_id = salary.id
where role_name = 'Senior Java developer'
order by employee_name;

 --20. ������� �������� Junior QA ���������
select role_name, monthly_salary
from roles
join roles_employee on roles.id = roles_employee.role_id
join employees on roles_employee.employee_id = employees.id 
left join employee_salary on employees.id = employee_salary.employee_id 
left join salary on employee_salary.salary_id = salary.id
where role_name LIKE '%Junior % QA engineer%'
order by role_name;

--21. ������� ������� �������� ���� Junior ������������
select avg(monthly_salary)
from roles
join roles_employee on roles.id = roles_employee.role_id
join employees on roles_employee.employee_id = employees.id 
left join employee_salary on employees.id = employee_salary.employee_id 
left join salary on employee_salary.salary_id = salary.id
where role_name LIKE '%Junior%%';

-- 22. ������� ����� ������� JS �������������
select sum(monthly_salary)
from roles
join roles_employee on roles.id = roles_employee.role_id
join employees on roles_employee.employee_id = employees.id 
left join employee_salary on employees.id = employee_salary.employee_id 
left join salary on employee_salary.salary_id = salary.id
where role_name LIKE '%JavaScript dev%';
 
-- 23. ������� ����������� �� QA ���������
select min(monthly_salary)
from roles
join roles_employee on roles.id = roles_employee.role_id
join employees on roles_employee.employee_id = employees.id 
left join employee_salary on employees.id = employee_salary.employee_id 
left join salary on employee_salary.salary_id = salary.id
where role_name LIKE '%QA%engineer%';
 
 --24. ������� ������������ �� QA ���������
select max(monthly_salary)
from roles
join roles_employee on roles.id = roles_employee.role_id
join employees on roles_employee.employee_id = employees.id 
left join employee_salary on employees.id = employee_salary.employee_id 
left join salary on employee_salary.salary_id = salary.id
where role_name LIKE '%QA%engineer%'; 

-- 25. ������� ���������� QA ���������
select count(role_name)
from employees e 
left join roles_employee re on e.id = re.employee_id 
left join roles r on re.role_id = r.id
where role_name LIKE '%QA engineer'; 
 
-- 26. ������� ���������� Middle ������������.
select count(role_name)
from employees e 
left join roles_employee re on e.id = re.employee_id 
left join roles r on re.role_id = r.id
where role_name LIKE '%Middle%'; 
 
-- 27. ������� ���������� �������������
select count(role_name)
from employees e 
left join roles_employee re on e.id = re.employee_id 
left join roles r on re.role_id = r.id
where role_name LIKE '%Middle%';
 
--28. ������� ���� (�����) �������� �������������.
select sum(monthly_salary)
from roles
join roles_employee on roles.id = roles_employee.role_id
join employees on roles_employee.employee_id = employees.id 
left join employee_salary on employees.id = employee_salary.employee_id 
left join salary on employee_salary.salary_id = salary.id
where role_name LIKE '%developer%';
 
--29. ������� �����, ��������� � �� ���� ������������ �� �����������
select employee_name, role_name, monthly_salary 
from roles
join roles_employee on roles.id = roles_employee.role_id
full join employees on roles_employee.employee_id = employees.id 
full join employee_salary on employees.id = employee_salary.employee_id 
left join salary on employee_salary.salary_id = salary.id
order by monthly_salary; 

 --30. ������� �����, ��������� � �� ���� ������������ �� ����������� � ������������ � ������� �� �� 1700 �� 2300
select employee_name, role_name, monthly_salary 
from roles
join roles_employee on roles.id = roles_employee.role_id
full join employees on roles_employee.employee_id = employees.id 
full join employee_salary on employees.id = employee_salary.employee_id 
left join salary on employee_salary.salary_id = salary.id
where monthly_salary between 1700 and 2300
order by monthly_salary; 

 --31. ������� �����, ��������� � �� ���� ������������ �� ����������� � ������������ � ������� �� ������ 2300
select employee_name, role_name, monthly_salary 
from roles
join roles_employee on roles.id = roles_employee.role_id
full join employees on roles_employee.employee_id = employees.id 
full join employee_salary on employees.id = employee_salary.employee_id 
left join salary on employee_salary.salary_id = salary.id
where monthly_salary < 2300
order by monthly_salary; 

 --32. ������� �����, ��������� � �� ���� ������������ �� ����������� � ������������ � ������� �� ����� 1100, 1500, 2000
select employee_name, role_name, monthly_salary 
from roles
join roles_employee on roles.id = roles_employee.role_id
full join employees on roles_employee.employee_id = employees.id 
full join employee_salary on employees.id = employee_salary.employee_id 
left join salary on employee_salary.salary_id = salary.id
where monthly_salary in (1100, 1500, 2000)
order by monthly_salary; 




