-- 1. Sawon ���̺� ����
Create table sawon
(
    sabun       number(6),
    sawon_name  varchar2(15),
    ubmu        varchar2(30),
    weolgub     number(10, 2),
    buseo       number(3)
);

-- 2. sabun �⺻Ű�� ����
alter table sawon
    add constraint pk_sabun primary key (sabun);

-- 3. jiyeok �÷� �����
alter table sawon
    add jiyeok varchar2(30) not null;
    
-- 4.
alter table sawon
    modify (weolgub number(7));
    
-- 5. 
alter table sawon
    add constraint ck_sawon_ubmu check (ubmu in ('����', '��������', '����'));

-- 6.
alter table sawon
    Modify (ubmu varchar2(30) default '����');
    
select * from sawon;
    
-- 7.
create table buseo
(
    buseo_no number(3),
    buseo_name varchar2(30),
    constraint pk_buseo_buseo_no primary key (buseo_no)
);

-- 8.
alter table sawon
    add constraint fk_buseo foreign key (buseo) references buseo (buseo_no);
    
-- 9.
Insert into buseo(buseo_no, buseo_name) values (101, '����Ʈ��������������');
Insert into buseo(buseo_no, buseo_name) values (202, '������');
Insert into buseo(buseo_no, buseo_name) values (303, '�����ڿ���');

-- 10.
Insert into sawon(sabun, sawon_name, ubmu, weolgub, buseo, jiyeok) values (8001, 'ȫ�浿�̱�', null, 100000, 101, '�λ�');
Insert into sawon(sabun, sawon_name, ubmu, weolgub, buseo, jiyeok) values (8002, 'ȫ����', '�繫', 200000, 202, '��õ');
Insert into sawon(sabun, sawon_name, ubmu, weolgub, buseo, jiyeok) values (8003, 'ȫ���', '����', null, 111, '����');
Insert into sawon(sabun, sawon_name, ubmu, weolgub, buseo, jiyeok) values (8004, 'ȫ�漮', null, 12345678, null, '����');
Insert into sawon(sabun, sawon_name, ubmu, weolgub, buseo, jiyeok) values (8005, 'ȫ��ö', '��������', null, 303, '�Ǳ�');
    
-- 11.
alter table sawon
    drop (jiyeok);
    
-- 12.
delete from buseo where buseo_name = '�����ڿ���';

-- 13.
drop table sawon;
drop table buseo;

-- 14.
create table sawon
(
    sabun number(6),
    sawon_name varchar2(15),
    ubmu varchar2(30) default '����',
    weolgub number(7),
    buseo number(3),
    jiyeok varchar2(30) not null,
    constraint pk_sawon_sabun primary key (sabun),
    constraint ck_sawon_ubmu check (ubmu in ('����', '��������', '����')),
    constraint fk_sawon_buseo foreign key (buseo) references buseo (buseo_no)
);

create table buseo
(
    buseo_no number(3),
    buseo_name varchar2(30),
    constraint pk_buseo_buseo_no primary key (buseo_no)
);


--=========================================================

/*
    select �˻��� �׸��
    from    ���̺��
    where ����
*/

-- ��� ����� ������ �޿�, �޿��� ���ʽ��� ���� �հ� ���
select  ename, sal, sal+nvl(comm,0) AS total_sal
from    emp;
-- where

SELECT ename||' '||job as staff
from emp;

select distinct job from emp;

-- 1. 20�� �μ����� �ٹ��ϴ� ����� �����ȣ, �̸�, �μ���ȣ ���
select empno, ename, deptno
from emp
where deptno=20;

-- 2- �Ի����� 81/01/01���� 81/06/09�� ����� �����ȣ, �̸�, �Ի����� ���
select empno, ename, hiredate
from emp
where hiredate BETWEEN '81/01/01' and '81/06/09';
--where hiredate BETWEEN TO_DATE('1981/01/01', 'YYYY-MM-DD') 
                   --AND TO_DATE('1981/06/09', 'YYYY-MM-DD');
                   
-- 3- �������� salesman, clerk�� ������� �̸��� ������ ���
select ename, job
from emp
where job in ('CLERK', 'SALESMAN');
-- where job = upper('salesman') or job = upper('clerk');

-- 4- ������ president�̰� �޿��� 1500�̻��̰ų� ������ salesman�� ����� ������ ���
select *
from emp
where (job = 'PRESIDENT' and sal >= 1500)
    or job = 'SALESMAN';

-- 5- ������ president �Ǵ� salesman�̰� �޿��� 1500�̻��� ����� ������ ���
select *
from emp
where job in ('PRESIDENT', 'SALESMAN')
    and sal >= 1500;
-- where (job = 'PRESIDENT' or job = 'SALESMAN')
    --and sal >=1500;
    
-- 6- Ŀ�̼�(comm)�� ���� ����� �̸�, �޿�, Ŀ�̼��� ���
select ename, sal, comm
from emp
where nvl(comm,0) = 0;

-- 7- �����, �޿�, Ŀ�̼�, �ѱ޿�( �޿� + Ŀ�̼�)�� ���
select ename, sal, comm, sal+nvl(comm, 0) as total_sal
from emp;

-- 8- �̸� A�� �����ϴ� ����� ���
select ename
from emp
where ename like 'A%';

-- 9- �̸��� �ι�° ���ڰ� L�� ����� ���
select ename
from emp
where ename like '_L%';

-- 10- �̸��� L�� �� �� �̻� ���Ե� ����� ���
select ename
from emp
where ename like '%L%L%';

-- 11- Ŀ�̼�(COMM)�� NULL�� �ƴ� ����� ��� ������ ���
select *
from emp
where comm is not null;

-- 12- ���ʽ��� �޿����� 10%�̻� ���� ��� ����� ���� �̸�, �޿�, ���ʽ��� ���
select ename, sal, nvl(comm, 0)
from emp
where comm >= sal*1.1;

-- 13- ������ clerk�̰ų� analyst�̰� �޿��� 1000, 3000, 5000�� �ƴ� ��� ����� ������ ���
select *
from emp
where job in ('CLERK', 'ANALYST') and sal not in (1000, 3000, 5000);

-- 14- �μ��� 30�̰ų� �Ǵ� �����ڰ� 7782�� ����� ��� ������ ���
select *
from emp
where deptno = 30 or mgr = 7782;

-- �߰� ����

--1. EMPLOYEES ���̺��� ��� �̸��� first_name�� last_name�� ���� full_name���� ���



