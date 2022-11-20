
---- Goods 테이블과 시퀜스 생성 ----

CREATE table Goods (
	goods_id 				varchar2(6) primary key,
	goods_name 				varchar2(100),
	price 					number,
	delivery_charge 		number(4),
	description				varchar2(1000),
	img_name				varchar2(40),
	alcohol					number(4),
	volume					number,
	origin					varchar2(50),
	stock					number,
	sold_out				char(1),
	r_date					date,
	goods_type				varchar2(20)
);

CREATE SEQUENCE seq_goods;

---- 임시 상품 등록 ----
---- 각 종류마다 두 개씩 (기타 빼고) ----
INSERT into Goods 
Values (seq_goods.nextval, '[맑은내일 WINERY]단감명작', 20000, 3000, 
							'3대에 걸쳐 내려오는 전통 발효기술과 국내산 창녕 단감을 사용한 단감와인', 
							'dangamMyoungjak', '7', 750, 
							'창녕', 100, '0', sysdate, 'fruit_liquor', 0, '', 0, 0, 0, 0);

INSERT into Goods 
Values (seq_goods.nextval, '[알에프]오늘도 수고했어', 8500, 3000, '오늘 하루도 수고한 당신에게 보내는 작은 위로', 
						   'goodWorkToday', '16.5', 360, '국산', 100, '0', sysdate, 'fruit_liquor', 0, '', 0, 0, 0, 0);

INSERT into Goods 
Values (seq_goods.nextval, '[종천주조장]나이스 버디 6도 930ml', 10000, 3000, '막걸리와 사이다를 한 번에', 
						   'niceBirdy', '6', 930, '국산', 100, '0', sysdate, 'makgoli', 0, '', 0, 0, 0, 0);

INSERT into Goods 
Values (seq_goods.nextval, '[마마스팜]문콕 8도 500ml', 10800, 3000, '달빛에 콕! 박히다', 
						   'moonCock', '8', 500, '국산', 100, '0', sysdate, 'makgoli', 0, '', 0, 0, 0, 0);
						   
INSERT into Goods 
Values (seq_goods.nextval, '[오산양조] 독산30 30도 250ml', 30000, 3000, '증류한 소주 원액을 전통 옹기에서 100일 이상 숙성한 쌀 소주', 
						   'dokSan30', '30', 250, '국산', 100, '0', sysdate, 'hard_liquor', 0, '', 0, 0, 0, 0);
						  
INSERT into Goods 
Values (seq_goods.nextval, '[시트러스] 미상25 25도 350ml', 13000, 3000, '제주 감귤의 향긋함으로 맛의 위상을 높이다', 
						   'miSang', '25', 350, '국산', 100, '0', sysdate, 'hard_liquor', 0, '', 0, 0, 0, 0);
						  
INSERT into Goods 
Values (seq_goods.nextval, '[마마스팜] 문삼이공 약주 16도 500ml', 26000, 3000, '친환경 쌀과 세 가지 누룩, 강원도 물로 빚은 맑은 술', 
						   'moonSamEGong', '16', 500, '국산', 100, '0', sysdate, 'yakju', 0, '', 0, 0, 0, 0);
						  
INSERT into Goods 
Values (seq_goods.nextval, '[석이원주조] 자자헌주 17도 375ml', 21600, 3000, '소나무 숲 아래 국화향을 머금은 술', 
						   'jaJaHunJu', '17', 375, '국산', 100, '0', sysdate, 'yakju', 0, '', 0, 0, 0, 0);

-- 회원 가입 --
CREATE TABLE JudaMember(
member_id                   varchar2(20),
password                    varchar2(20),
name                        varchar2(100),
gender                      varchar(6),
p_num                       varchar2(13),
email                       varchar2(100),
birth                       date,
signin_date                 date,
agree_email                 char(1),
agree_sns                   char(1)
); 

CREATE SEQUENCE seq_JudaMember;

-- 회원 임의 가입 -- 

INSERT INTO JudaMember (member_id, password, name, gender, p_num, email, birth, signin_date, agree_email, agree_sns) 
VALUES ('hansol', '0215', '박한솔', '여', '010-4344-2460', 'ruflthfl00@naver.com', '1994/02/15', '2022/11/19', 'y', 'y' );
                    
INSERT INTO JudaMember (member_id, password, name, gender, p_num, email, birth, signin_date, agree_email, agree_sns) 
VALUES ('unneverse', '0429', '윤희선', '여', '010-5277-3399', 'syj05059@naver.com', '1998/04/29', '2022/11/19', 'n', 'y' );
                    
INSERT INTO JudaMember (member_id, password, name, gender, p_num, email, birth, signin_date, agree_email, agree_sns) 
 VALUES ('lyb', '1234', '임유빈', '남', '010-1234-5678', 'lyb1234@naver.com', '1994/11/19', '2022/11/19', 'y', 'n' );                   
      
INSERT INTO JudaMember (member_id, password, name, gender, p_num, email, birth, signin_date, agree_email, agree_sns) 
 VALUES ('lgh', '1234', '임규황', '남성', '010-5678-1234', 'lgh5678@naver.com', '1994/12/15', '2022/11/19', 'n', 'n' );


 -- 로그인 (sql 문장 확인용으로 작성해봄)-- 

select    member_id id, password 
from      judamember
where     member_id = 'hansol' AND password = 0215;
						  