drop database TestDB; -- 删除数据库.
create database ManagenmentDB;  -- 创建是按照系统库的model 为模板创建的。
use ManagenmentDB;
-- -----------------------------创建表------------------
create table Student  -- 创建学生表
(
S_ID int identity(1,1) primary key, -- ID
S_S# char(12) not null unique, -- 学号
S_name nvarchar(5) not null,
S_age tinyint not null check(S_age>0),
S_sex nchar(2) not null check(S_sex='男'or S_sex='女')
) 
drop table Student;

create table Course -- 创建课程表
(
  C_ID smallint not null identity(1,1),
  C_C# char(12) not null unique, -- 课程编号
  C_name nvarchar(10) not null,
  C_T# char(12) not null  -- 教师编号
)
alter table Course add constraint PK_ID primary key(C_ID); -- 添加主键
drop table Course; -- 删除表格 

if( not exists(select * from sys.objects where name='SC')) --创建成绩表
create table SC 
(
 SC_ID smallint not null identity(1,1) primary key,
 SC_S# char(12) not null ,
 SC_C# char(12) not null ,
 SC_score smallint not null check(SC_score>0)
)
drop table SC;

IF(not exists(select * from sys.objects where objects.object_id=object_id('Teacher'))) -- 创建教师表
create table Teacher
(
T_ID smallint not null identity(1,1) primary key,
T_T# char(12) not null unique,-- 教师编号
T_name nvarchar(10)  not null 
)
drop table Teacher

-- -----------------------插入模拟数据------------------------
select * from student
insert into Student ( S_name,S_age,S_sex,S_S#) values('王小二',28,'男','090204058'),
('刘小毛',21,'女','090204059');

select * from Course
insert into course values('0908','C语言','1002'),('0902','大学语文','1001'),('0903','大学物理','1003')
,('0904','代数','1004'),('0905','自动控制','1005'),('0906','单片机','1006');

select * from SC where SC_S#='090204057'
insert into SC values('090204056','0901',54),('090204058','0902',87),('090204058','0903',64),('090204058','0904',73),
('090204058','0905',92),('090204058','0906',81),('090204057','0908',109),('090204058','0908',96);

update SC set SC_C#='0905' where SC_score=96

select * from teacher
insert into teacher values('1000','张老师'),('1002','岳老师'),('1003','孙老师'),('1004','武老师'),('1005','赵老师'),('1006','李老师')
------------------------------------------------查询练习------------------------------------------------------------------------------
--- 1、查询“0908”课程比“0902”课程成绩高的所有学生的学号；
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

--- 2、查询平均成绩大于60分的同学的学号和平均成绩；

select SC_S#, avg(SC_score)as '平均数' from SC group by SC_S# having AVG(SC_score)>80;

--- 3,查询所有同学的学号、姓名、选课数、总成绩；

select table1.SC_S#,student.S_name,table1.选课数,table1.总成绩 from 
(
select SC_S#,count(SC_C#) as '选课数',SUM(SC_score) as '总成绩' from SC group by SC_S#)as table1
,student 
where table1.SC_S#=student.S_S#;

--- 4、查询姓“李”的老师的个数；
select COUNT(T_name) from teacher where T_name like '李%'

--- 5、查询没学过“孙”老师课的同学的学号、姓名；

select S_S#,S_name from student where S_S#
not in
(
select SC.SC_S#  from teacher,SC,Course where T_name='孙老师' and teacher.T_T#=Course.C_T# and SC_C#=course.C_C#
)

--- 6、查询学过“0901”并且也学过编号“0906”课程的同学的学号、姓名；

select student.S_name,student.S_S# from student,SC where student.S_S#=SC.SC_S# and SC.SC_C#='0901'
and exists
(
 select * from SC as table1 where table1.SC_S#=SC.SC_S# and  table1.SC_C#='0906'
)


--- 7、查询学过“岳”老师所教的所有课的同学的学号、姓名；


select * from teacher,Course,SC where teacher.T_name='岳老师' and course.C_T#=teacher.T_T# and course.C_C#=SC.SC_C#

--- 8、查询课程编号“002”的成绩比课程编号“001”课程低的所有同学的学号、姓名；


--- 9、查询所有课程成绩小于60分的同学的学号、姓名；

--- 10、查询没有学全所有课的同学的学号、姓名；

--- 