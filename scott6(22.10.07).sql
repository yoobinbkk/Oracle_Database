/*

서브쿼리를 어디에?
select <-- 출력할 때만, 제한적
from <-- join하거나 가상 테이블 격인 서브쿼리를 넣어서 

*/

-- 11. scott 또는 ward와 월급이 같은 사원의 정보를 이름, 업무, 급여를 출력
select empno, ename, job, sal
from emp
where sal in (select sal from emp where ename in ('SCOTT', 'WARD'));

-- 12. chicago에서 근무하는 사원과 같은 업무를 하는 사원의 이름, 업무를 출력
select ename, job
from emp
where job in (select job from emp where deptno = (select deptno from dept where loc = 'CHICAGO'));

select ename, job
from emp
where job in (select job from emp a, dept b where a.deptno=b.deptno and loc='CHICAGO');

--select ename, job
--from emp e1, (select 

-- 13. 부서별로 월급이 평균 월급보다 높은 사원을 부서번호, 이름, 급여를 출력
select deptno, ename, sal
from emp e1
where sal > (select avg(sal) from emp e2 where e1.deptno = e2.deptno group by deptno)
order by deptno;

select e1.deptno, e1.ename, e1.sal
from emp e1, (select deptno, avg(sal) avg from emp group by deptno) e2
where e1.deptno = e2.deptno and e1.sal > e2.avg
order by deptno;

select deptno 부서번호, ename 이름, sal 급여
from emp
where sal > any(select avg(sal) from emp group by deptno);

select * from emp order by deptno;

---============================================================
-- scott에 db 권한을 주었기에 뷰 생성 가능해짐

create or replace view v_emp as
    select empno, ename, deptno from emp;
    
select * from v_emp;
desc v_emp;
select * from emp;

-- 원본에도 insert 할 수 있다
insert into v_emp values (1000, '홍길동', 20);
select * from v_emp;
select * from emp;

-- 오류 primary key
insert into v_emp values (1000, '홍홍이', 20);
-- 오류 foreign key
insert into v_emp values (2000, '홍홍이', 50);

-- read only 로 설정해서 원본 테이블 훼손 방지
create or replace view v_emp as
    select empno, ename, deptno from emp
    with read only;

-- 오류 read only
insert into v_emp values (2000, '홍홍이', 30);

/*
[ 연습 ] EMP 테이블에서 30번 부서만 
EMPNO를 EMP_NO로 ENAME을 NAME로 SAL를 SALARY로 바꿔서 
EMP_30 뷰를 생성하시오
*/

create or replace view v_emp_30 as
    select empno emp_no, ename name, sal salary
    from emp
    where deptno = 30
    with read only;
    
select * from v_emp_30;

-- 복합뷰
Create or replace view v_emp_info as
select e.empno empno, e.ename ename, d.dname dname 
from emp e, dept d
where e.deptno=d.deptno;

select * from v_emp_info;

insert into v_emp_info (empno, ename, dname) values (3333, '맹꽁이', 30);
insert into v_emp_info (empno, ename) values (3333, '맹꽁이');

delete from v_emp_info where empno=7788;

-- [ 연습 ] 부서별로 부서명, 최소급여, 최대 급여, 부서의 평균 급여를 포함하는 V_DEPT_SUM 뷰를 생성하여라.

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
-- 다음 값
select sq_temp.nextval from dual;
-- 지금의 값
select sq_temp.currval from dual;

-- 5000번부터 10씩 증가하는 자동 증가수 (시퀀스)
CREATE  SEQUENCE sq_temp2
    start with 5000
    increment by 10;
-- 다음 값
select sq_temp2.nextval from dual;
-- 지금의 값
select sq_temp2.currval from dual;

insert into emp(empno, ename) values(sq_temp2.nextval, 'QUIRK');

--INDEX
desc emp;
select empno, ename, job, rowid from emp;

-- 사번(메모리) 상황에 따라 속도 다름 (예: 입출력)
-- 이름(하드디스크) 느림

rollback;

SELECT E.EMPNO EMPNO, E.ENAME ENAME, E.SAL SAL, E.DEPTNO DEPTNO, D.LOC LOC
FROM EMP E INNER JOIN DEPT D ON E.DEPTNO = D.DEPTNO
WHERE e.DEPTNO = 20;