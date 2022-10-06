--<����>
--1. ����� ��L���ڰ� �ִ� ����� ���� �̸�, ����, �μ���, ��ġ�� ���
select      e.ename ename, e.job job, d.dname dname, d.loc loc
from        emp e, dept d
where       e.deptno = d.deptno and e.ename like '%L%';
--group by    
--having
--order by

select      e.ename ename, e.job job, d.dname dname, d.loc loc
from        emp e inner join dept d on e.deptno = d.deptno
where       e.ename like '%L%';


--2. �����ں��� ���� �Ի��� ����� ���� �̸�, �Ի���, ������ �̸�, ������ �Ի����� ���
select  e1.ename, e1.hiredate, e2.ename mgr_name, e2.hiredate mgr_hiredate
from    emp e1, emp e2
where   e1.mgr = e2.empno and e2.hiredate > e1.hiredate;

select  e1.ename, e1.hiredate, e2.ename mgr_name, e2.hiredate mgr_hiredate
from    emp e1 inner join emp e2 on e1.mgr = e2.empno
where   e2.hiredate > e1.hiredate;


/*
3. �Ʒ��� ����� ��� ( �����ڰ� ���� KING�� �����Ͽ� ��� ����� ��� )

��� ����� �Ŵ������ �Ŵ�����
7839 KING 
7698 BLAKE 7839 KING 
7782 CLARK 7839 KING
:
���
*/

select  e1.empno, e1.ename, e1.mgr, e2.ename mgr_name
from    emp e1, emp e2
where   e1.mgr = e2.empno(+);

select  e1.empno, e1.ename, e1.mgr, e2.ename mgr_name
from    emp e1 left outer join emp e2 on e1.mgr = e2.empno;

--------------------------------------------------------------------
--<[6] <��������>
-- ��ü ����� �� ��� �޿����� ���� �޿��� �޴� ����� ����� ��ȸ

-- ��� �޿� ���ϱ�
select round(avg(sal)) from emp;

-- �� ��� �޿����� ���� ��� ���� ��ȸ
select ename, sal from emp 
where sal < (select round(avg(sal)) from emp);

-- ������ ���� ���� ����� ���� ��ȸ
select *
from emp
where sal = (select max(sal) from emp);

-- ��� �޿����� ���� �ִ� �޿����� ���� ������ �޴� ����� ������ ��ȸ
select *
from emp
where sal between (select avg(sal) from emp) and (select max(sal) from emp);

select *
from emp e,
    (select avg(sal) avg, max(sal) max from emp) ext
where e.sal > ext.avg and e.sal < ext.max;
-- where e.sal between (ext.avg) and (ext.max);

-- ���޼����� ���� 10���� ����� ���
select *
from (select ename, nvl(sal, 0) from emp order by sal desc)
where rownum <= 10;

select e.*
from (select ename, sal from emp order by sal desc) e
where rownum <= 10;

select ename, sal
from emp
where rownum <= 10
order by sal desc;




--[����] <��������>
-- 1. SCOTT�� �޿����� ���� ����� ������ �����ȣ, �̸�, ������, �޿��� ���
select empno, ename, job, sal
from emp
where sal > (select sal from emp where ename='SCOTT');

-- 2. 30�� �μ��� �ּ� �޿����� ���μ��� �ּ� �޿��� ���� �μ��� ���
select deptno, min(sal) min
from emp
where deptno is not null
group by deptno
having min(sal) > (select min(sal) from emp where deptno = 30);

select deptno, min(sal) 
from emp 
group by deptno
having deptno = 30;

select min(sal) 
from emp 
group by deptno 
having deptno != 30;

-- 3. �������� ��� �޿� �߿��� ���� ���� �޿��� ���� ������ ���
select job, avg(sal) avg_min
from emp
group by job
having avg(sal) = (select min(avg(sal)) from emp group by job);

select job, round(avg(sal)) min
from emp
group by job;

select job, min(avg(sal))
from emp
group by job;

-- 4. �����ȣ�� 7521�� ������ ���� ��� 7934�� �������� �޿��� ���� �޴� ����� ������ ���
select *
from emp
where job = (select job from emp where empno = 7521) and sal > (select sal from emp where empno = 7934);

select *
from emp
where job = 'SALESMAN';

-- 5. 'WARD'�� �μ��� ������ ���� ��� ��� ���
select *
from emp
where job = (select job from emp where ename like '%WARD%') and deptno = (select deptno from emp where ename like '%WARD%')
            and ename != 'WARD';
            
select *
from emp e, (select job, deptno from emp where ename like '%WARD%') ext
where e.job = ext.job and e.deptno = ext.deptno and e.ename != 'WARD';

----------------------------------------------------------------------------
-- 6. <��������> �̾

-- �������� �ּ� �޿��� �޴� ����� ������ �����ȣ, �̸�, ������, �޿��� ���
select empno, ename, job, sal
from emp
where (job, sal) in (select job, min(sal) from emp group by job);

insert into emp(empno, ename, job, sal) values (9999, '�׽�Ʈ', 'CLERK', 1250);

-- 10�� �μ� ������� ������ ������ ������ �˻�
select ename, job
from emp
--where job = any (select job from emp where deptno = 10);
where job in (select job from emp where deptno = 10);

select ename, job
from emp
where job = any (select job from emp where deptno = 10);

select job
from emp
where deptno = 10;

-- ��� �Ѹ��� ������κ��� ���� ���� �� �ִ� ����� ������ �����ȣ, �̸�, ������ ���
select empno, ename, job
from emp e1
where exists (select * from emp e2 where e1.empno=e2.mgr);
-- FORD / BLAKE / KING / JONES / SCOTT / CLARK

-- ����� ���
select empno, ename, job
from emp e1
where not exists (select * from emp e2 where e1.empno=e2.mgr);

-------------------------------------------------------------------------------------

-- INSERT / UPDATE / DELETE���� (1) �μ��� �޿���� ���̺� ����
create table stat_salary ( 
stat_date date not null, -- ��¥
dept_no number, -- �μ�
emp_count number, -- �����
tot_salary number, -- �޿��Ѿ�
avg_salary number ); -- �޿����

desc stat_salary;

select sysdate, deptno from emp group by deptno;

insert into stat_salary(stat_date, dept_no) select sysdate, deptno from emp group by deptno;

select * from stat_salary;

-- (2) ��¥�� �μ���ȣ �Է�

select count(*), sum(sal) sum, round(avg(sal)) avg
from emp
group by deptno;

update stat_salary ss
set (emp_count, tot_salary, avg_salary) 
    = (select count(*), sum(sal), round(avg(sal)) 
        from emp e 
        where ss.dept_no = e.deptno
        group by deptno);

select * from emp_copy;
drop table emp_copy;
rollback;

create table emp_copy as select * from emp;

-- �μ����� 'SALES'�� ����� ���� ���� (emp_copy)
delete from emp_copy
where deptno = (select deptno from dept where dname = 'SALES');


-- ������̺� �����ϴ� ����̸� ����� �޿��� 10% �λ��ϰ�, �������� �ʴ� ����̸� ������̺� ������ �Է��Ѵ�.
merge into emp_copy ec
using (select ename from emp) e
on (ec.ename = e.ename)
when match then
    update set ec.sal = sal*1.1
when not matched then
    insert as (select * from emp);


















select deptno, job, count(*)
from emp
group by rollup(deptno, job);

select deptno, job, count(*)
from emp
group by deptno, rollup(job);
