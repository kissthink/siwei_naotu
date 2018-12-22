drop database TestDB; -- ɾ�����ݿ�.
create database ManagenmentDB;  -- �����ǰ���ϵͳ���model Ϊģ�崴���ġ�
use ManagenmentDB;
-- -----------------------------������------------------
create table Student  -- ����ѧ����
(
S_ID int identity(1,1) primary key, -- ID
S_S# char(12) not null unique, -- ѧ��
S_name nvarchar(5) not null,
S_age tinyint not null check(S_age>0),
S_sex nchar(2) not null check(S_sex='��'or S_sex='Ů')
) 
drop table Student;

create table Course -- �����γ̱�
(
  C_ID smallint not null identity(1,1),
  C_C# char(12) not null unique, -- �γ̱��
  C_name nvarchar(10) not null,
  C_T# char(12) not null  -- ��ʦ���
)
alter table Course add constraint PK_ID primary key(C_ID); -- �������
drop table Course; -- ɾ����� 

if( not exists(select * from sys.objects where name='SC')) --�����ɼ���
create table SC 
(
 SC_ID smallint not null identity(1,1) primary key,
 SC_S# char(12) not null ,
 SC_C# char(12) not null ,
 SC_score smallint not null check(SC_score>0)
)
drop table SC;

IF(not exists(select * from sys.objects where objects.object_id=object_id('Teacher'))) -- ������ʦ��
create table Teacher
(
T_ID smallint not null identity(1,1) primary key,
T_T# char(12) not null unique,-- ��ʦ���
T_name nvarchar(10)  not null 
)
drop table Teacher

-- -----------------------����ģ������------------------------
select * from student
insert into Student ( S_name,S_age,S_sex,S_S#) values('��С��',28,'��','090204058'),
('��Сë',21,'Ů','090204059');

select * from Course
insert into course values('0908','C����','1002'),('0902','��ѧ����','1001'),('0903','��ѧ����','1003')
,('0904','����','1004'),('0905','�Զ�����','1005'),('0906','��Ƭ��','1006');

select * from SC where SC_S#='090204057'
insert into SC values('090204056','0901',54),('090204058','0902',87),('090204058','0903',64),('090204058','0904',73),
('090204058','0905',92),('090204058','0906',81),('090204057','0908',109),('090204058','0908',96);

update SC set SC_C#='0905' where SC_score=96

select * from teacher
insert into teacher values('1000','����ʦ'),('1002','����ʦ'),('1003','����ʦ'),('1004','����ʦ'),('1005','����ʦ'),('1006','����ʦ')
------------------------------------------------��ѯ��ϰ------------------------------------------------------------------------------
--- 1����ѯ��0908���γ̱ȡ�0902���γ̳ɼ��ߵ�����ѧ����ѧ�ţ�
select * from 

(select SC_S#,SC_score from SC where SC_C#='0908') as temptable1,

(select SC_S#,SC_score from SC where SC_C#='0902') as temptable2

where temptable1.SC_score>temptable2.SC_score and temptable1.SC_S#=temptable2.SC_S#
-------------------

select * from  student where student.S_S# in
(
select temptable1.SC_S# from
(select SC_S#,SC_score from SC where SC_C#='0908') as temptable1,

(select SC_S#,SC_score from SC where SC_C#='0902') as temptable2

where temptable1.SC_score>temptable2.SC_score and temptable1.SC_S#=temptable2.SC_S#
)
-------------------

--- 2����ѯƽ���ɼ�����60�ֵ�ͬѧ��ѧ�ź�ƽ���ɼ���

select SC_S#, avg(SC_score)as 'ƽ����' from SC group by SC_S# having AVG(SC_score)>80;

--- 3,��ѯ����ͬѧ��ѧ�š�������ѡ�������ܳɼ���

select table1.SC_S#,student.S_name,table1.ѡ����,table1.�ܳɼ� from 
(
select SC_S#,count(SC_C#) as 'ѡ����',SUM(SC_score) as '�ܳɼ�' from SC group by SC_S#)as table1
,student 
where table1.SC_S#=student.S_S#;

--- 4����ѯ�ա������ʦ�ĸ�����
select COUNT(T_name) from teacher where T_name like '��%'

--- 5����ѯûѧ�������ʦ�ε�ͬѧ��ѧ�š�������

select S_S#,S_name from student where S_S#
not in
(
select SC.SC_S#  from teacher,SC,Course where T_name='����ʦ' and teacher.T_T#=Course.C_T# and SC_C#=course.C_C#
)

--- 6����ѯѧ����0901������Ҳѧ����š�0906���γ̵�ͬѧ��ѧ�š�������

select student.S_name,student.S_S# from student,SC where student.S_S#=SC.SC_S# and SC.SC_C#='0901'
and exists
(
 select * from SC as table1 where table1.SC_S#=SC.SC_S# and  table1.SC_C#='0906'
)


--- 7����ѯѧ����������ʦ���̵����пε�ͬѧ��ѧ�š�������


select * from teacher,Course,SC where teacher.T_name='����ʦ' and course.C_T#=teacher.T_T# and course.C_C#=SC.SC_C#

--- 8����ѯ�γ̱�š�002���ĳɼ��ȿγ̱�š�001���γ̵͵�����ͬѧ��ѧ�š�������


--- 9����ѯ���пγ̳ɼ�С��60�ֵ�ͬѧ��ѧ�š�������

--- 10����ѯû��ѧȫ���пε�ͬѧ��ѧ�š�������

--- 