-- 1. Sawon 테이블 생성
Create table sawon
(
    sabun       number(6),
    sawon_name  varchar2(15),
    ubmu        varchar2(30),
    weolgub     number(10, 2),
    buseo       number(3)
);

-- 2. sabun 기본키로 설정
alter table sawon
    add constraint pk_sabun primary key (sabun);

-- 3. jiyeok 컬럼 만들기
alter table sawon
    add jiyeok varchar2(30) not null;
    
-- 4.
alter table sawon
    modify (weolgub number(7));
    
-- 5. 
alter table sawon
    add constraint ck_sawon_ubmu check (ubmu in ('개발', '유지보수', '관리'));

-- 6.
alter table sawon
    Modify (ubmu varchar2(30) default '개발');
    
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
Insert into buseo(buseo_no, buseo_name) values (101, '소프트웨어유지보수부');
Insert into buseo(buseo_no, buseo_name) values (202, '관리부');
Insert into buseo(buseo_no, buseo_name) values (303, '인적자원부');

-- 10.
Insert into sawon(sabun, sawon_name, ubmu, weolgub, buseo, jiyeok) values (8001, '홍길동이군', null, 100000, 101, '부산');
Insert into sawon(sabun, sawon_name, ubmu, weolgub, buseo, jiyeok) values (8002, '홍길자', '사무', 200000, 202, '인천');
Insert into sawon(sabun, sawon_name, ubmu, weolgub, buseo, jiyeok) values (8003, '홍길순', '개발', null, 111, '대전');
Insert into sawon(sabun, sawon_name, ubmu, weolgub, buseo, jiyeok) values (8004, '홍길석', null, 12345678, null, '서울');
Insert into sawon(sabun, sawon_name, ubmu, weolgub, buseo, jiyeok) values (8005, '홍길철', '유지보수', null, 303, '판교');
    
-- 11.
alter table sawon
    drop (jiyeok);
    
-- 12.
delete from buseo where buseo_name = '인적자원부';

-- 13.
drop table sawon;
drop table buseo;

-- 14.
create table sawon
(
    sabun number(6),
    sawon_name varchar2(15),
    ubmu varchar2(30) default '개발',
    weolgub number(7),
    buseo number(3),
    jiyeok varchar2(30) not null,
    constraint pk_sawon_sabun primary key (sabun),
    constraint ck_sawon_ubmu check (ubmu in ('개발', '유지보수', '관리')),
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
    select 검색할 항목들
    from    테이블명
    where 조건
*/

-- 모든 사원의 사원명과 급여, 급여와 보너스를 더한 합계 출력
select  ename, sal, sal+nvl(comm,0) AS total_sal
from    emp;
-- where

SELECT ename||' '||job as staff
from emp;

select distinct job from emp;

-- 1. 20번 부서에서 근무하는 사원의 사원번호, 이름, 부서번호 출력
select empno, ename, deptno
from emp
where deptno=20;

-- 2- 입사일이 81/01/01에서 81/06/09인 사원의 사원번호, 이름, 입사일을 출력
select empno, ename, hiredate
from emp
where hiredate BETWEEN '81/01/01' and '81/06/09';
--where hiredate BETWEEN TO_DATE('1981/01/01', 'YYYY-MM-DD') 
                   --AND TO_DATE('1981/06/09', 'YYYY-MM-DD');
                   
-- 3- 담당업무가 salesman, clerk인 사원들의 이름과 업무를 출력
select ename, job
from emp
where job in ('CLERK', 'SALESMAN');
-- where job = upper('salesman') or job = upper('clerk');

-- 4- 업무가 president이고 급여가 1500이상이거나 업무가 salesman인 사원의 정보를 출력
select *
from emp
where (job = 'PRESIDENT' and sal >= 1500)
    or job = 'SALESMAN';

-- 5- 업무가 president 또는 salesman이고 급여가 1500이상인 사원의 정보를 출력
select *
from emp
where job in ('PRESIDENT', 'SALESMAN')
    and sal >= 1500;
-- where (job = 'PRESIDENT' or job = 'SALESMAN')
    --and sal >=1500;
    
-- 6- 커미션(comm)이 없는 사원의 이름, 급여, 커미션을 출력
select ename, sal, comm
from emp
where nvl(comm,0) = 0;

-- 7- 사원명, 급여, 커미션, 총급여( 급여 + 커미션)을 출력
select ename, sal, comm, sal+nvl(comm, 0) as total_sal
from emp;

-- 8- 이름 A로 시작하는 사원명 출력
select ename
from emp
where ename like 'A%';

-- 9- 이름이 두번째 문자가 L인 사원명 출력
select ename
from emp
where ename like '_L%';

-- 10- 이름에 L이 두 번 이상 포함된 사원명 출력
select ename
from emp
where ename like '%L%L%';

-- 11- 커미션(COMM)이 NULL이 아닌 사원의 모든 정보를 출력
select *
from emp
where comm is not null;

-- 12- 보너스가 급여보다 10%이상 많은 모든 사원에 대해 이름, 급여, 보너스를 출력
select ename, sal, nvl(comm, 0)
from emp
where comm >= sal*1.1;

-- 13- 업무가 clerk이거나 analyst이고 급여가 1000, 3000, 5000이 아닌 모든 사원의 정보를 출력
select *
from emp
where job in ('CLERK', 'ANALYST') and sal not in (1000, 3000, 5000);

-- 14- 부서가 30이거나 또는 관리자가 7782인 사원의 모든 정보를 출력
select *
from emp
where deptno = 30 or mgr = 7782;

-- 추가 문제

--1. EMPLOYEES 테이블에서 사원 이름을 first_name과 last_name를 합쳐 full_name으로 출력



