
create table account (
account_num		varchar2(20),
customer		varchar2(20),
amount			int
);

insert into account values('111-11-1111', 'È«±æµ¿', 10000);
insert into account values('999-99-9999', '¸ÍÀÚ', 5000);

drop table account;

