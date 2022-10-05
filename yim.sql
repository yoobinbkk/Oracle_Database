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
    modify addr varchar2(100) default '¼­¿ï';

alter table student
    add constraint ck_dept_gender check (gender in ('³²¼º', '¿©¼º'));
    
INSERT INTO student(no, name, gender, addr, jumin ) 
VALUES('1111', '±èÅÂÈñ', '¿©¼º', '¼­¿ï½Ã °­³²±¸', '801212-1234567' );

INSERT INTO student(no, name, jumin ) 
VALUES('2222', '¼ÛÇý±³', '881212-1234567');

-- ¿À·ù : no primaray key¿¡ °É¸² (ÇÐ¹ø Áßº¹)
INSERT INTO student(no, name, jumin ) 
VALUES('1111', '°­µ¿¿ø', '881212-1234567');

-- ¿À·ù : gender check¿¡ °É¸² ('³²¼º'0, '³²ÀÚ'X')
INSERT INTO student(no, name, gender, jumin ) 
VALUES('3333', 'ÇÏÁ¤¿ì', '³²ÀÚ', '830303-1234567');

INSERT INTO student(no, name, addr, jumin ) 
VALUES('4444', '±è»õ·Ð', '¼­¿ï½Ã ¼­ÃÊ±¸', '990909-1234567');

-- ¿À·ù : jumin not null
-- ¿À·ù : foreign key (deptno != 50)
INSERT INTO student(no, name, addr, deptno ) 
VALUES('8888', 'ÀÌº´Çå', '¼­¿ï½Ã ÇÑ°­', 50);

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

-- ¿À·ù : foreign key·Î studentÀÇ parent key¸¦ ¹ß°ßÇÏÁö ¸øÇÔ (studentÀÇ no°¡ ¾øÀ½)
INSERT INTO library ( rent_id, book_id, hakbun ) VALUES( 3, 'bk003', '3333' );

INSERT INTO library ( rent_id, book_id, hakbun ) VALUES( 4, 'bk004', '4444' );

-- ¿À·ù : foreign key·Î studentÀÇ parent key¸¦ ¹ß°ßÇÏÁö ¸øÇÔ (studentÀÇ no°¡ ¾øÀ½)
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
, CONSTRAINT EMP_CK_GENDER CHECK (GENDER IN ('³²¼º', '¿©¼º'))
, CONSTRAINT FK_DEPTNO FOREIGN KEY (DEPTID) REFERENCES DEPT(DEPTID)

);


-- TEST DML (INSERT)

-- INSERT (TABLE: DEPT)
INSERT INTO DEPT(DEPTID, DEPTNAME)
VALUES (10001, 'ITÆÀ');

INSERT INTO DEPT(DEPTID, DEPTNAME)
VALUES (10002, '»ý»ê¿î¿µÆÀ');

INSERT INTO DEPT(DEPTID, DEPTNAME)
VALUES (10003, '»ý»ê±â¼úÆÀ');

-- INSERT (TABLE: EMP)
INSERT INTO EMP(EMPID, NAME, RESID, GENDER, AGE, DEPTID)
VALUES (30001, 'ÃÖ°¡Àº', '881012-1187527', '¿©¼º', 32, 10001);

INSERT INTO EMP(EMPID, NAME, RESID, GENDER, AGE, DEPTID)
VALUES (30002, '±èÈ¿ÁØ', '850712-1000007', '³²¼º', 35, 10002);

INSERT INTO EMP(EMPID, NAME, RESID, GENDER, AGE, DEPTID)
VALUES (30003, '¼­Á¾±Õ', '881112-1187527', '³²¼º', 32, 10003);


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
, CONSTRAINT EMP_CK_GENDER CHECK (GENDER IN ('³²¼º', '¿©¼º'))
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
, CONSTRAINT EMP_CK_GENDER CHECK (GENDER IN ('³²¼º', '¿©¼º'))
, CONSTRAINT FK_DEPTNO FOREIGN KEY (DEPTID) 
REFERENCES DEPT(DEPTID) ON DELETE SET NULL

);


--=============================================================

-- Å×ÀÌºí »ý¼º
CREATE TABLE reg_tab( text varchar2(20));

-- ·¹ÄÚµå ÀÔ·Â
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
INSERT INTO reg_tab VALUES('°³');
INSERT INTO reg_tab VALUES('cat');
INSERT INTO reg_tab VALUES('catty');
INSERT INTO reg_tab VALUES('9catty');
INSERT INTO reg_tab VALUES('catwoman');
INSERT INTO reg_tab VALUES('°í¾çÀÌ');
INSERT INTO reg_tab VALUES('BAT');
INSERT INTO reg_tab VALUES('BATMAN');
INSERT INTO reg_tab VALUES('BATGIRL'); 
INSERT INTO reg_tab VALUES('0BATGIRL'); 
INSERT INTO reg_tab VALUES('¹ÚÁã');

commit;

-----------------------------------------------

-- 1.  text ÄÃ·³ÀÇ ¹®ÀÚ¿­¿¡¼­ 't'·Î ½ÃÀÛÇÏ´Â µ¥ÀÌÅÍ °Ë»ö
select *
from reg_tab
where REGEXP_LIKE(text, '^t');

-- 2.  text ÄÃ·³ÀÇ ¹®ÀÚ¿­¿¡¼­ 't'·Î ³¡³ª´Â µ¥ÀÌÅÍ °Ë»ö
select *
from reg_tab
where REGEXP_LIKE(text, 't$');

-- 3. Ã¹¹øÂ° 't'·Î ½ÃÀÛÇÏ¿© 5¹øÂ° 'r'ÀÌ ÀÖ´Â µ¥ÀÌÅÍ °Ë»ö
select *
from reg_tab
where REGEXP_LIKE(text, '^t...r');

-- 4. ¼ýÀÚ·Î ³¡³ª´Â µ¥ÀÌÅÍ °Ë»ö
select *
from reg_tab
where REGEXP_LIKE(text, '[0-9]$');

-- 5. ¼ýÀÚ·Î ½ÃÀÛÇÏ´Â µ¥ÀÌÅ¸ °Ë»ö
select *
from reg_tab
where REGEXP_LIKE(text, '^[0-9]');

-- 6. ¼ýÀÚ°¡ ¾Æ´Ñ ¹®ÀÚ·Î ½ÃÀÛÇÏ´Â µ¥ÀÌÅÍ °Ë»ö
select *
from reg_tab
where not REGEXP_LIKE(text, '^[0-9]');

-- 7. ´ë¹®ÀÚ·Î ½ÃÀÛÇÏ´Â µ¥ÀÌÅÍ °Ë»ö
select *
from reg_tab
where REGEXP_LIKE(text, '^[A-Z]');

-- 8. ¼Ò¹®ÀÚ ¿ÜÀÇ ¹®ÀÚ·Î ½ÃÀÛÇÏ´Â µ¥ÀÌÅÍ °Ë»ö
select *
from reg_tab
where not REGEXP_LIKE(text, '^[a-z]');

-- 9. ÇÑ±Û·Î ½ÃÀÛÇÏ´Â µ¥ÀÌÅÍ °Ë»ö
select *
from reg_tab
where REGEXP_LIKE(text, '^[°¡-ÆR]');

-- 10. µ¥ÀÌÅÍ Áß 'gg'³ª 'GG'°¡ µé¾îÀÖ´Â µ¥ÀÌÅÍ °Ë»ö
select *
from reg_tab
where REGEXP_LIKE(text, 'gg|GG');