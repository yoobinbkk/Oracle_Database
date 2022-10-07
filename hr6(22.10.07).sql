

select index_name, index_type
from user_indexes
where table_name='EMPLOYEES';

-- �ڵ� ���� �� ��
-- ������ ���� �ֱ�
-- sqlplus ��/as sysdba��
-- grant SELECT_CATALOG_ROLE to HR
-- grant SELECT ANY DICTIONARY to HR

--���� �� (�޸𸮿� ���� ��)
SELECT employee_id, first_name, last_name, phone_number FROM employees
WHERE salary=3000;

-- pk�� �ڵ� �����ߴµ� ����
SELECT employee_id, first_name, last_name, phone_number FROM employees
WHERE employee_id=8000;

-- salary�� index�� �����
create index idx_emp_salary on employees (salary);

-- �ӵ��� �� ������
SELECT employee_id, first_name, last_name, phone_number FROM employees
WHERE salary=3000;

commit;

--------------------------------------------------

-- [��] SQL

-- 1.
select ename, eno, hiredate, salary
from employee
where salary between (2000) and (3000);

select LAST_NAME, EMPLOYEE_ID, HIRE_DATE, salary
from employees
where salary between (2000) and (3000);

-- 2.
select ename, hiredate, dno
from employee
where commission is null
order by dno desc, ename desc;

select LAST_NAME, hire_date, DEPARTMENT_ID
from employees
where COMMISSION_PCT is null
order by DEPARTMENT_ID desc, LAST_NAME desc;

-- 3.
select eno, ename, salary, commission
from employee
where commission in (300, 500, 1400)
order by commission desc;

-- 4.
select ename
from employee
where ename like 'S%';

-- 5.
select ename, hiredate
from employee
where hiredate not like '__81%';

-- 6.
select distinct dno
from employee
order by dno desc;

-- 7.
