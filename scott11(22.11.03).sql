CREATE TABLE board_ex(
	seq 	number,			-- 글번호
	title	varchar2(50), 	-- 제목
	writer  varchar2(30), 	-- 작성자
	content varchar2(200),	-- 내용
	regdate date,			-- 게시일
	cnt		number,			-- 조회수
	pass    varchar2(20), 	-- 비밀번호
	CONSTRAINT pk_board_seq PRIMARY KEY(seq)
);
	
CREATE SEQUENCE seq_board;
	

update board_ex set cnt = CNT + 1 where seq = 1;


SELECT *
FROM GUESTTB
WHERE MESSAGE_ID IN (SELECT MESSAGE_ID FROM (SELECT rownum AS rnum, message_id 
												FROM (SELECT message_id FROM GUESTTB ORDER BY message_id DESC))
					WHERE rnum>=? AND rnum<=?)
ORDER BY MESSAGE_ID DESC;


-- hint 예시 --
SELECT * FROM tbl_board ORDER BY bno DESC;	-- 일반
SELECT /*+ INDEX_DESC (tbl_board tbl_board_pk)*/ * FROM tbl_board;	-- hint


select /*+ INDEX_DESC (board_ex )*/ rownum, * 
from board_ex;


CREATE TABLE board_mvc(
	seq 	number,			-- 글번호
	title	varchar2(50), 	-- 제목
	writer  varchar2(30), 	-- 작성자
	content varchar2(200),	-- 내용
	regdate date,			-- 게시일
	cnt		number,			-- 조회수
	pass    varchar2(20), 	-- 비밀번호
	CONSTRAINT pk_board_mvc_seq PRIMARY KEY(seq)
);

CREATE SEQUENCE seq_board_mvc;


INSERT INTO BOARD_MVC VALUES (seq_board_mvc.nextval, 1, 1, 1, sysdate, 0, 1);

INSERT INTO BOARD_MVC VALUES (seq_board_mvc.nextval, 2, 2, 2, sysdate, 0, 2);

INSERT INTO BOARD_MVC VALUES (seq_board_mvc.nextval, 3, 3, 3, sysdate, 0, 3);

