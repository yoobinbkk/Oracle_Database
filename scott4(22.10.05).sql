--1. 사원번호, 이름, 업무, 급여,  현재 급여에 15% 증가된 급여를(New Salary),  증가액(Increase)를 출력
select empno, ename, job, sal, sal*1.15 New_Salary, sal*0.15 Increase
from emp;

--2. 이름, 입사일, 입사일로부터 6개월 후에 돌아오는 월요일을 출력
select ename, hiredate, next_day(add_months(hiredate, 6),2) SMM
from emp;

--3.이름, 입사일, 입사일로부터 현재까지의 년수, 급여, 입사일로부터 현재까지의 급여의 총계를 출력
SELECT ename, hiredate, sal,
    floor((sysdate-hiredate)/365) workyear,
    sal*(to_char(sysdate,'YYYY')-to_char(hiredate,'YYYY')) sumsal
from emp;

select ename, hiredate, sal,
to_char(sysdate,'YYYY')-to_char(hiredate,'YYYY') as workyear,
sal*(to_char(sysdate,'YYYY')-to_char(hiredate,'YYYY')) as sumsal
from emp;

--4.이름, 업무, 입사일, 입사한 요일을 출력
select ename, job, hiredate, to_char(hiredate, 'DAY') day
from emp;

--5. 업무별, 부서별 급여 합계와 인원수를 출력하되, 
    --10번 부서를 제외하고 업무가 ‘SALESMAN’과 ‘MANAGER’만 출력한다.
select job, deptno, sum(sal), count(*) people
from emp
group by job, deptno
having deptno != 10 and job in ('SALESMAN', 'MANAGER');

--6. 업무별로 평균급여와 최대급여를 출력하되, 평균급여가 2000이상인 것만 출력하고 평균급여가 높은 순으로 정렬
select job, round(avg(sal)) avg, max(sal) max
from emp
group by job
having avg(sal) >= 2000
order by avg(sal) desc;

--7. 같은 입사년도 별로 인원수를 출력
select to_char(hiredate, 'YYYY') hireyear, count(*) people
from emp
group by to_char(hiredate, 'YYYY')
order by to_char(hiredate, 'YYYY');

--8. 5개씩 급여합계와 인원수를 출력 (rownum이용)
select ceil(rownum/5), sum(sal) sum, count(*) people
from emp
group by ceil(rownum/5);
?
/*
9. 다음과 같이 출력
   ( 실제 출력된 인원수가 다를 수도 있음 )

   CLERK     SALESMAN        MANAGER                       (업무명)
-----------------------------------------------------------------------
     4          4               3                          (인원수)
*/

select job, count(*) as people
from emp
group by job
having job in ('CLERK', 'SALESMAN', 'MANAGER');

select count(decode(job,'CLERK', 1)) CLERK, count(decode(job,'SALESMAN',1)) SALESMAN, count(decode(job,'MANAGER',1)) MANAGER
from emp;
?
/*
10. 다음과 같이 업무별, 부서별 출력
   ( 실제 계산된 금액이 다를 수도 있음 )

업무명                10번부서                20번부서                30번부서                급여합계
----------------------------------------------------------------------------------------
CLERK                   1300                    1900                           950                   4150
SALESMAN                 0                         0                         5600                    5600
PRESIDENT             5000                        0                              0                    5000
MANAGER             2450                     2975                         2850                   8275
ANALYST                    0                     6000                             0                   6000
*/

select job 업무명, nvl(sum(decode(deptno, 10, sal)),0) "10번부서", nvl(sum(decode(deptno, 20, sal)),0) "20번부서", nvl(sum(decode(deptno, 30, sal)),0) "30번부서", sum(sal) 급여합계
from emp
group by job;

select job 업무명, nvl(sum(decode(deptno,'10',sal)),0) "10번부서", nvl(sum(decode(deptno,'20',sal)),0) "20번부서", nvl(sum(decode(deptno,'30',sal)),0) "30번부서", sum(sal) as 급여합계
from emp
group by job;

--================================

--사원테이블(emp)에 사원명과 부서테이블(dept)에 그 사원의 부서명을 출력
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

-- 내부 조인
select e.ename ename, d.dname dname, d.deptno deptno
from emp e, dept d
where e.deptno=d.deptno;

-- 내부 조인 (표준안)
select e.ename ename, d.dname dname, d.deptno deptno
from emp e inner join dept d
on e.deptno=d.deptno;

-- 외부 조인
select e.ename ename, d.dname dname, d.deptno deptno
from emp e, dept d
where e.deptno=d.deptno(+);

select e.ename ename, d.dname dname, d.deptno deptno
from emp e, dept d
where e.deptno(+)=d.deptno;

/*
select e.ename ename, d.dname dname, d.deptno deptno
from emp e, dept d
where e.deptno(+)=d.deptno(+);  -- 안 됨
*/

-- 외부 조인 (표준안)
select e.ename ename, d.dname dname, d.deptno deptno
from emp e left outer join dept d
on e.deptno=d.deptno;

-- 외부 조인 (표준안)
select e.ename ename, d.dname dname, d.deptno deptno
from emp e right outer join dept d
on e.deptno=d.deptno;

-- 외부 조인 (표준안)
select e.ename ename, d.dname dname, d.deptno deptno
from emp e full outer join dept d
on e.deptno=d.deptno;

--사원테이블(emp)에 각 사원의 매니저를 조회
select e1.empno, e1.ename, e1.mgr, e2.empno, e2.ename
from emp e1, emp e2
where e1.mgr = e2.empno;

select e1.empno, e1.ename, e1.mgr, e2.empno, e2.ename
from emp e1 inner join emp e2
on e1.mgr = e2.empno;

-- 외부 조인
select e1.empno, e1.ename, e1.mgr, e2.empno, e2.ename
from emp e1, emp e2
where e1.mgr = e2.empno(+);

select e1.empno, e1.ename, e1.mgr, e2.empno, e2.ename
from emp e1 left outer join emp e2
on e1.mgr = e2.empno;

-- 집합
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


--1. EMP 테이블에서 사원번호, 이름, 업무, 부서번호와 DEPT 테이블에서 부서명, 근무지를 출력
select e.empno empno, e.ename ename, e.job job, e.deptno edeptno, d.dname dname, d.loc loc
from emp e inner join dept d
on e.deptno = d.deptno;

--2. SALESMAN 사원만 사원번호, 이름, 급여, 부서명, 근무지를 출력
select e.empno empno, e.ename ename, e.sal sal, d.dname dname, d.loc loc
from emp e inner join dept d
on e.deptno = d.deptno and e.job = 'SALESMAN';

--3. 보너스(comm)를 받는 사원에 대해 이름, 부서명, 위치를 출력
select e.ename ename, d.dname dname, d.loc loc
from emp e inner join dept d
on e.deptno = d.deptno and e.comm > 0;

--4. 부서별 부서명과 급여 합계를 출력
select sum(e.sal) sumsal, d.dname dname
from emp e inner join dept d
on e.deptno = d.deptno
group by e.deptno;

-- 5. 업무가 ‘MANAGER’인 사원의 정보를 이름, 업무, 부서명, 근무지를 출력 
select e.ename ename, e.job job, d.dname dname, d.loc loc
from emp e inner join dept d
on e.deptno = d.deptno and e.job='MANAGER';

