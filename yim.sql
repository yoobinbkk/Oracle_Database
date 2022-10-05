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
    modify addr varchar2(100) default '����';

alter table student
    add constraint ck_dept_gender check (gender in ('����', '����'));
    
INSERT INTO student(no, name, gender, addr, jumin ) 
VALUES('1111', '������', '����', '����� ������', '801212-1234567' );

INSERT INTO student(no, name, jumin ) 
VALUES('2222', '������', '881212-1234567');

-- ���� : no primaray key�� �ɸ� (�й� �ߺ�)
INSERT INTO student(no, name, jumin ) 
VALUES('1111', '������', '881212-1234567');

-- ���� : gender check�� �ɸ� ('����'0, '����'X')
INSERT INTO student(no, name, gender, jumin ) 
VALUES('3333', '������', '����', '830303-1234567');

INSERT INTO student(no, name, addr, jumin ) 
VALUES('4444', '�����', '����� ���ʱ�', '990909-1234567');

-- ���� : jumin not null
-- ���� : foreign key (deptno != 50)
INSERT INTO student(no, name, addr, deptno ) 
VALUES('8888', '�̺���', '����� �Ѱ�', 50);

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

-- ���� : foreign key�� student�� parent key�� �߰����� ���� (student�� no�� ����)
INSERT INTO library ( rent_id, book_id, hakbun ) VALUES( 3, 'bk003', '3333' );

INSERT INTO library ( rent_id, book_id, hakbun ) VALUES( 4, 'bk004', '4444' );

-- ���� : foreign key�� student�� parent key�� �߰����� ���� (student�� no�� ����)
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
, CONSTRAINT EMP_CK_GENDER CHECK (GENDER IN ('����', '����'))
, CONSTRAINT FK_DEPTNO FOREIGN KEY (DEPTID) REFERENCES DEPT(DEPTID)

);


-- TEST DML (INSERT)

-- INSERT (TABLE: DEPT)
INSERT INTO DEPT(DEPTID, DEPTNAME)
VALUES (10001, 'IT��');

INSERT INTO DEPT(DEPTID, DEPTNAME)
VALUES (10002, '������');

INSERT INTO DEPT(DEPTID, DEPTNAME)
VALUES (10003, '��������');

-- INSERT (TABLE: EMP)
INSERT INTO EMP(EMPID, NAME, RESID, GENDER, AGE, DEPTID)
VALUES (30001, '�ְ���', '881012-1187527', '����', 32, 10001);

INSERT INTO EMP(EMPID, NAME, RESID, GENDER, AGE, DEPTID)
VALUES (30002, '��ȿ��', '850712-1000007', '����', 35, 10002);

INSERT INTO EMP(EMPID, NAME, RESID, GENDER, AGE, DEPTID)
VALUES (30003, '������', '881112-1187527', '����', 32, 10003);


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
, CONSTRAINT EMP_CK_GENDER CHECK (GENDER IN ('����', '����'))
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
, CONSTRAINT EMP_CK_GENDER CHECK (GENDER IN ('����', '����'))
, CONSTRAINT FK_DEPTNO FOREIGN KEY (DEPTID) 
REFERENCES DEPT(DEPTID) ON DELETE SET NULL

);


--=============================================================

-- ���̺� ����
CREATE TABLE reg_tab( text varchar2(20));

-- ���ڵ� �Է�
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
INSERT INTO reg_tab VALUES('��');
INSERT INTO reg_tab VALUES('cat');
INSERT INTO reg_tab VALUES('catty');
INSERT INTO reg_tab VALUES('9catty');
INSERT INTO reg_tab VALUES('catwoman');
INSERT INTO reg_tab VALUES('�����');
INSERT INTO reg_tab VALUES('BAT');
INSERT INTO reg_tab VALUES('BATMAN');
INSERT INTO reg_tab VALUES('BATGIRL'); 
INSERT INTO reg_tab VALUES('0BATGIRL'); 
INSERT INTO reg_tab VALUES('����');

commit;

-----------------------------------------------

-- 1.  text �÷��� ���ڿ����� 't'�� �����ϴ� ������ �˻�
select *
from reg_tab
where REGEXP_LIKE(text, '^t');

-- 2.  text �÷��� ���ڿ����� 't'�� ������ ������ �˻�
select *
from reg_tab
where REGEXP_LIKE(text, 't$');

-- 3. ù��° 't'�� �����Ͽ� 5��° 'r'�� �ִ� ������ �˻�
select *
from reg_tab
where REGEXP_LIKE(text, '^t...r');

-- 4. ���ڷ� ������ ������ �˻�
select *
from reg_tab
where REGEXP_LIKE(text, '[0-9]$');

-- 5. ���ڷ� �����ϴ� ����Ÿ �˻�
select *
from reg_tab
where REGEXP_LIKE(text, '^[0-9]');

-- 6. ���ڰ� �ƴ� ���ڷ� �����ϴ� ������ �˻�
select *
from reg_tab
where not REGEXP_LIKE(text, '^[0-9]');

-- 7. �빮�ڷ� �����ϴ� ������ �˻�
select *
from reg_tab
where REGEXP_LIKE(text, '^[A-Z]');

-- 8. �ҹ��� ���� ���ڷ� �����ϴ� ������ �˻�
select *
from reg_tab
where not REGEXP_LIKE(text, '^[a-z]');

-- 9. �ѱ۷� �����ϴ� ������ �˻�
select *
from reg_tab
where REGEXP_LIKE(text, '^[��-�R]');

-- 10. ������ �� 'gg'�� 'GG'�� ����ִ� ������ �˻�
select *
from reg_tab
where REGEXP_LIKE(text, 'gg|GG');