create table dept as select * from scott.dept;

desc dept;

select * from dept;

alter table dept
    add constraint pk_deptno primary key (deptno);
    
create table student
(
    no      char(4),
    name    varchar2(15) not null,
    gender  varchar2(10),
    addr    varchar2(100),
    jumin   char(15) not null,
    deptno  number(2),
    CONSTRAINT fk_dept_deptno FOREIGN KEY (deptno) references dept (deptno)
);

drop table student;

alter table student
    add constraint pk_dept_no primary key (no);

alter table student
    modify jumin char(15);
    
alter table student
    modify addr varchar2(100) default '서울';

alter table student
    add constraint ck_dept_gender check (gender in ('남성', '여성'));
    
INSERT INTO student(no, name, gender, addr, jumin ) 
VALUES('1111', '김태희', '여성', '서울시 강남구', '801212-1234567' );

INSERT INTO student(no, name, jumin ) 
VALUES('2222', '송혜교', '881212-1234567');

-- 오류 : no primaray key에 걸림 (학번 중복)
INSERT INTO student(no, name, jumin ) 
VALUES('1111', '강동원', '881212-1234567');

-- 오류 : gender check에 걸림 ('남성'0, '남자'X')
INSERT INTO student(no, name, gender, jumin ) 
VALUES('3333', '하정우', '남자', '830303-1234567');

INSERT INTO student(no, name, addr, jumin ) 
VALUES('4444', '김새론', '서울시 서초구', '990909-1234567');

-- 오류 : jumin not null
-- 오류 : foreign key (deptno != 50)
INSERT INTO student(no, name, addr, deptno ) 
VALUES('8888', '이병헌', '서울시 한강', 50);

create table library
(
    rent_id number(1),
    book_id varchar2(10) not null,
    hakbun char(4),
    constraint pk_library_rent_id primary key (rent_id),
    constraint fk_library_hakbun foreign key (hakbun) references student (no)
);

INSERT INTO library ( rent_id, book_id, hakbun ) VALUES( 1, 'bk001', '1111' );

INSERT INTO library ( rent_id, book_id, hakbun ) VALUES( 2, 'bk002', '2222' );

-- 오류 : foreign key로 student의 parent key를 발견하지 못함 (student의 no가 없음)
INSERT INTO library ( rent_id, book_id, hakbun ) VALUES( 3, 'bk003', '3333' );

INSERT INTO library ( rent_id, book_id, hakbun ) VALUES( 4, 'bk004', '4444' );

-- 오류 : foreign key로 student의 parent key를 발견하지 못함 (student의 no가 없음)
INSERT INTO library ( rent_id, book_id, hakbun ) VALUES( 5, 'bk005', '5555' );

drop table dept;
drop table student;
drop table library;

--------------------------------

CREATE TABLE DEPT(
    DEPTID NUMBER(5),
    DEPTNAME VARCHAR(50),
    CONSTRAINT PK_DEPT_DEPTID PRIMARY KEY(DEPTID)
);


CREATE TABLE EMP(

EMPID NUMBER(5) 
, NAME VARCHAR2(20) 
, RESID CHAR(14) 
, GENDER VARCHAR2(10) 
, AGE NUmBER(5) 
, DEPTID NUMBER(5) NOT NULL
, CONSTRAINT PK_EMP_EMPID PRIMARY KEY (EMPID)
, CONSTRAINT UK_EMP_RESID UNIQUE (RESID)
, CONSTRAINT EMP_CK_GENDER CHECK (GENDER IN ('남성', '여성'))
, CONSTRAINT FK_DEPTNO FOREIGN KEY (DEPTID) REFERENCES DEPT(DEPTID)

);


-- TEST DML (INSERT)

-- INSERT (TABLE: DEPT)
INSERT INTO DEPT(DEPTID, DEPTNAME)
VALUES (10001, 'IT팀');

INSERT INTO DEPT(DEPTID, DEPTNAME)
VALUES (10002, '생산운영팀');

INSERT INTO DEPT(DEPTID, DEPTNAME)
VALUES (10003, '생산기술팀');

-- INSERT (TABLE: EMP)
INSERT INTO EMP(EMPID, NAME, RESID, GENDER, AGE, DEPTID)
VALUES (30001, '최가은', '881012-1187527', '여성', 32, 10001);

INSERT INTO EMP(EMPID, NAME, RESID, GENDER, AGE, DEPTID)
VALUES (30002, '김효준', '850712-1000007', '남성', 35, 10002);

INSERT INTO EMP(EMPID, NAME, RESID, GENDER, AGE, DEPTID)
VALUES (30003, '서종균', '881112-1187527', '남성', 32, 10003);


-- TEST DML (DELETE)
DELETE FROM DEPT WHERE DEPTID = 10003;

-- SELECT ALL (BOTH)
SELECT * FROM DEPT;
SELECT * FROM EMP;

-- DROP (BOTH)
DROP TABLE EMP;
DROP TABLE DEPT;

--------------------------

CREATE TABLE DEPT(

DEPTID NUMBER(5)
, DEPTNAME VARCHAR(50)
, CONSTRAINT PK_DEPT_DEPTID PRIMARY KEY(DEPTID)

);

CREATE TABLE EMP(

EMPID NUMBER(5) 
, NAME VARCHAR2(20) 
, RESID CHAR(14) 
, GENDER VARCHAR2(10) 
, AGE NUMBER(5) 
, DEPTID NUMBER(5) NOT NULL
, CONSTRAINT PK_EMP_EMPID PRIMARY KEY (EMPID)
, CONSTRAINT UK_EMP_RESID UNIQUE (RESID)
, CONSTRAINT EMP_CK_GENDER CHECK (GENDER IN ('남성', '여성'))
, CONSTRAINT FK_DEPTNO FOREIGN KEY (DEPTID) 
REFERENCES DEPT(DEPTID) ON DELETE CASCADE

);

rollback;

-----------------------------

CREATE TABLE DEPT(

DEPTID NUMBER(5)
, DEPTNAME VARCHAR(50)
, CONSTRAINT PK_DEPT_DEPTID PRIMARY KEY(DEPTID)

);


CREATE TABLE EMP(

EMPID NUMBER(5) 
, NAME VARCHAR2(20) 
, RESID CHAR(14) 
, GENDER VARCHAR2(10) 
, AGE NUMBER(5) 
, DEPTID NUMBER(5) 
, CONSTRAINT PK_EMP_EMPID PRIMARY KEY (EMPID)
, CONSTRAINT UK_EMP_RESID UNIQUE (RESID)
, CONSTRAINT EMP_CK_GENDER CHECK (GENDER IN ('남성', '여성'))
, CONSTRAINT FK_DEPTNO FOREIGN KEY (DEPTID) 
REFERENCES DEPT(DEPTID) ON DELETE SET NULL

);


--=============================================================

-- 테이블 생성
CREATE TABLE reg_tab( text varchar2(20));

-- 레코드 입력
INSERT INTO reg_tab VALUES('TIGER');
INSERT INTO reg_tab VALUES('TIGGER');
INSERT INTO reg_tab VALUES('elephant');
INSERT INTO reg_tab VALUES('tiger');
INSERT INTO reg_tab VALUES('tiger2');
INSERT INTO reg_tab VALUES('tiger3');
INSERT INTO reg_tab VALUES('doggy');
INSERT INTO reg_tab VALUES('5doggy');
INSERT INTO reg_tab VALUES('DOG');
INSERT INTO reg_tab VALUES('DOG2');
INSERT INTO reg_tab VALUES('개');
INSERT INTO reg_tab VALUES('cat');
INSERT INTO reg_tab VALUES('catty');
INSERT INTO reg_tab VALUES('9catty');
INSERT INTO reg_tab VALUES('catwoman');
INSERT INTO reg_tab VALUES('고양이');
INSERT INTO reg_tab VALUES('BAT');
INSERT INTO reg_tab VALUES('BATMAN');
INSERT INTO reg_tab VALUES('BATGIRL'); 
INSERT INTO reg_tab VALUES('0BATGIRL'); 
INSERT INTO reg_tab VALUES('박쥐');

commit;

-----------------------------------------------

-- 1.  text 컬럼의 문자열에서 't'로 시작하는 데이터 검색
select *
from reg_tab
where REGEXP_LIKE(text, '^t');

-- 2.  text 컬럼의 문자열에서 't'로 끝나는 데이터 검색
select *
from reg_tab
where REGEXP_LIKE(text, 't$');

-- 3. 첫번째 't'로 시작하여 5번째 'r'이 있는 데이터 검색
select *
from reg_tab
where REGEXP_LIKE(text, '^t...r');

-- 4. 숫자로 끝나는 데이터 검색
select *
from reg_tab
where REGEXP_LIKE(text, '[0-9]$');

-- 5. 숫자로 시작하는 데이타 검색
select *
from reg_tab
where REGEXP_LIKE(text, '^[0-9]');

-- 6. 숫자가 아닌 문자로 시작하는 데이터 검색
select *
from reg_tab
where not REGEXP_LIKE(text, '^[0-9]');

-- 7. 대문자로 시작하는 데이터 검색
select *
from reg_tab
where REGEXP_LIKE(text, '^[A-Z]');

-- 8. 소문자 외의 문자로 시작하는 데이터 검색
select *
from reg_tab
where not REGEXP_LIKE(text, '^[a-z]');

-- 9. 한글로 시작하는 데이터 검색
select *
from reg_tab
where REGEXP_LIKE(text, '^[가-힣]');

-- 10. 데이터 중 'gg'나 'GG'가 들어있는 데이터 검색
select *
from reg_tab
where REGEXP_LIKE(text, 'gg|GG');