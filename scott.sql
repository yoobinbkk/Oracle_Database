--
/*
    �̸�       name       varchar2(10)
    �ֹι�ȣ    jumin      char(15)
    ��ȭ��ȣ    tel        varchar2(20)
    ����       gender     varchar2(10)
    ����       age        number(3)
    �����     home      varchar2(20)
*/

-- CREATE TABLE table_name ( [column_name data_type] );

CREATE TABLE info_tab
(
    name        varchar2(10),
    jumin      char(15),
    tel        varchar2(20),
    gender     varchar2(10),
    age        number(3),
    home      varchar2(20)
);

-- ���̺� ���� Ȯ��
DESC info_tab;

-- ������ Ȯ��
SELECT * FROM info_tab;

/*  ���̺�� : student_score

�й�      id      char(4)
�л���    name    varchar(20)
����      kor     number(3)
����      eng     number(3)
����      total   number      --(�⺻�� 10)
���      avg     number(3,2)     -- ���ڸ��� ��ü �ڸ���, ���ڸ��� �Ҽ��� �ڸ���

*/

CREATE TABLE student_score
(
    id      char(4),
    name    varchar(20),
    kor     number(3),
    eng     number(3),
    total   number,
    avg     number(3,2)
);

DESC student_score;

DROP TABLE student_score;

-- ���� �÷��� �߰�
-- ALTER TABLE table_name ADD ( [ column_name data_type ] );

ALTER TABLE student_score ADD ( math  number(3));

-- ���� �÷��� �����ϱ�
-- ALTER TABLE table_name DROP ( [ column_name ] );

ALTER TABLE student_score DROP ( total );

-- ��� �÷����� �Ҽ��� 1�ڷ� ����
-- ALTER TABLE table_name MODIFY ( [ column_name data_type ] );

ALTER TABLE student_score MODIFY ( avg  number(3,1) );


-- ������ �Է�
    -- ���� : ''
INSERT INTO student_score( id, name, kor, eng, math ) 
    VALUES ( '0001', 'ȫ�浿', 50, 80, 75 );

SELECT * FROM student_score;

-- 2000�� �й��� ȫ������ ����, ����, ���� ������ ���� 60, 90, 55���� ����(�Է�)
INSERT INTO student_score( id, name, kor, eng, math ) 
    VALUES ( '2000', 'ȫ����', 60, 90, 55 );

-- �׻� Commit�� ����� �Ѵ�    
commit;

-- �� Ŀ������ �ѹ�
rollback;

-- 1000�� �л� ȫ��� ������ ����
INSERT INTO student_score (id, name, kor, eng)
    VALUES ('1000', 'ȫ���', 80, 70);

-- �̸��� ȫ����� �л��� ���ڵ带 ����
-- DELETE FROM table_name WHERE condition;
DELETE FROM student_score WHERE name='ȫ���';

SELECT * FROM student_score;

-- 0001�� �л��� ���� ������ 100���� �����ϱ�
-- UPDATE table_name SET column=value WHERE condition;
UPDATE student_score 
SET kor=100 
WHERE id='0001';

-- ȫ������ ���� ������ 90���� �����ϱ�
UPDATE student_score 
SET math=90 
WHERE name='ȫ����';

-- ��� �л����� ����� ���ϼ���
UPDATE student_score
SET avg = (kor + eng + nvl(math, 0)) / 3;
-- WHERE








--[ �������� ] emp ��ü emp_copy ���纻 ���̺� ���� ��
CREATE TABLE emp_copy
    AS SELECT * FROM emp;
    
DESC emp_copy;

SELECT * FROM emp_copy;

--1. �����ȣ�� 7788�� ����� �μ��� 10������ ����
UPDATE emp_copy
SET DEPTNO = 10
WHERE EMPNO = 7788;

--2. �����ȣ�� 7782�� ����� �̸��� ȫ������� �����ϰ� �޿��� 3500���� ����
UPDATE emp_copy
SET ENAME = 'ȫ���', SAL = 3500
WHERE EMPNO = 7782;

--3. ��� �μ����� ���ʽ��� 300�� �λ� ����
UPDATE emp_copy
SET COMM = nvl(comm, 0) +300;

--4. �����ȣ�� 7499�� ����� ������ ����
DELETE FROM emp_copy Where EMPNO = 7499;

--5. �Ի����ڰ� 81�� 6�� 1�� ������ ����� ������ ����
DELETE FROM emp_copy Where HIREDATE <= '81/06/01';

delete from emp_copy;

SELECT * FROM emp_copy;

rollback;

truncate table emp_copy;

--===============================================================


