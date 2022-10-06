-- [연습 2] <서브쿼리>
-- hr database / employees table

-- 1. Zlotkey와 동일한 부서에 속한 모든 사원의 이름과 입사일을 표시하는 질의를 작성하십시오. 
   -- Zlotkey는 제외하십시오.
   
select first_name || ' ' || last_name name, hire_date, department_id
from employees
where department_id = (select department_id from employees where last_name='Zlotkey')
    and last_name != 'Zlotkey';

-- 2. 급여가 평균 급여보다 많은 모든 사원의 사원 번호와 이름을 표시하는 질의를 작성하고 
   -- 결과를 급여에 대해 오름차순으로 정렬하십시오.

select EMPLOYEE_ID, first_name || ' ' || last_name name, salary
from employees
where salary > (select avg(salary) from employees)
order by salary desc;

select avg(salary)
from employees;

-- 3. 이름에 u가 포함된 사원과 같은 부서에서 일하는 모든 사원의 사원 번호와 이름을 표시하는 질의를 작성하십시오.
select EMPLOYEE_ID, first_name || ' ' || last_name name, department_id
from employees
-- where department_id in (select department_id from employees where first_name like '%u%' or last_name like '%u%');
where department_id in (select department_id from employees where first_name || ' ' || last_name like '%u%');

-- 4. 부서 위치 ID가 1700인 모든 사원의 이름, 부서 번호 및 업무 ID를 표시하십시오.
select first_name || ' ' || last_name name, department_id, JOB_ID
from employees
where department_id in (select department_id from departments where location_id = 1700);

-- 5. King에게 보고하는 모든 사원의 이름과 급여를 표시하십시오.
select first_name || ' ' || last_name name, salary, manager_id
from employees
where manager_id in (select employee_id from employees e2 where last_name = 'King');

-- 6. Executive 부서의 모든 사원에 대한 부서 번호, 이름 및 업무 ID를 표시하십시오.
select department_id, first_name || ' ' || last_name name, job_id
from employees
where department_id in (select department_id from departments where department_name = 'Executive');

-- 7. 평균 급여보다 많은 급여를 받고 이름에 u가 포함된 사원과 같은 부서에서 근무하는 모든 사원의 사원 번호, 이름 및 급여를 표시하는 질의를 작성하십시오.
select EMPLOYEE_ID, first_name || ' ' || last_name name, salary, department_id
from employees
where salary > (select avg(salary) from employees)
    and department_id in (select department_id from employees where first_name || ' ' || last_name like '%u%');
    
select first_name || ' ' || last_name name, department_id
from employees
where first_name || ' ' || last_name like '%u%'
order by department_id;


