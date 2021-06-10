#进阶查询1：基础查询
/*
语法：
select 查询列表 from 表名字；

特点：
1. 查询列表可以是：表中的字段、常量值、表达式、函数。
2. 查询的结果是一个虚拟的表格。
*/

#1. 查询表中的单个字段
SELECT 
  first_name,
  last_name 
FROM
  `employees` ;

#2. 查询表中的多个字段
SELECT `job_id`,`salary`,`hiredate` FROM `employees`;

#3. 查询所有字段
SELECT * FROM `employees`;

#4. 查询常量值
SELECT 100;
SELECT 'john'; # sql语句不区分字符和字符串'' "" 都可以。

#5.查询表达式
SELECT 100%10;

#6.查询函数
SELECT VERSION();

#7.起别名
/*
① 便于理解。 
② 如果要查询的字段有重名的情况，使用别名可以区分开来。
*/
# 方式一 as：
SELECT 100*90 AS a1;
SELECT `last_name` AS 姓, `first_name` AS 名 FROM `employees`;

# 方式二 省略：
SELECT last_name 姓,first_name 名 FROM `employees`;

# 案例：查询salary,显示结果为 out put ， out put 本身是关键字。
SELECT salary AS "out put" FROM `employees`;

#8.去重

# 案例
SELECT DISTINCT `department_id` FROM `employees`

#9.+号的作用
/*
mysql 中的+号只做：运算符。不做：连接符。
SELECT 100+90; 打印 190 两个操作数都为数值类型，则做加法运算
SELECT '100'+90; 打印 190 其中一个是字符型，就会试图将字符型数值转换成数值型，如果转换成功，则继续做加法运算。
SELECT 'john'+90; 打印 0 转换失败的则还会将字符型转换成0。
SELECT null+90; 只要其中一方为null，则结果肯定为null。
*/
#案例：查询员工名字和姓连接成一个字段，并显示为姓名
SELECT 
  CONCAT(last_name, ' ', first_name) AS 姓名 
FROM
  `employees` 



