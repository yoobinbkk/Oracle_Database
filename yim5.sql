-- ȸ�� ���̺�
create table ex_member(
id varchar2(10), -- ���̵�
pass varchar2(10), -- �н�����
name varchar2(20), -- �̸�
tel varchar2(20), -- ��ȭ��ȣ
addr varchar2(100) -- �ּ�
);

-- ��ǰ ���̺�
create table ex_good(
gno varchar2(10), -- ��ǰ��ȣ
gname varchar(30), -- ��ǰ��
gdetail varchar2(300), -- �󼼼���
price number); -- ����

-- �ֹ� ���̺�
create table ex_order (
ono number, -- ��ȣ
orderno varchar2(20), -- �ֹ���ȣ
gno varchar2(10), -- ��ǰ��ȣ
id varchar2(10), -- ȸ�� ���̵�
count number, -- ����
status varchar2(10) -- ��ۻ���
);

-- �ֹ����̺�� ȸ�����̺�, ��ǰ���̺��� ���踦 �δ´ٸ�?
alter table ex_order
    add constraint pk_ex_order_ono primary key (ono);

alter table ex_member
    add constraint pk_ex_member_id primary key (id);
    
alter table ex_good
    add constraint pk_ex_good_gno primary key (gno);

alter table ex_order
    add constraint fk_ex_order_id foreign key (id) references ex_member (id)
    add constraint fk_ex_order_gno foreign key (gno) references ex_good (gno);

alter table ex_order drop primary key;


-- ȸ�� ���̺� ����Ÿ �Է�
insert into ex_member(id, pass, name, tel, addr )
values('kim', '1111', '��浿', '02-222-2222','���� ������ �̻۵�');

insert into ex_member(id, pass, name, tel, addr )
values('park', '1111', '�ڱ浿', '03-333-3333','��õ ������ �̻۵�');

insert into ex_member(id, pass, name, tel, addr )
values('meng', '1111', '�ͱ浿', '04-444-4444','��� ������ �̻۵�');

commit;


-- ���� ���̺� ����Ÿ �Է�
insert into ex_good( gno, gname, gdetail, price )
values('1001', '�Ӹ���', '���� ��� �Ӹ���', 200 );

insert into ex_good( gno, gname, gdetail, price )
values('2002', '������-A', '������� ������ �޸��� ������', 10000 );

insert into ex_good( gno, gname, gdetail, price )
values('2010', '������-B', '���� ������� ������ �����ϰ� �޸��ٴ� ������', 20000 );

insert into ex_good( gno, gname, gdetail, price )
values('3333', '�ڵ������̽�', '�ΰ� �����ϴ� �ڵ��� ���̽�', 1500 );

commit;

alter table ex_order
    modify status varchar2(10);
    
delete ex_order
    where ono = 8;

?
-- �ֹ� ���̺� ����Ÿ �˻�
insert into ex_order( ono, orderno, gno, id, count, status )
values( 1, '20161212', '1001', 'park', 1, '��ۿϷ�');

insert into ex_order( ono, orderno, gno, id, count, status )
values( 2, '20161212', '2010', 'park', 1, '�����');

insert into ex_order( ono, orderno, gno, id, count, status )
values( 3, '20161111', '1001', 'kim', 2, '�ֹ�');

insert into ex_order( ono, orderno, gno, id, count, status )
values( 4, '20161111', '3333', 'kim', 3, '�ֹ�');

insert into ex_order( ono, orderno, gno, id, count, status )
values( 5, '20163333', '1001', 'park', 3, '�ֹ�');

insert into ex_order( ono, orderno, gno, id, count, status )
values( 6, '20163333', '2010', 'park', 1, '�����');

insert into ex_order( ono, orderno, gno, id, count, status )
values( 7, '20163333', '2002', 'park', 2, '�ֹ�');

insert into ex_order( ono, orderno, gno, id, count, status )
values( 8, '20165050', '1001', 'meng', 1, '�����');

commit;




--1. ������� ��ǰ�� ���� ������ ���
select *
from ex_order
where status = '�����';

select *
from ex_good
where gno in (select gno from ex_order where status = '�����');

select g.*, o.status
from ex_good g inner join ex_order o on o.gno = g.gno and o.status = '�����';
--where o.status = '�����';

--2. �ֹ� ���� ��ǰ ������ �� ���� ���
select m.*, g.*
from ex_order o, ex_good g, ex_member m
where o.gno = g.gno and o.id = m.id
    and status = '�ֹ�';

select m.*, g.*
from ex_order o inner join ex_good g on o.gno = g.gno 
                inner join ex_member m on o.id = m.id
where status = '�ֹ�';

-------------------
SELECT gno,id FROM ex_order WHERE status='�ֹ�';

SELECT o.ono ��ȣ, o.gno ��ǰ��ȣ , m.id ȸ�����̵�, m.name �̸�, g.gname
FROM ex_member m, ex_order o, ex_good g
WHERE (o.id =m.id and status='�ֹ�') and (o.gno=g.gno);
--------------------

-- 3. �ֹ����� �� ����(���̵�)�� �ֹ��� ��ǰ�� �ѱݾ��� ���
select o.id, sum(g.price*o.count) sum
from ex_order o inner join ex_good g on o.gno = g.gno
group by o.id, o.orderno
order by o.id;

--4. 3���� �ֹ� ������ ù���� ��ǰ�� �� �� ���� ���
-- [��] 20161212   �Ӹ��� �� 1��
select e.orderno, g.gname || ' �� ' || (e.count-1) || '��' item
from (select orderno, max(gno) gno, count(orderno) count from ex_order group by orderno) e, ex_good g
where e.gno = g.gno;

-- ����
select o.orderno, (select g.gname from ex_good g where rownum = 1) || ' �� ' || (sum(o.count)-1) || '��' item
from ex_order o inner join ex_good g on o.gno = g.gno 
group by o.orderno;

----------------------------------------------------------
SELECT E.ORDERNO, G.GNAME ||' �� '||(E.COUNT-1)||'��' GOOD
FROM (SELECT ORDERNO, MIN(GNO) GNO, COUNT(ORDERNO) COUNT
FROM EX_ORDER GROUP BY ORDERNO) E, EX_GOOD G
WHERE E.GNO=G.GNO;