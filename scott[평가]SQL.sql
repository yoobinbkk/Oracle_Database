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

-- [문항1] 아래는 employee 테이블의 출력 결과입니다.
-- 급여가 2000 이상 3000 이하인 사원의 이름과 사원번호, 입사일, 급여를 출력하되 이름을 오름차순 정렬하세요.

select ename, eno, hiredate, salary
from employee
where salary between (2000) and (3000)
order by ename;

-- [문항2] 위 1번 문항의 employee 테이블의 출력 결과를 참고하여 아래 문항을 쿼리문를 작성하세요.
-- 커미션이 NULL 인 사원이름과, 입사일 부서번호를 출력하되 부서번호를 오를차순 정렬하되 부서번호가 같은 항목이 있을 경우 이름을 오름차순으로 정렬하세요.

select ename, hiredate, dno
from employee
where commission is null
order by dno, ename;

-- 커미션이 300 이거나 500 이거나 1400인 사원의 사원번호와 이름, 월급, 커미션을 출력 하되 커미션을 내림차순 정렬하세요.
    -- IN 연산자를 사용해서 출력 하세요.
    
select eno, ename, salary, commission
from employee
where commission in (300, 500, 1400)
order by commission desc;
    
-- 이름의 첫 글자가 ’S’로 시작하는 사원의 이름을 출력하세요.

select ename
from employee
where ename like 'S%';

-- LIKE 연산자와 와일드 카드를 사용해서 '81'년도에 입사하지 않은 사원의 이름과 입사일을 출력하세요.

select ename, hiredate
from employee
where hiredate not like '81%';

-- 부서 번호를 중복 제거후 오름차순으로 정렬해서 출력하세요.

select distinct dno
from employee
order by dno;

-- 이름에 ‘A’  와 ‘E’ 를 모두 포함하는 사원의 이름을 출력하세요.

select ename
from employee
where ename like '%A%' and ename like '%E%';

-- substr 함수를 사용해서 12월 달에 입사한 사원의 사원번호, 이름, 입사일을 출력하세요.

select eno, ename, hiredate
from employee
where substr(hiredate, 4, 2) = '12';

-- NVL 함수를 사용해서 사원의 연봉을 계산해서 사원이름, 월급, 커미션 , 연봉을 출력하되 연봉이 많은 순서대로 출력하세요.

select ename, salary, commission, nvl(salary, 0)*12 annual_salary
from employee
order by annual_salary desc;

-- NVL2 함수를 사용해서 사원의 연봉을 계산해서 사원이름, 월급, 커미션 , 연봉을 출력하되 연봉이 많은 순서대로 출력하세요.

select ename, salary, commission, nvl2(salary, salary, 0)*12 annual_salary
from employee
order by annual_salary desc;

-- 사원들의 급여 총액 , 평균액, 최고액, 최소액을 출력 하세요. 각 컬럼을 “급여총액”, “평균액, “최고액”, “최소액”으로 별칭이름으로 출력하세요.

select sum(salary) 급여총액, avg(salary) 평균액, max(salary) 최고액, min(salary) 최소액
from employee;

-- 직업 종류의 갯수를 출력 하세요.  출력컬럼을 “직업 종류의 갯수”로 별칭이름으로 출력 하세요.

select count(distinct job) "직업 종류의 갯수"
from employee;

-- 각 부서별 평균 월급을 구해서 부서번호와 평균 월급을 출력 하되 각각 “부서번호”, “평균월급” 으로 별칭이름으로 출력하세요.

select dno 부서번호, avg(salary) 평균월급
from employee
group by dno;

-- 담당 업무가 동일한 사원의 수를 구하시오. (참고 , count 함수 사용)

select job, count(job)
from employee
group by job;

-- 직급별 사원의 최저 급여를 출력하시오, 관리자를 알수 없는 사원 및 최저 급여가 2000 미만인 그룹은 제외 시키고 결과를 급여에 대한 내림차순으로 정렬하여 출력 하세요.

select min(salary)
from employee
where manager is not null
group by job
having min(salary) > 2000
order by min(salary) desc;

-- 서브 쿼리를 사용해서 사원번호가 7788인 사원과 담당업무가 같은 사원을 출력 하시오  <담당이름, 담당업무> 출력 하시오.

select ename 담당이름, job 담당업무
from employee
where job = (select job from employee where eno = 7788) and eno != 7788;

-- 서브 쿼리를 사용해서 사번이 7499 인 사원보다 급여가 많은 사원을 출력 하시오. <사원이름, 담당업무> 출력 하시오.

select ename 담당이름, job 담당업무
from employee
where salary > (select salary from employee where eno = 7499);

-- 서브 쿼리를 사용해서 각 부서의 최소 급여를 받는 사원의 이름 , 급여, 부서번호를 출력하시오.

select ename, salary, dno
from employee
where salary in (select min(salary) from employee group by dno);

-- 서브 쿼리를 사용해서 급여가 평균 급여보다 많은 사원들의 사원보호와 이름을 표시하되 결과를 급여에 대해서 오름차순으로 정렬하시오.

select eno, ename
from employee
where salary > (select avg(salary) from employee)
order by salary;

-- 서브 쿼리를 사용해서 DEPT 테이블에 있는 부서명 DNAME 컬럼에서  ‘RESEARCH’ 부서의 부서번호, 사원이름 및 담당 업무를 표시하시오.

select dno, ename, job
from employee
where dno = (select dno from dept where dname = 'RESEARCH');