CREATE TABLE GuestTB
(
MESSAGE_ID 		NUMBER			PRIMARY KEY,
GUEST_NAME		VARCHAR2(10)	NOT NULL,
PASSWORD		VARCHAR2(10)	NOT NULL,
MESSAGE			VARCHAR2(1024)	NOT NULL
);

CREATE SEQUENCE seq_guestTb_messageId;

/*
	페이징
	 - 추후에 프레임워크(springboot/mybatis 등)에 페이징 기법을 쉽게 사용
	 - 오라클
		' hint
		' row_number()
*/

// [1] 단계

SELECT rownum, empno FROM EMP;	// (pk인 경우)

SELECT rownum, ENAME  FROM EMP;	// (pk가 아닌 경우)

SELECT rownum, message_id FROM GUESTTB;


// [2] 단계

SELECT rownum, empno FROM emp ORDER BY empno DESC;	// (pk인 경우)

SELECT rownum, ename FROM emp ORDER BY ename DESC;	// (pk가 아닌 경우)

SELECT rownum, message_id FROM GUESTTB ORDER BY message_id DESC;


// [3] 단계

SELECT rownum, empno 
FROM (SELECT empno FROM emp ORDER BY empno DESC);	// (pk인 경우)

SELECT rownum, ename 
FROM (SELECT ename FROM emp ORDER BY ename DESC);	// (pk인 경우)

SELECT rownum AS rnum, message_id 
FROM (SELECT message_id FROM GUESTTB ORDER BY message_id DESC);


// [4] 단계

SELECT empno
FROM (SELECT rownum AS rnum, empno 
	FROM (SELECT empno FROM emp ORDER BY empno DESC))
WHERE rnum>=1 AND rnum<=3;

SELECT MESSAGE_ID
FROM (SELECT rownum AS rnum, message_id 
	FROM (SELECT message_id FROM GUESTTB ORDER BY message_id DESC))
WHERE rnum>=1 AND rnum<=3;

SELECT MESSAGE_ID
FROM (SELECT rownum AS rnum, message_id 
	FROM (SELECT message_id FROM GUESTTB ORDER BY message_id DESC))
WHERE rnum>=4 AND rnum<=6;


// [5]

SELECT *
FROM EMP
WHERE EMPNO IN (SELECT empno
				FROM (SELECT rownum AS rnum, empno 
					FROM (SELECT empno FROM emp ORDER BY empno DESC))
				WHERE rnum>=1 AND rnum<=3)
ORDER BY EMPNO DESC;

SELECT *
FROM GUESTTB
WHERE MESSAGE_ID IN (SELECT MESSAGE_ID
					FROM (SELECT rownum AS rnum, message_id 
						FROM (SELECT message_id FROM GUESTTB ORDER BY message_id DESC))
					WHERE rnum>=? AND rnum<=?)
ORDER BY MESSAGE_ID DESC;