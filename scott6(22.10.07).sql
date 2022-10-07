/*

���������� ���?
select <-- ����� ����, ������
from <-- join�ϰų� ���� ���̺� ���� ���������� �־ 

*/

-- 11. scott �Ǵ� ward�� ������ ���� ����� ������ �̸�, ����, �޿��� ���
select empno, ename, job, sal
from emp
where sal in (select sal from emp where ename in ('SCOTT', 'WARD'));

-- 12. chicago���� �ٹ��ϴ� ����� ���� ������ �ϴ� ����� �̸�, ������ ���
select ename, job
from emp
where job in (select job from emp where deptno = (select deptno from dept where loc = 'CHICAGO'));

select ename, job
from emp
where job in (select job from emp a, dept b where a.deptno=b.deptno and loc='CHICAGO');

--select ename, job
--from emp e1, (select 

-- 13. �μ����� ������ ��� ���޺��� ���� ����� �μ���ȣ, �̸�, �޿��� ���
select deptno, ename, sal
from emp e1
where sal > (select avg(sal) from emp e2 where e1.deptno = e2.deptno group by deptno)
order by deptno;

select e1.deptno, e1.ename, e1.sal
from emp e1, (select deptno, avg(sal) avg from emp group by deptno) e2
where e1.deptno = e2.deptno and e1.sal > e2.avg
order by deptno;

select deptno �μ���ȣ, ename �̸�, sal �޿�
from emp
where sal > any(select avg(sal) from emp group by deptno);

select * from emp order by deptno;

---============================================================
-- scott�� db ������ �־��⿡ �� ���� ��������

create or replace view v_emp as
    select empno, ename, deptno from emp;
    
select * from v_emp;
desc v_emp;
select * from emp;

-- �������� insert �� �� �ִ�
insert into v_emp values (1000, 'ȫ�浿', 20);
select * from v_emp;
select * from emp;

-- ���� primary key
insert into v_emp values (1000, 'ȫȫ��', 20);
-- ���� foreign key
insert into v_emp values (2000, 'ȫȫ��', 50);

-- read only �� �����ؼ� ���� ���̺� �Ѽ� ����
create or replace view v_emp as
    select empno, ename, deptno from emp
    with read only;

-- ���� read only
insert into v_emp values (2000, 'ȫȫ��', 30);

/*
[ ���� ] EMP ���̺��� 30�� �μ��� 
EMPNO�� EMP_NO�� ENAME�� NAME�� SAL�� SALARY�� �ٲ㼭 
EMP_30 �並 �����Ͻÿ�
*/

create or replace view v_emp_30 as
    select empno emp_no, ename name, sal salary
    from emp
    where deptno = 30
    with read only;
    
select * from v_emp_30;

-- ���պ�
Create or replace view v_emp_info as
select e.empno empno, e.ename ename, d.dname dname 
from emp e, dept d
where e.deptno=d.deptno;

select * from v_emp_info;

insert into v_emp_info (empno, ename, dname) values (3333, '�Ͳ���', 30);
insert into v_emp_info (empno, ename) values (3333, '�Ͳ���');

delete from v_emp_info where empno=7788;

-- [ ���� ] �μ����� �μ���, �ּұ޿�, �ִ� �޿�, �μ��� ��� �޿��� �����ϴ� V_DEPT_SUM �並 �����Ͽ���.

create or replace view v_dept_sum as
    select d.dname, min(e.sal) min, max(e.sal) max, round(avg(e.sal)) avg
    from emp e , dept d
    where e.deptno = d.deptno
    group by d.dname
    with read only;
 
create or replace view v_dept_sum as
    select d.dname, min(e.sal) min, max(e.sal) max, round(avg(e.sal)) avg
    from emp e inner join dept d on e.deptno = d.deptno
    group by d.dname
    with read only;

select * from v_dept_sum;


-- squence
CREATE  SEQUENCE sq_temp;
-- ���� ��
select sq_temp.nextval from dual;
-- ������ ��
select sq_temp.currval from dual;

-- 5000������ 10�� �����ϴ� �ڵ� ������ (������)
CREATE  SEQUENCE sq_temp2
    start with 5000
    increment by 10;
-- ���� ��
select sq_temp2.nextval from dual;
-- ������ ��
select sq_temp2.currval from dual;

insert into emp(empno, ename) values(sq_temp2.nextval, 'QUIRK');

--INDEX
desc emp;
select empno, ename, job, rowid from emp;

-- ���(�޸�) ��Ȳ�� ���� �ӵ� �ٸ� (��: �����)
-- �̸�(�ϵ��ũ) ����

rollback;

SELECT E.EMPNO EMPNO, E.ENAME ENAME, E.SAL SAL, E.DEPTNO DEPTNO, D.LOC LOC
FROM EMP E INNER JOIN DEPT D ON E.DEPTNO = D.DEPTNO
WHERE e.DEPTNO = 20;