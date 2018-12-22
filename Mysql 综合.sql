drop DATABASE testdb   删除数据库

create database ManagenmentDB; 
use ManagenmentDB;
-----------------------------创建表-----------------------
CREATE table if not EXISTS Student  -- - 创建学生表
(
S_ID int auto_increment primary key, -- ID
S_S char(12) not null unique, -- 学号
S_name varchar(5) not null,
S_age tinyint UNSIGNED not null,
S_sex enum('男','女')
)engine=myisam charset=utf8;
drop table Student

create table Course  --- 创建课程表
(
  C_ID smallint not null auto_increment,
  C_C char(12) not null unique, -- 课程编号
  C_name varchar(10) not null,
  C_T char(12) not null,  -- 教师编号
  constraint PK_ID primary key(C_ID)
)engine=myisam charset=utf8;

create table Teacher  ---创建教师表
(
T_ID smallint not null auto_increment primary key,
T_T char(12) not null unique,-- 教师编号
T_name varchar(10)  not null 
)
alter TABLE teacher ENGINE=myisam --- 修改表的引擎

create table SC 
(
 SC_ID smallint not null auto_increment primary key,
 SC_S char(12) not null ,
 SC_C char(12) not null ,
 SC_score smallint not null check(SC_score>0)
)engine=myisam charset=utf8;  --- 创建成绩表

---------------------------------插入模拟数据--------------------------------
delete from Student
select * from student;
insert into Student (S_name,S_age,S_sex,S_S) values('张威',29,'男','090204051'),
('张豪',27,'男','090204052'),('张娟',25,'女','090204053'),('张超',23,'男','090204054')
,('张波',21,'女','090204055'),('张可欣',26,'女','090204056'),('张秋萍',21,'女','090204057'),('王小二',28,'男','090204058'),
('刘小毛',21,'女','090204059');

select * from SC

SELECT * from course
insert into course values(8,'0901','大学英语','1000')

select * from teacher

------------------------------------------------查询练习------------------------------------------------------------------------------
--- 1、查询“001”课程比“002”课程成绩高的所有学生的学号；

--- 2、查询平均成绩大于60分的同学的学号和平均成绩；

--- 3,查询所有同学的学号、姓名、选课数、总成绩；


--- 4、查询姓“李”的老师的个数；

--- 5、查询没学过“孙”老师课的同学的学号、姓名；


--- 6、查询学过“001”并且也学过编号“002”课程的同学的学号、姓名；

--- 7、查询学过“叶平”老师所教的所有课的同学的学号、姓名；


--- 8、查询课程编号“002”的成绩比课程编号“001”课程低的所有同学的学号、姓名；


--- 9、查询所有课程成绩小于60分的同学的学号、姓名；

--- 10、查询没有学全所有课的同学的学号、姓名；

--- 