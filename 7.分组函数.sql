# 分组函数
/*
功能：用作统计使用，又称为聚合函数或统计函数或组函数
分类：
sum求和、avg平均值、max最大值、min最小值、count计算个数。

特点：
1. sum、avg一般用于处理数值型。
   max、min、count 可以处理任何类型
   
2. 忽略null值 ? 以上分组函数都忽略null值。

3. 可以和distinct配合使用

4. count函数的单独介绍
一般使用count(*)做统计行数

5、和分组函数一同查询的字段要求是 group by后的字段
*/

#1. 简单的使用
SELECT SUM(salary) FROM `employees`;
SELECT AVG(salary) FROM `employees`;
SELECT MAX(salary) FROM `employees`;
SELECT MIN(salary) FROM `employees`;
SELECT COUNT(salary) FROM `employees`;

#2. 参数支持哪些类型

# 2.1 sum、avg 只支持数字，字符串类型返回0不报错，日期会统计但是值似乎没有什么意义了。
SELECT SUM(last_name),AVG(last_name) FROM `employees`; 
SELECT SUM(`hiredate`),AVG(`hiredate`) FROM `employees`;

# 2.2 max、svg、count 支持可比较，数值、字符串、日期等值都是可比较的。
SELECT MAX(last_name),MIN(last_name),COUNT(last_name) FROM `employees`;
SELECT MAX(hiredate),MIN(hiredate),COUNT(hiredate) FROM `employees`;

# 2.3 count 特点是累计非空的值
SELECT COUNT(commission_pct) FROM `employees`;
SELECT COUNT(last_name) FROM `employees`; 

# 3.是否忽略null
# 3.1 null+任何数值都是=null，看下面的输出结果可知avg也忽略了null，因为和 / 35 忽略null位置数量的运算结果一样。
SELECT 
  SUM(commission_pct),
  AVG(commission_pct),
  SUM(commission_pct) / 107,
  SUM(commission_pct) / 35 
FROM
  `employees` ;

# 3.2 max、min 也忽略了null。 
SELECT MAX(commission_pct),MIN(commission_pct) FROM  `employees`; 

# 3.3 count 忽略null值。
SELECT COUNT(commission_pct) FROM `employees`;


# 4.和distinct搭配
# 类似于去重之后在求和
SELECT SUM(DISTINCT(salary)),SUM(salary) FROM `employees`; 
# 去重之后再计数
SELECT COUNT(DISTINCT(salary)),COUNT(salary) FROM `employees` ;
  
# 5.count函数的详细介绍
SELECT COUNT(salary) FROM `employees`
SELECT COUNT(*) FROM `employees`; #只要有一个不为null就计数。
SELECT COUNT(1) FROM `employees`; #相当于在表里多加了一列，其中的值都是1，所以会统计该表有几行。

# 效率：
/*
MYISAM存储引擎下,count(*)的效率高
INNODB存储引擎下，count(*)和count(1)的效率差不多，比count(字段)要高一些。

*/


SELECT AVG(salary),`employee_id` FROM `employees`;


# 测试
#1.查询公司员工工资的最大值，最小值，平均值，总和
SELECT MAX(salary),MIN(salary),AVG(salary),SUM(salary) FROM `employees`;

#2.查询员工表中的最大入职时间和最小入职时间的相差天数 提示：datediff 函数可以用来算日期相差的天数。
SELECT DATEDIFF(MAX(`hiredate`),MIN(`hiredate`)) AS 'datediff' FROM `employees`;

#3.查询部门编号位90的员工个数
SELECT COUNT(*) AS 个数 FROM `employees` WHERE `department_id`=90;
  
  
  
  