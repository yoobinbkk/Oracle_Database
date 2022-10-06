-- [���� 2] <��������>
-- hr database / employees table

-- 1. Zlotkey�� ������ �μ��� ���� ��� ����� �̸��� �Ի����� ǥ���ϴ� ���Ǹ� �ۼ��Ͻʽÿ�. 
   -- Zlotkey�� �����Ͻʽÿ�.
   
select first_name || ' ' || last_name name, hire_date, department_id
from employees
where department_id = (select department_id from employees where last_name='Zlotkey')
    and last_name != 'Zlotkey';

-- 2. �޿��� ��� �޿����� ���� ��� ����� ��� ��ȣ�� �̸��� ǥ���ϴ� ���Ǹ� �ۼ��ϰ� 
   -- ����� �޿��� ���� ������������ �����Ͻʽÿ�.

select EMPLOYEE_ID, first_name || ' ' || last_name name, salary
from employees
where salary > (select avg(salary) from employees)
order by salary desc;

select avg(salary)
from employees;

-- 3. �̸��� u�� ���Ե� ����� ���� �μ����� ���ϴ� ��� ����� ��� ��ȣ�� �̸��� ǥ���ϴ� ���Ǹ� �ۼ��Ͻʽÿ�.
select EMPLOYEE_ID, first_name || ' ' || last_name name, department_id
from employees
-- where department_id in (select department_id from employees where first_name like '%u%' or last_name like '%u%');
where department_id in (select department_id from employees where first_name || ' ' || last_name like '%u%');

-- 4. �μ� ��ġ ID�� 1700�� ��� ����� �̸�, �μ� ��ȣ �� ���� ID�� ǥ���Ͻʽÿ�.
select first_name || ' ' || last_name name, department_id, JOB_ID
from employees
where department_id in (select department_id from departments where location_id = 1700);

-- 5. King���� �����ϴ� ��� ����� �̸��� �޿��� ǥ���Ͻʽÿ�.
select first_name || ' ' || last_name name, salary, manager_id
from employees
where manager_id in (select employee_id from employees e2 where last_name = 'King');

-- 6. Executive �μ��� ��� ����� ���� �μ� ��ȣ, �̸� �� ���� ID�� ǥ���Ͻʽÿ�.
select department_id, first_name || ' ' || last_name name, job_id
from employees
where department_id in (select department_id from departments where department_name = 'Executive');

-- 7. ��� �޿����� ���� �޿��� �ް� �̸��� u�� ���Ե� ����� ���� �μ����� �ٹ��ϴ� ��� ����� ��� ��ȣ, �̸� �� �޿��� ǥ���ϴ� ���Ǹ� �ۼ��Ͻʽÿ�.
select EMPLOYEE_ID, first_name || ' ' || last_name name, salary, department_id
from employees
where salary > (select avg(salary) from employees)
    and department_id in (select department_id from employees where first_name || ' ' || last_name like '%u%');
    
select first_name || ' ' || last_name name, department_id
from employees
where first_name || ' ' || last_name like '%u%'
order by department_id;


