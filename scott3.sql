-- �����, �޿�, ����(�޿�/12)�� ����ϵ� ������ �ʴ������� �ݿø��Ͽ� ���
select ename, sal, round(sal/12, -1) as annualsal
from emp;

-- �����, �޿�, ����(�޿��� 3.3%)�� ������ �����ϰ� ���
select ename, sal, trunc(sal*0.033, 0) as tax
from emp;

-- smith�� ������ �����ȣ, ����, ������(�ҹ���) ���
select empno, ename, lower(job) as job
from emp
where lower(ename) = lower('smith');

-- �����ȣ, �����(ù���ڸ� �빮��), ������(ù���ڸ� �빮��)�� ���
select empno, initcap(ename), initcap(job)
from emp;

-- �̸��� ù���ڰ� ��K������ ũ�� ��Y������ ���� ����� ����( �����ȣ, �̸�, ����, �޿�, �μ���ȣ)�� ����ϵ� �̸������� ����
select empno, ename, job, sal, deptno
from emp
where substr(ename, 1,1) > 'K' and substr(ename, 1, 1) < 'Y'
order by ename;

-- �̸��� 5���� �̻��� ������� ���
select *
from emp
where length(ename) >= 5;

-- �̸��� 15�ڷ� ���߰� ���ڴ� ���ʿ� �����ʿ��� ��*���� ä���
select rpad(ename, 15, '*')
from emp;

-- �޿��� 10�ڷ� ���߰� ���ڴ� �����ʿ� ���ʿ� ��-���� ä���
select lpad(sal, 10, '-')
from emp;

select substr('800101-1234567', 8, 1) gender
from dual;

select substr('900808-2222222', 8, 1) gender
from dual;

select substr('800101-1234567', 1, 2) birth_year
from dual;

select substr('900808-2222222', 1, 2) birth_year
from dual;

-- ���� ������ ����
select  '-' || trim(' �̼��� ') || '-' as col1, 
        '-' || ltrim(' �̼��� ') || '-' as col2, 
        '-' || rtrim(' �̼��� ') || '-' as col3 
from dual;

select sysdate
from dual;

-- �޿��� ���ڿ��� �������̻�����ĥ�ȱ��� ���ڷ� ��ü
select sal, translate(sal, '0123456789', '�����̻�����ĥ�ȱ�') as kor_sal
from emp;

-- �޿��� ���ڿ��� 0�� ��$���� �ٲپ� ���
select sal, replace(sal, 0, '$') as dollar
from emp;

-- *****
-- *****
select replace('    ��    ��    ��     ', ' ', '') as name
from dual;

select systimestamp
from dual;

select (sysdate - sysdate) as test
from dual;


-- ������� �ٹ��� ���� ���� ��� ������ ���
select ename, hiredate, floor(sysdate - nvl(hiredate, sysdate)) as workdays
from emp
order by sysdate - hiredate desc nulls last;

-- ������� �ٹ��� ���� �� �� �� ���ΰ��� ���
select ename, floor((sysdate - hiredate)/7) as workweeks, floor(mod((sysdate - hiredate),7)) as and_days
from emp;

-- 10�� �μ��� ����� ��������� �ٹ� ������ ��� 
select ename, floor(sysdate - hiredate) as workdays
from emp
where deptno = 10;

-- ���� ��¥���� 3���� ���� ��¥ ���ϱ�
select add_months( sysdate, 3 ) as mydate
from dual;

-- ���� ��¥���� ���ƿ��� ������������ ��¥ ���ϱ�
select next_day( sysdate, '��')
from dual;

-- ���� ��¥���� �ش� ���� ������ ��¥ ���ϱ�
select last_day(sysdate)
from dual;



-- �Ի����ڿ��� �Ի�⵵�� ���
select ename, hiredate, to_char(hiredate, 'YYYY') as hire_year
from emp;

-- �Ի����ڸ� ��1999�� 1�� 1�ϡ� �������� ���
select ename, hiredate, to_char(hiredate, 'YYYY"��" MM"��" DD"��"')
from emp;

-- 1981�⵵�� �Ի��� ��� �˻�
select *
from emp
where to_char(hiredate, 'YYYY') = '1981';

-- 5���� �Ի��� ��� �˻�
select *
from emp
where to_char(hiredate, 'MM') = '05';

-- �޿� �տ� $�� �����ϰ� 3�ڸ� ���� ,�� ���
select ename, sal, to_char(sal, '$999,999,999,999') as dollar
from emp;

-- 81�� 2���� �Ի��� ��� �˻�
select *
from emp
where to_char(hiredate, 'YY/MM') = '81/02';

-- 81�⿡ �Ի����� ���� ��� �˻�
select *
from emp
where to_char(hiredate, 'YY/MM') != '81/02';

-- 81�� �Ϲݱ⿡ �Ի��� ��� �˻�
select *
from emp
where hiredate between '1981/01/01' and '1981/12/31'
order by hiredate;

-- �ֹι�ȣ���� ���� ���ϱ�

SELECT decode( substr(jumin, 8, 1), '1', '����', '3', '����', '����') AS gender
from info_tab;

SELECT CASE substr( jumin, 8, 1) 
            WHEN '1' THEN '����'
            WHEN '3' THEN '����'
            ELSE '����'
            END as gender
FROM info_tab;

-- �μ���ȣ�� 10�̸� ������, 20�̸� ������, 30�̸� IT�� �� �ܴ� ����η� ���
select ename, decode(deptno, 10, '������', 20, '������', 30, 'IT��', '�����') as Dept
from emp;

select ename,
        case deptno
            when 10 then '������'
            when 20 then '������'
            when 30 then 'IT��'
            else '�����'
            end as dept
from emp;

-- ����(job)�� analyst�̸� �޿� ������ 10%�̰� clerk�̸� 15%, manager�̸� 20%�� ��� �����ȣ, �����, ����, �޿�, ������ �޿��� ���
select empno, ename, job, sal,
        decode(job, 'ANALYST', sal*1.1, 'CLERK', sal*1.15, 'MANAGER', sal*1.2, sal) as sal_raise
from emp;

select empno, ename, job, sal,
        case job
            when 'ANALYST' then sal+(sal*0.1)
            when 'CLERK' then sal+(sal*0.15)
            when 'MANAGER' then sal+(sal*0.2)
            else sal
            end as sal_raise
from emp;


select all job from emp;
select distinct job from emp;

select rownum, empno, ename, job
from emp;

desc emp;

select rownum, empno, ename, job
from emp
where rownum<=5;

-- ������ ��SALESMAN���� ������� ������ ���, ����, �ּҰ�, �ִ밪�� ���ϱ�
-- Null ���� �־ ������ ����
select  avg(sal) avg, sum(sal) sum, min(sal) min, max(sal) max
from    emp
where   job = 'SALESMAN';

insert into emp(empno, ename, job)
    values (9001, 'ȫ�汹', 'SALESMAN');

-- Ŀ�̼�(COMM)�� �޴� ������� ����
select count(nvl(comm, 0)) comm_count
from emp
where comm != 0;

-- �μ����� �ο���, ��ձ޿�, �����޿�, �ְ�޿�, �޿��� ���� ���ϱ�
select  deptno, count(*), round(avg(sal)), min(sal), max(sal), sum(sal)
from    emp
--where
group by deptno;
--having

-- �μ����� �ο���, ��ձ޿�, �����޿�, �ְ�޿�, �޿��� ���� ���ϱ� ( �μ��� �޿��� ���� ���� ������
select      deptno, count(*), round(avg(sal)), min(sal), max(sal), sum(sal)
from emp
--where 
group by deptno
order by sum(sal) desc;
--having

-- �μ��� ������ �׷��Ͽ� �μ���ȣ, ����, �ο���, �޿��� ���, �޿��� ���� ���ϱ�
select deptno, job, count(*), round(avg(sal)), sum(sal)
from emp
group by deptno, job;


-- �ִ� �޿��� 2900 �̻��� �μ��� ���� �μ���ȣ, ��� �޿�, �޿��� ���� ���
select deptno, empno, round(avg(sal)) avg, sum(sal)sum
from emp
group by deptno, empno
having max(sal) >= 2900;

-- ������ �޿��� ����� 3000�̻��� ������ ���� ������, ��� �޿�, �޿��� ���� ���
select job, round(avg(sal)) avg, sum(sal)sum
from emp
group by job
having avg(sal) >= 3000;

-- ��ü �հ� �޿��� 5000�� �ʰ��ϴ� �� ������ ���ؼ� ������ �޿� �հ踦 ���
-- ��, SALESMAN�� �����ϰ� �޿� �հ谡 ���� ������ ����
select job, sum(sal) sum
from emp
where job != 'SALESMAN'
group by job
having sum(sal) > 5000
order by sum(sal) desc;

-- ������ �ְ� �޿��� �ּ� �޿��� ���̸� ���϶�
select max(sal)-min(sal) dif
from emp
group by job;

-- �μ� �ο��� 4�� ���� ���� �μ��� �μ���ȣ, �ο���, �޿��� ���� ���
select deptno, count(*), sum(sal) sum
from emp
group by deptno
having count(*) > 4;

select job, sum( sal ) from emp group by job;
select job, sum( sal ) from emp group by rollup(job);
select job, sum( sal ) from emp group by cube(job);

