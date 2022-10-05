--
/*
    이름       name       varchar2(10)
    주민번호    jumin      char(15)
    전화번호    tel        varchar2(20)
    성별       gender     varchar2(10)
    나이       age        number(3)
    출신지     home      varchar2(20)
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

-- 테이블 구조 확인
DESC info_tab;

-- 데이터 확인
SELECT * FROM info_tab;

/*  테이블명 : student_score

학번      id      char(4)
학생명    name    varchar(20)
국어      kor     number(3)
영어      eng     number(3)
총점      total   number      --(기본이 10)
평균      avg     number(3,2)     -- 앞자리는 전체 자리수, 뒷자리는 소숫점 자리수

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

-- 수학 컬럼을 추가
-- ALTER TABLE table_name ADD ( [ column_name data_type ] );

ALTER TABLE student_score ADD ( math  number(3));

-- 총점 컬럼을 삭제하기
-- ALTER TABLE table_name DROP ( [ column_name ] );

ALTER TABLE student_score DROP ( total );

-- 평균 컬럼에서 소수점 1자로 변경
-- ALTER TABLE table_name MODIFY ( [ column_name data_type ] );

ALTER TABLE student_score MODIFY ( avg  number(3,1) );


-- 데이터 입력
    -- 문자 : ''
INSERT INTO student_score( id, name, kor, eng, math ) 
    VALUES ( '0001', '홍길동', 50, 80, 75 );

SELECT * FROM student_score;

-- 2000번 학번인 홍길자의 국어, 영어, 수학 점수를 각각 60, 90, 55으로 저장(입력)
INSERT INTO student_score( id, name, kor, eng, math ) 
    VALUES ( '2000', '홍길자', 60, 90, 55 );

-- 항상 Commit를 해줘야 한다    
commit;

-- 전 커밋으로 롤백
rollback;

-- 1000번 학생 홍길숙 정보를 저장
INSERT INTO student_score (id, name, kor, eng)
    VALUES ('1000', '홍길숙', 80, 70);

-- 이름이 홍길숙인 학생의 레코드를 삭제
-- DELETE FROM table_name WHERE condition;
DELETE FROM student_score WHERE name='홍길숙';

SELECT * FROM student_score;

-- 0001번 학생의 국어 점수를 100으로 수정하기
-- UPDATE table_name SET column=value WHERE condition;
UPDATE student_score 
SET kor=100 
WHERE id='0001';

-- 홍길자의 수학 점수를 90으로 수정하기
UPDATE student_score 
SET math=90 
WHERE name='홍길자';

-- 모든 학생들의 평균을 구하세요
UPDATE student_score
SET avg = (kor + eng + nvl(math, 0)) / 3;
-- WHERE








--[ 연습문제 ] emp 전체 emp_copy 복사본 테이블 생성 후
CREATE TABLE emp_copy
    AS SELECT * FROM emp;
    
DESC emp_copy;

SELECT * FROM emp_copy;

--1. 사원번호가 7788인 사원의 부서를 10번으로 변경
UPDATE emp_copy
SET DEPTNO = 10
WHERE EMPNO = 7788;

--2. 사원번호가 7782인 사원의 이름을 홍길숙으로 변경하고 급여를 3500으로 변경
UPDATE emp_copy
SET ENAME = '홍길숙', SAL = 3500
WHERE EMPNO = 7782;

--3. 모든 부서원의 보너스를 300씩 인상 변경
UPDATE emp_copy
SET COMM = nvl(comm, 0) +300;

--4. 사원번호가 7499인 사원의 정보를 삭제
DELETE FROM emp_copy Where EMPNO = 7499;

--5. 입사일자가 81년 6월 1일 이전인 사원의 정보를 삭제
DELETE FROM emp_copy Where HIREDATE <= '81/06/01';

delete from emp_copy;

SELECT * FROM emp_copy;

rollback;

truncate table emp_copy;

--===============================================================


