--1. 2003년에 입사한 사원들의 사번, 이름, 입사일을 출력
select employee_id, first_name || ' ' || last_name full_name, hire_date
from employees
where to_char(hire_date, 'YYYY') = '2003';

--2. 업무가 FI_ACCOUNT / FI_MGR / SA_MAN / SA_REP 인 사원들의 정보를 출력
select *
from employees
where job_id in ('FI_ACCOUNT', 'FI_MGR', 'SA_MAN', 'SA_REP');

--3. 커미션을 받는 사원들의 명단을 출력
select first_name || ' ' || last_name full_name
from employees
where commission_pct > 0;

--4.업무가 SA_MAN 또는 SA_REP이면 "판매부서"를 그 외는 "그 외 부서"라고 출력
select first_name || ' ' || last_name full_name, decode(job_id, 'SA_MAN', '판매부서', 'SA_REP', '판매부서', '그 외 부서') as Job
from employees;

select first_name || ' ' || last_name full_name, 
    case job_id
        when 'SA_MAN' then '판매부서'
        when 'SA_REP' then '판매부서'
        else '그 외 부서'
        end as job
from employees;

--5. 연도별로 입사자들의 최소급여, 최대 급여, 급여의 총합 그리고 평균 급여를 구하시오
select to_char(hire_date, 'YYYY') hire_year, min(salary) min, max(salary) max, sum(salary) sum, round(avg(salary)) avg
from employees
group by to_char(hire_date, 'YYYY')
order by to_char(hire_date, 'YYYY');

--6. 부서별 평균 급여가 $10,000 이상인 부서만 구하시오. ( 평균급여가 높은 순으로 )
select department_id
from employees
group by department_id
having avg(salary) >= 10000
order by avg(salary) desc;

--7. 부서별 최대 급여를 구하시오
select department_id, max(salary) max
from employees
group by department_id
order by department_id;