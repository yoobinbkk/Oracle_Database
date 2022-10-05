--1. 이름의 성이 'King' 사원의 사번과 부서명을 출력 ( employees, departments )
select e.employee_id id, d.department_name dname
from employees e inner join departments d
on e.department_id = d.department_id and e.last_name = 'King';

--2. 이름의 성이 'King' 사원의 사번과 부서명 그리고 업무명을 출력 ( employees, departments, jobs )
select e.employee_id id, d.department_name dname, j.job_title jobname
from employees e, departments d, jobs j 
where e.department_id = d.department_id 
      and e.job_id = j.job_id
      and e.last_name = 'King';

select e.employee_id id, d.department_name dname, j.job_title jobname
from employees e inner join departments d on e.department_id = d.department_id 
                 inner join jobs j on e.job_id = j.job_id
where e.last_name = 'King';
                 
--3. 2007년 상반기에 입사한 사원들의 사번과 이름, 입사일 그리고 부서명을 출력
    --(*) Grant는 아직 부서가 배정받지 못한 상태이지만 Grant도 출력되려면
select e.employee_id id, e.first_name || ' ' || e.last_name ename, e.hire_date hiredate, d.department_name dname
from employees e, departments d
where e.department_id = d.department_id(+) and hire_date between '2007/01/01' and '2007/06/30';

select e.employee_id id, e.first_name || ' ' || e.last_name ename, e.hire_date hiredate, d.department_name dname
from employees e left outer join departments d
on e.department_id = d.department_id 
where hire_date between '2007/01/01' and '2007/06/30';

--4. 'Executive' 부서에서 사원과 해당 사원의 매니저(상사) 이름을 출력
    --(*) 매니저(상사)가 없는 사원인 'King'이 출력되려면
select e1.first_name || ' ' || e1.last_name ename, e2.first_name || ' ' || e2.last_name mgrname
from employees e1, employees e2
where e1.manager_id = e2.employee_id(+);

select e1.first_name || ' ' || e1.last_name ename, e2.first_name || ' ' || e2.last_name mgrname
from employees e1 left outer join employees e2
on e1.manager_id = e2.employee_id;


/*
-- SQL 문제1
select s.이름, avg(e.학점) avg
from enroll e, student s, class c
where e.학번 = s.학번 and e.강좌번호 = c.강좌번호 and avg(e.학점) >= 3.0;

select s.이름, avg(e.학점) avg
from enroll e inner join student s  on e.학번 = s.학번
              inner join class c    on e.강좌번호 = c.강좌번호
where avg(e.학점) >= 3.0;

-- SQL 문제2
select d.deptno, d.dname
from dept d full outer join emp e
on d.deptno=e.deptno;


<결과>
| deptno | dname |
|   10   |  RESEARCH  |
|   30   |  SALES  |
|   40   |  WARD  |
*/

