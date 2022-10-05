--1. �̸��� ���� 'King' ����� ����� �μ����� ��� ( employees, departments )
select e.employee_id id, d.department_name dname
from employees e inner join departments d
on e.department_id = d.department_id and e.last_name = 'King';

--2. �̸��� ���� 'King' ����� ����� �μ��� �׸��� �������� ��� ( employees, departments, jobs )
select e.employee_id id, d.department_name dname, j.job_title jobname
from employees e, departments d, jobs j 
where e.department_id = d.department_id 
      and e.job_id = j.job_id
      and e.last_name = 'King';

select e.employee_id id, d.department_name dname, j.job_title jobname
from employees e inner join departments d on e.department_id = d.department_id 
                 inner join jobs j on e.job_id = j.job_id
where e.last_name = 'King';
                 
--3. 2007�� ��ݱ⿡ �Ի��� ������� ����� �̸�, �Ի��� �׸��� �μ����� ���
    --(*) Grant�� ���� �μ��� �������� ���� ���������� Grant�� ��µǷ���
select e.employee_id id, e.first_name || ' ' || e.last_name ename, e.hire_date hiredate, d.department_name dname
from employees e, departments d
where e.department_id = d.department_id(+) and hire_date between '2007/01/01' and '2007/06/30';

select e.employee_id id, e.first_name || ' ' || e.last_name ename, e.hire_date hiredate, d.department_name dname
from employees e left outer join departments d
on e.department_id = d.department_id 
where hire_date between '2007/01/01' and '2007/06/30';

--4. 'Executive' �μ����� ����� �ش� ����� �Ŵ���(���) �̸��� ���
    --(*) �Ŵ���(���)�� ���� ����� 'King'�� ��µǷ���
select e1.first_name || ' ' || e1.last_name ename, e2.first_name || ' ' || e2.last_name mgrname
from employees e1, employees e2
where e1.manager_id = e2.employee_id(+);

select e1.first_name || ' ' || e1.last_name ename, e2.first_name || ' ' || e2.last_name mgrname
from employees e1 left outer join employees e2
on e1.manager_id = e2.employee_id;


/*
-- SQL ����1
select s.�̸�, avg(e.����) avg
from enroll e, student s, class c
where e.�й� = s.�й� and e.���¹�ȣ = c.���¹�ȣ and avg(e.����) >= 3.0;

select s.�̸�, avg(e.����) avg
from enroll e inner join student s  on e.�й� = s.�й�
              inner join class c    on e.���¹�ȣ = c.���¹�ȣ
where avg(e.����) >= 3.0;

-- SQL ����2
select d.deptno, d.dname
from dept d full outer join emp e
on d.deptno=e.deptno;


<���>
| deptno | dname |
|   10   |  RESEARCH  |
|   30   |  SALES  |
|   40   |  WARD  |
*/

