--<복습>
--1. 사원명에 ‘L’자가 있는 사원에 대해 이름, 업무, 부서명, 위치를 출력
select      e.ename ename, e.job job, d.dname dname, d.loc loc
from        emp e, dept d
where       e.deptno = d.deptno and e.ename like '%L%';
--group by    
--having
--order by

select      e.ename ename, e.job job, d.dname dname, d.loc loc
from        emp e inner join dept d on e.deptno = d.deptno
where       e.ename like '%L%';


--2. 관리자보다 먼저 입사한 사원에 대해 이름, 입사일, 관리자 이름, 관리자 입사일을 출력
select  e1.ename, e1.hiredate, e2.ename mgr_name, e2.hiredate mgr_hiredate
from    emp e1, emp e2
where   e1.mgr = e2.empno and e2.hiredate > e1.hiredate;

select  e1.ename, e1.hiredate, e2.ename mgr_name, e2.hiredate mgr_hiredate
from    emp e1 inner join emp e2 on e1.mgr = e2.empno
where   e2.hiredate > e1.hiredate;


/*
3. 아래의 결과를 출력 ( 관리자가 없는 KING을 포함하여 모든 사원을 출력 )

사번 사원명 매니저사번 매니저명
7839 KING 
7698 BLAKE 7839 KING 
7782 CLARK 7839 KING
:
등등
*/

select  e1.empno, e1.ename, e1.mgr, e2.ename mgr_name
from    emp e1, emp e2
where   e1.mgr = e2.empno(+);

select  e1.empno, e1.ename, e1.mgr, e2.ename mgr_name
from    emp e1 left outer join emp e2 on e1.mgr = e2.empno;

--------------------------------------------------------------------
--<[6] <서브쿼리>
-- 전체 사원들 중 평균 급여보다 낮은 급여를 받는 사원의 명단을 조회

-- 평균 급여 구하기
select round(avg(sal)) from emp;

-- 그 평균 급여보다 낮은 사원 정보 조회
select ename, sal from emp 
where sal < (select round(avg(sal)) from emp);

-- 월급이 가장 많은 사원의 정보 조회
select *
from emp
where sal = (select max(sal) from emp);

-- 평균 급여보다 높고 최대 급여보다 낮은 월급을 받는 사원의 정보를 조회
select *
from emp
where sal between (select avg(sal) from emp) and (select max(sal) from emp);

select *
from emp e,
    (select avg(sal) avg, max(sal) max from emp) ext
where e.sal > ext.avg and e.sal < ext.max;
-- where e.sal between (ext.avg) and (ext.max);

-- 월급순으로 상위 10명의 명단을 출력
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




--[연습] <서브쿼리>
-- 1. SCOTT의 급여보다 많은 사원의 정보를 사원번호, 이름, 담당업무, 급여를 출력
select empno, ename, job, sal
from emp
where sal > (select sal from emp where ename='SCOTT');

-- 2. 30번 부서의 최소 급여보다 각부서의 최소 급여가 높은 부서를 출력
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

-- 3. 업무별로 평균 급여 중에서 가장 적은 급여를 가진 직업을 출력
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

-- 4. 사원번호가 7521의 업무와 같고 사번 7934인 직원보다 급여를 많이 받는 사원의 정보를 출력
select *
from emp
where job = (select job from emp where empno = 7521) and sal > (select sal from emp where empno = 7934);

select *
from emp
where job = 'SALESMAN';

-- 5. 'WARD'와 부서와 업무가 같은 사원 명단 출력
select *
from emp
where job = (select job from emp where ename like '%WARD%') and deptno = (select deptno from emp where ename like '%WARD%')
            and ename != 'WARD';
            
select *
from emp e, (select job, deptno from emp where ename like '%WARD%') ext
where e.job = ext.job and e.deptno = ext.deptno and e.ename != 'WARD';

----------------------------------------------------------------------------
-- 6. <서브쿼리> 이어서

-- 업무별로 최소 급여를 받는 사원의 정보를 사원번호, 이름, 담당업무, 급여를 출력
select empno, ename, job, sal
from emp
where (job, sal) in (select job, min(sal) from emp group by job);

insert into emp(empno, ename, job, sal) values (9999, '테스트', 'CLERK', 1250);

-- 10번 부서 사원들의 업무와 동일한 직원들 검색
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

-- 적어도 한명의 사원으로부터 보고를 받을 수 있는 사원의 정보를 사원번호, 이름, 업무를 출력
select empno, ename, job
from emp e1
where exists (select * from emp e2 where e1.empno=e2.mgr);
-- FORD / BLAKE / KING / JONES / SCOTT / CLARK

-- 사원을 출력
select empno, ename, job
from emp e1
where not exists (select * from emp e2 where e1.empno=e2.mgr);

-------------------------------------------------------------------------------------

-- INSERT / UPDATE / DELETE에서 (1) 부서별 급여통계 테이블 생성
create table stat_salary ( 
stat_date date not null, -- 날짜
dept_no number, -- 부서
emp_count number, -- 사원수
tot_salary number, -- 급여총액
avg_salary number ); -- 급여평균

desc stat_salary;

select sysdate, deptno from emp group by deptno;

insert into stat_salary(stat_date, dept_no) select sysdate, deptno from emp group by deptno;

select * from stat_salary;

-- (2) 날짜와 부서번호 입력

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

-- 부서명이 'SALES'인 사원의 정보 삭제 (emp_copy)
delete from emp_copy
where deptno = (select deptno from dept where dname = 'SALES');


-- 사원테이블에 존재하는 사원이면 사원의 급여를 10% 인상하고, 존재하지 않는 사원이면 사원테이블에 정보를 입력한다.
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
