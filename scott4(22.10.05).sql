--1. �����ȣ, �̸�, ����, �޿�,  ���� �޿��� 15% ������ �޿���(New Salary),  ������(Increase)�� ���
select empno, ename, job, sal, sal*1.15 New_Salary, sal*0.15 Increase
from emp;

--2. �̸�, �Ի���, �Ի��Ϸκ��� 6���� �Ŀ� ���ƿ��� �������� ���
select ename, hiredate, next_day(add_months(hiredate, 6),2) SMM
from emp;

--3.�̸�, �Ի���, �Ի��Ϸκ��� ��������� ���, �޿�, �Ի��Ϸκ��� ��������� �޿��� �Ѱ踦 ���
SELECT ename, hiredate, sal,
    floor((sysdate-hiredate)/365) workyear,
    sal*(to_char(sysdate,'YYYY')-to_char(hiredate,'YYYY')) sumsal
from emp;

select ename, hiredate, sal,
to_char(sysdate,'YYYY')-to_char(hiredate,'YYYY') as workyear,
sal*(to_char(sysdate,'YYYY')-to_char(hiredate,'YYYY')) as sumsal
from emp;

--4.�̸�, ����, �Ի���, �Ի��� ������ ���
select ename, job, hiredate, to_char(hiredate, 'DAY') day
from emp;

--5. ������, �μ��� �޿� �հ�� �ο����� ����ϵ�, 
    --10�� �μ��� �����ϰ� ������ ��SALESMAN���� ��MANAGER���� ����Ѵ�.
select job, deptno, sum(sal), count(*) people
from emp
group by job, deptno
having deptno != 10 and job in ('SALESMAN', 'MANAGER');

--6. �������� ��ձ޿��� �ִ�޿��� ����ϵ�, ��ձ޿��� 2000�̻��� �͸� ����ϰ� ��ձ޿��� ���� ������ ����
select job, round(avg(sal)) avg, max(sal) max
from emp
group by job
having avg(sal) >= 2000
order by avg(sal) desc;

--7. ���� �Ի�⵵ ���� �ο����� ���
select to_char(hiredate, 'YYYY') hireyear, count(*) people
from emp
group by to_char(hiredate, 'YYYY')
order by to_char(hiredate, 'YYYY');

--8. 5���� �޿��հ�� �ο����� ��� (rownum�̿�)
select ceil(rownum/5), sum(sal) sum, count(*) people
from emp
group by ceil(rownum/5);
?
/*
9. ������ ���� ���
   ( ���� ��µ� �ο����� �ٸ� ���� ���� )

   CLERK     SALESMAN        MANAGER                       (������)
-----------------------------------------------------------------------
     4          4               3                          (�ο���)
*/

select job, count(*) as people
from emp
group by job
having job in ('CLERK', 'SALESMAN', 'MANAGER');

select count(decode(job,'CLERK', 1)) CLERK, count(decode(job,'SALESMAN',1)) SALESMAN, count(decode(job,'MANAGER',1)) MANAGER
from emp;
?
/*
10. ������ ���� ������, �μ��� ���
   ( ���� ���� �ݾ��� �ٸ� ���� ���� )

������                10���μ�                20���μ�                30���μ�                �޿��հ�
----------------------------------------------------------------------------------------
CLERK                   1300                    1900                           950                   4150
SALESMAN                 0                         0                         5600                    5600
PRESIDENT             5000                        0                              0                    5000
MANAGER             2450                     2975                         2850                   8275
ANALYST                    0                     6000                             0                   6000
*/

select job ������, nvl(sum(decode(deptno, 10, sal)),0) "10���μ�", nvl(sum(decode(deptno, 20, sal)),0) "20���μ�", nvl(sum(decode(deptno, 30, sal)),0) "30���μ�", sum(sal) �޿��հ�
from emp
group by job;

select job ������, nvl(sum(decode(deptno,'10',sal)),0) "10���μ�", nvl(sum(decode(deptno,'20',sal)),0) "20���μ�", nvl(sum(decode(deptno,'30',sal)),0) "30���μ�", sum(sal) as �޿��հ�
from emp
group by job;

--================================

--������̺�(emp)�� ������ �μ����̺�(dept)�� �� ����� �μ����� ���
select ename, dname
from emp, dept;

select emp.ename, dept.dname, dept.deptno
from emp, dept;

select emp.ename, dept.dname, dept.deptno
from emp, dept
where emp.deptno=dept.deptno;

select e.ename, d.dname, d.deptno
from emp e, dept d
where e.deptno=d.deptno;

-- ���� ����
select e.ename ename, d.dname dname, d.deptno deptno
from emp e, dept d
where e.deptno=d.deptno;

-- ���� ���� (ǥ�ؾ�)
select e.ename ename, d.dname dname, d.deptno deptno
from emp e inner join dept d
on e.deptno=d.deptno;

-- �ܺ� ����
select e.ename ename, d.dname dname, d.deptno deptno
from emp e, dept d
where e.deptno=d.deptno(+);

select e.ename ename, d.dname dname, d.deptno deptno
from emp e, dept d
where e.deptno(+)=d.deptno;

/*
select e.ename ename, d.dname dname, d.deptno deptno
from emp e, dept d
where e.deptno(+)=d.deptno(+);  -- �� ��
*/

-- �ܺ� ���� (ǥ�ؾ�)
select e.ename ename, d.dname dname, d.deptno deptno
from emp e left outer join dept d
on e.deptno=d.deptno;

-- �ܺ� ���� (ǥ�ؾ�)
select e.ename ename, d.dname dname, d.deptno deptno
from emp e right outer join dept d
on e.deptno=d.deptno;

-- �ܺ� ���� (ǥ�ؾ�)
select e.ename ename, d.dname dname, d.deptno deptno
from emp e full outer join dept d
on e.deptno=d.deptno;

--������̺�(emp)�� �� ����� �Ŵ����� ��ȸ
select e1.empno, e1.ename, e1.mgr, e2.empno, e2.ename
from emp e1, emp e2
where e1.mgr = e2.empno;

select e1.empno, e1.ename, e1.mgr, e2.empno, e2.ename
from emp e1 inner join emp e2
on e1.mgr = e2.empno;

-- �ܺ� ����
select e1.empno, e1.ename, e1.mgr, e2.empno, e2.ename
from emp e1, emp e2
where e1.mgr = e2.empno(+);

select e1.empno, e1.ename, e1.mgr, e2.empno, e2.ename
from emp e1 left outer join emp e2
on e1.mgr = e2.empno;

-- ����
SELECT empno, ename, job, deptno FROM emp WHERE job='CLERK'
    -- SMITH, ADAMS, JAMES, MILLER
    UNION
SELECT empno, ename, job, deptno FROM emp WHERE deptno=10;
    -- CLARK, KING, MILLER
    
SELECT empno, ename, job, deptno FROM emp WHERE job='CLERK'
    -- SMITH, ADAMS, JAMES, MILLER
    minus
SELECT empno, ename, job, deptno FROM emp WHERE deptno=10;
    -- CLARK, KING, MILLER
    
select empno, ename, job, deptno
from emp
where job='CLERK' or deptno=10;


--1. EMP ���̺��� �����ȣ, �̸�, ����, �μ���ȣ�� DEPT ���̺��� �μ���, �ٹ����� ���
select e.empno empno, e.ename ename, e.job job, e.deptno edeptno, d.dname dname, d.loc loc
from emp e inner join dept d
on e.deptno = d.deptno;

--2. SALESMAN ����� �����ȣ, �̸�, �޿�, �μ���, �ٹ����� ���
select e.empno empno, e.ename ename, e.sal sal, d.dname dname, d.loc loc
from emp e inner join dept d
on e.deptno = d.deptno and e.job = 'SALESMAN';

--3. ���ʽ�(comm)�� �޴� ����� ���� �̸�, �μ���, ��ġ�� ���
select e.ename ename, d.dname dname, d.loc loc
from emp e inner join dept d
on e.deptno = d.deptno and e.comm > 0;

--4. �μ��� �μ���� �޿� �հ踦 ���
select sum(e.sal) sumsal, d.dname dname
from emp e inner join dept d
on e.deptno = d.deptno
group by e.deptno;

-- 5. ������ ��MANAGER���� ����� ������ �̸�, ����, �μ���, �ٹ����� ��� 
select e.ename ename, e.job job, d.dname dname, d.loc loc
from emp e inner join dept d
on e.deptno = d.deptno and e.job='MANAGER';

