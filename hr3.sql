--1. 2003�⿡ �Ի��� ������� ���, �̸�, �Ի����� ���
select employee_id, first_name || ' ' || last_name full_name, hire_date
from employees
where to_char(hire_date, 'YYYY') = '2003';

--2. ������ FI_ACCOUNT / FI_MGR / SA_MAN / SA_REP �� ������� ������ ���
select *
from employees
where job_id in ('FI_ACCOUNT', 'FI_MGR', 'SA_MAN', 'SA_REP');

--3. Ŀ�̼��� �޴� ������� ����� ���
select first_name || ' ' || last_name full_name
from employees
where commission_pct > 0;

--4.������ SA_MAN �Ǵ� SA_REP�̸� "�Ǹźμ�"�� �� �ܴ� "�� �� �μ�"��� ���
select first_name || ' ' || last_name full_name, decode(job_id, 'SA_MAN', '�Ǹźμ�', 'SA_REP', '�Ǹźμ�', '�� �� �μ�') as Job
from employees;

select first_name || ' ' || last_name full_name, 
    case job_id
        when 'SA_MAN' then '�Ǹźμ�'
        when 'SA_REP' then '�Ǹźμ�'
        else '�� �� �μ�'
        end as job
from employees;

--5. �������� �Ի��ڵ��� �ּұ޿�, �ִ� �޿�, �޿��� ���� �׸��� ��� �޿��� ���Ͻÿ�
select to_char(hire_date, 'YYYY') hire_year, min(salary) min, max(salary) max, sum(salary) sum, round(avg(salary)) avg
from employees
group by to_char(hire_date, 'YYYY')
order by to_char(hire_date, 'YYYY');

--6. �μ��� ��� �޿��� $10,000 �̻��� �μ��� ���Ͻÿ�. ( ��ձ޿��� ���� ������ )
select department_id
from employees
group by department_id
having avg(salary) >= 10000
order by avg(salary) desc;

--7. �μ��� �ִ� �޿��� ���Ͻÿ�
select department_id, max(salary) max
from employees
group by department_id
order by department_id;