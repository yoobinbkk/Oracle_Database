CREATE TABLE info_tab 
( 
    name    varchar2(10),
    jumin   char(15),
    tel     varchar2(20),
    gender  varchar2(10),
    age     number(3),
    home    varchar2(20),
    CONSTRAINT pk_info_tel PRIMARY KEY (tel)
);

INSERT into info_tab(tel, name) values ('1001', '홍길동');
INSERT into info_tab(tel, name) values ('1002', '김길동');
INSERT into info_tab(tel, name) values ('1002', '둘리');
INSERT into info_tab(name, jumin) values ('김길동', '901212-1234567');
INSERT into info_tab(gender, age) values ('남자', 22);
INSERT into info_tab(tel, gender, age) values (9999, '남자', 22);

delete from info_tab;

DROP TABLE info_tab;

alter table info_tab
    Modify (name varchar2(10) not null);
    
alter table info_tab
    add constraint uq_info_jumin unique (jumin);

insert into info_tab (tel, name, jumin) values ('20001', '홍실이', '990101');
insert into info_tab (tel, name, jumin) values ('20002', '홍동이', '990101');
insert into info_tab (tel, name) values ('20003', '홍홍이');

alter table info_tab
    add constraint ck_info_gender check (gender in ('남성', '여성'));

insert into info_tab (tel, name, gender) values ('10001', '홍돌이', '남성');
insert into info_tab (tel, name, gender) values ('10002', '홍숙이', '남자');
insert into info_tab (tel, name, gender) values ('10003', '홍숙이', '여성');

alter table info_tab
    modify (gender varchar2(6) default '남성');
    
insert into info_tab(tel, name) values ('7777', '홍이');


-- [확인]

INSERT INTO info_tab( name, tel, jumin ) 
VALUES('갑순이', '02-777-4444', '990909-1234567');

INSERT INTO info_tab( name, tel, jumin, gender, age, home )
VALUES('갑갑이','03-555-5555', '880808-1234567', '남자', 27,'경기');

INSERT INTO info_tab( name, tel, jumin, gender, age, home )
VALUES('홍길동','03-031-0310', '900909-1234567', '남성', 27,'경기');

INSERT INTO info_tab( name, jumin) VALUES('홍길자', '550505-1234567');

INSERT INTO info_tab( tel, jumin ) VALUES('031-777-7777', '700707-1234567');

INSERT INTO info_tab( name, tel, jumin ) VALUES('갑동이', '031-000-0000', '700707-1234567');

drop table info_tab;


CREATE TABLE info_tab 
( 
    name    varchar2(10) not null,
    jumin   char(15),
    tel     varchar2(20),
    gender  varchar2(10) default '남성',
    age     number(3),
    home    varchar2(20),
    DEPARTMENT_ID   NUMBER(4,0),
    CONSTRAINT pk_info_tel PRIMARY KEY (tel),
    CONSTRAINT uq_info_jumin unique (jumin),
    CONSTRAINT ck_info_gender check (gender in ('남성', '여성')),
    CONSTRAINT fk_info_DEPARTMENT_ID foreign key(DEPARTMENT_ID) references DEPARTMENTs (DEPARTMENT_ID)
);

insert into info_tab(tel, name, department_id) values('7777', '맹이', 20);
insert into info_tab(tel, name, department_id) values('8888', '꽁이', 22);
insert into info_tab(tel, name) values('9999', '짱이');

--=======================================================

-- [추가 연습] 검색 기초

--1. EMPLOYEES 테이블에서 사원 이름을 first_name과 last_name를 합쳐 full_name으로 출력
select first_name|| ' ' ||last_name as full_name
from employees;

--2. 부서번호가 30(구매부서)이고 급여 10000미만인 사원의 full_name과 월급,부서번호를 출력
select first_name|| ' ' ||last_name as full_name, salary, department_id
from employees
where (department_id = 30 and salary < 10000);

--3. 부서번호가 30이고 급여가 10000달러 이하를 받는 2006년도 이전 입사한 사원의 full_name을 출력
select first_name|| ' ' ||last_name full_name
from employees
where (department_id = 30 and salary <= 10000)
    and hire_date < '06.01.01';
    
--4. 부서번호가 30(구매부서)이고 급여가 10000이하인 사원과 부서번호가 60(IT부서)에서 급여가 5000이상인 사원을 조회
select *
from employees
where (department_id = 30 and salary <= 10000) or (department_id = 60 and salary >= 5000);

--5. 사원번호가 110번에서 120번인 사원 중 급여가 5000에서 10000사이의 사원명단을 조회
select *
from employees
where (employee_id between 110 and 120) and (salary between 5000 and 10000);

--6. 사원번호가 110번에서 120번이 아닌 사원을 조회
select *
from employees
where employee_id not between 110 and 120;

--7. 부서번호가 30(구매부서), 60(IT부서), 90(경영부서)에 속한 사원을 조회
select *
from employees
where department_id in (30, 60, 90);

--8. 부서번호가 30(구매부서), 60(IT부서), 90(경영부서) 외의 부서에 속한 사원을 조회
select *
from employees
where department_id not in (30, 60, 90);

--9. 전화번호에서 590으로 시작하는 사원명과 전화번호를 조회
select first_name|| ' ' ||last_name as full_name, phone_number
from employees
where phone_number like '590%';


