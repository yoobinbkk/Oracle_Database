create table employee as select * from emp;

alter table employee
    rename column empno to eno;

alter table employee
    rename column mgr to manager;

alter table employee
    rename column sal to salary;

alter table employee
    rename column comm to commission;

alter table employee
    rename column deptno to dno;
    
insert into employee values (7788, 'SCOTT', 'ANALYST', 7566, '87/07/13', 3000, null, 20);

insert into employee values (7876, 'ADAMS', 'CLERK', 7788, '87/07/13', 1100, null, 20);

drop table employee;

-- [����1] �Ʒ��� employee ���̺��� ��� ����Դϴ�.
-- �޿��� 2000 �̻� 3000 ������ ����� �̸��� �����ȣ, �Ի���, �޿��� ����ϵ� �̸��� �������� �����ϼ���.

select ename, eno, hiredate, salary
from employee
where salary between (2000) and (3000)
order by ename;

-- [����2] �� 1�� ������ employee ���̺��� ��� ����� �����Ͽ� �Ʒ� ������ �������� �ۼ��ϼ���.
-- Ŀ�̼��� NULL �� ����̸���, �Ի��� �μ���ȣ�� ����ϵ� �μ���ȣ�� �������� �����ϵ� �μ���ȣ�� ���� �׸��� ���� ��� �̸��� ������������ �����ϼ���.

select ename, hiredate, dno
from employee
where commission is null
order by dno, ename;

-- Ŀ�̼��� 300 �̰ų� 500 �̰ų� 1400�� ����� �����ȣ�� �̸�, ����, Ŀ�̼��� ��� �ϵ� Ŀ�̼��� �������� �����ϼ���.
    -- IN �����ڸ� ����ؼ� ��� �ϼ���.
    
select eno, ename, salary, commission
from employee
where commission in (300, 500, 1400)
order by commission desc;
    
-- �̸��� ù ���ڰ� ��S���� �����ϴ� ����� �̸��� ����ϼ���.

select ename
from employee
where ename like 'S%';

-- LIKE �����ڿ� ���ϵ� ī�带 ����ؼ� '81'�⵵�� �Ի����� ���� ����� �̸��� �Ի����� ����ϼ���.

select ename, hiredate
from employee
where hiredate not like '81%';

-- �μ� ��ȣ�� �ߺ� ������ ������������ �����ؼ� ����ϼ���.

select distinct dno
from employee
order by dno;

-- �̸��� ��A��  �� ��E�� �� ��� �����ϴ� ����� �̸��� ����ϼ���.

select ename
from employee
where ename like '%A%' and ename like '%E%';

-- substr �Լ��� ����ؼ� 12�� �޿� �Ի��� ����� �����ȣ, �̸�, �Ի����� ����ϼ���.

select eno, ename, hiredate
from employee
where substr(hiredate, 4, 2) = '12';

-- NVL �Լ��� ����ؼ� ����� ������ ����ؼ� ����̸�, ����, Ŀ�̼� , ������ ����ϵ� ������ ���� ������� ����ϼ���.

select ename, salary, commission, nvl(salary, 0)*12 annual_salary
from employee
order by annual_salary desc;

-- NVL2 �Լ��� ����ؼ� ����� ������ ����ؼ� ����̸�, ����, Ŀ�̼� , ������ ����ϵ� ������ ���� ������� ����ϼ���.

select ename, salary, commission, nvl2(salary, salary, 0)*12 annual_salary
from employee
order by annual_salary desc;

-- ������� �޿� �Ѿ� , ��վ�, �ְ��, �ּҾ��� ��� �ϼ���. �� �÷��� ���޿��Ѿס�, ����վ�, ���ְ�ס�, ���ּҾס����� ��Ī�̸����� ����ϼ���.

select sum(salary) �޿��Ѿ�, avg(salary) ��վ�, max(salary) �ְ��, min(salary) �ּҾ�
from employee;

-- ���� ������ ������ ��� �ϼ���.  ����÷��� ������ ������ �������� ��Ī�̸����� ��� �ϼ���.

select count(distinct job) "���� ������ ����"
from employee;

-- �� �μ��� ��� ������ ���ؼ� �μ���ȣ�� ��� ������ ��� �ϵ� ���� ���μ���ȣ��, ����տ��ޡ� ���� ��Ī�̸����� ����ϼ���.

select dno �μ���ȣ, avg(salary) ��տ���
from employee
group by dno;

-- ��� ������ ������ ����� ���� ���Ͻÿ�. (���� , count �Լ� ���)

select job, count(job)
from employee
group by job;

-- ���޺� ����� ���� �޿��� ����Ͻÿ�, �����ڸ� �˼� ���� ��� �� ���� �޿��� 2000 �̸��� �׷��� ���� ��Ű�� ����� �޿��� ���� ������������ �����Ͽ� ��� �ϼ���.

select min(salary)
from employee
where manager is not null
group by job
having min(salary) > 2000
order by min(salary) desc;

-- ���� ������ ����ؼ� �����ȣ�� 7788�� ����� �������� ���� ����� ��� �Ͻÿ�  <����̸�, ������> ��� �Ͻÿ�.

select ename ����̸�, job ������
from employee
where job = (select job from employee where eno = 7788) and eno != 7788;

-- ���� ������ ����ؼ� ����� 7499 �� ������� �޿��� ���� ����� ��� �Ͻÿ�. <����̸�, ������> ��� �Ͻÿ�.

select ename ����̸�, job ������
from employee
where salary > (select salary from employee where eno = 7499);

-- ���� ������ ����ؼ� �� �μ��� �ּ� �޿��� �޴� ����� �̸� , �޿�, �μ���ȣ�� ����Ͻÿ�.

select ename, salary, dno
from employee
where salary in (select min(salary) from employee group by dno);

-- ���� ������ ����ؼ� �޿��� ��� �޿����� ���� ������� �����ȣ�� �̸��� ǥ���ϵ� ����� �޿��� ���ؼ� ������������ �����Ͻÿ�.

select eno, ename
from employee
where salary > (select avg(salary) from employee)
order by salary;

-- ���� ������ ����ؼ� DEPT ���̺� �ִ� �μ��� DNAME �÷�����  ��RESEARCH�� �μ��� �μ���ȣ, ����̸� �� ��� ������ ǥ���Ͻÿ�.

select dno, ename, job
from employee
where dno = (select dno from dept where dname = 'RESEARCH');