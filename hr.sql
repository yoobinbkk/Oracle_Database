CREATE TABLE info_tab 
( 
    name    varchar2(10),
    jumin   char(15),
    tel     varchar2(20),
    gender  varchar2(10),
    age     number(3),
    home    varchar2(20),
    CONSTRAINT pk_info_tel PRIMARY KEY (tel)
);

INSERT into info_tab(tel, name) values ('1001', 'ȫ�浿');
INSERT into info_tab(tel, name) values ('1002', '��浿');
INSERT into info_tab(tel, name) values ('1002', '�Ѹ�');
INSERT into info_tab(name, jumin) values ('��浿', '901212-1234567');
INSERT into info_tab(gender, age) values ('����', 22);
INSERT into info_tab(tel, gender, age) values (9999, '����', 22);

delete from info_tab;

DROP TABLE info_tab;

alter table info_tab
    Modify (name varchar2(10) not null);
    
alter table info_tab
    add constraint uq_info_jumin unique (jumin);

insert into info_tab (tel, name, jumin) values ('20001', 'ȫ����', '990101');
insert into info_tab (tel, name, jumin) values ('20002', 'ȫ����', '990101');
insert into info_tab (tel, name) values ('20003', 'ȫȫ��');

alter table info_tab
    add constraint ck_info_gender check (gender in ('����', '����'));

insert into info_tab (tel, name, gender) values ('10001', 'ȫ����', '����');
insert into info_tab (tel, name, gender) values ('10002', 'ȫ����', '����');
insert into info_tab (tel, name, gender) values ('10003', 'ȫ����', '����');

alter table info_tab
    modify (gender varchar2(6) default '����');
    
insert into info_tab(tel, name) values ('7777', 'ȫ��');


-- [Ȯ��]

INSERT INTO info_tab( name, tel, jumin ) 
VALUES('������', '02-777-4444', '990909-1234567');

INSERT INTO info_tab( name, tel, jumin, gender, age, home )
VALUES('������','03-555-5555', '880808-1234567', '����', 27,'���');

INSERT INTO info_tab( name, tel, jumin, gender, age, home )
VALUES('ȫ�浿','03-031-0310', '900909-1234567', '����', 27,'���');

INSERT INTO info_tab( name, jumin) VALUES('ȫ����', '550505-1234567');

INSERT INTO info_tab( tel, jumin ) VALUES('031-777-7777', '700707-1234567');

INSERT INTO info_tab( name, tel, jumin ) VALUES('������', '031-000-0000', '700707-1234567');

drop table info_tab;


CREATE TABLE info_tab 
( 
    name    varchar2(10) not null,
    jumin   char(15),
    tel     varchar2(20),
    gender  varchar2(10) default '����',
    age     number(3),
    home    varchar2(20),
    DEPARTMENT_ID   NUMBER(4,0),
    CONSTRAINT pk_info_tel PRIMARY KEY (tel),
    CONSTRAINT uq_info_jumin unique (jumin),
    CONSTRAINT ck_info_gender check (gender in ('����', '����')),
    CONSTRAINT fk_info_DEPARTMENT_ID foreign key(DEPARTMENT_ID) references DEPARTMENTs (DEPARTMENT_ID)
);

insert into info_tab(tel, name, department_id) values('7777', '����', 20);
insert into info_tab(tel, name, department_id) values('8888', '����', 22);
insert into info_tab(tel, name) values('9999', '¯��');

--=======================================================

-- [�߰� ����] �˻� ����

--1. EMPLOYEES ���̺��� ��� �̸��� first_name�� last_name�� ���� full_name���� ���
select first_name|| ' ' ||last_name as full_name
from employees;

--2. �μ���ȣ�� 30(���źμ�)�̰� �޿� 10000�̸��� ����� full_name�� ����,�μ���ȣ�� ���
select first_name|| ' ' ||last_name as full_name, salary, department_id
from employees
where (department_id = 30 and salary < 10000);

--3. �μ���ȣ�� 30�̰� �޿��� 10000�޷� ���ϸ� �޴� 2006�⵵ ���� �Ի��� ����� full_name�� ���
select first_name|| ' ' ||last_name full_name
from employees
where (department_id = 30 and salary <= 10000)
    and hire_date < '06.01.01';
    
--4. �μ���ȣ�� 30(���źμ�)�̰� �޿��� 10000������ ����� �μ���ȣ�� 60(IT�μ�)���� �޿��� 5000�̻��� ����� ��ȸ
select *
from employees
where (department_id = 30 and salary <= 10000) or (department_id = 60 and salary >= 5000);

--5. �����ȣ�� 110������ 120���� ��� �� �޿��� 5000���� 10000������ �������� ��ȸ
select *
from employees
where (employee_id between 110 and 120) and (salary between 5000 and 10000);

--6. �����ȣ�� 110������ 120���� �ƴ� ����� ��ȸ
select *
from employees
where employee_id not between 110 and 120;

--7. �μ���ȣ�� 30(���źμ�), 60(IT�μ�), 90(�濵�μ�)�� ���� ����� ��ȸ
select *
from employees
where department_id in (30, 60, 90);

--8. �μ���ȣ�� 30(���źμ�), 60(IT�μ�), 90(�濵�μ�) ���� �μ��� ���� ����� ��ȸ
select *
from employees
where department_id not in (30, 60, 90);

--9. ��ȭ��ȣ���� 590���� �����ϴ� ������ ��ȭ��ȣ�� ��ȸ
select first_name|| ' ' ||last_name as full_name, phone_number
from employees
where phone_number like '590%';


