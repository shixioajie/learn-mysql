# 分组函数
/*
分组数据：GROUP BY 子句语法
可以使用 group by 子句将表中的数据分成若干组

SELECT 分组函数,列(要求出现在group by的后面)
FROM 	表
[WHERE	筛选条件]
[GROUP BY 分组列表,[HAVING 分组后表达式]]
[ORDER BY 子句]

明确：WHERE 一定放在FROM后面
注意：查询列表必须特殊，要求是分组函数和group by后出现的字段
特点：
	1、分组查询中的筛选条件分为两类
			数据源		位置			关键字
	分组前筛选	原始表		group by子句的前面	where
	分组后筛选	分组后的结果集	group by子句的后面	having
	
	① 分组函数做条件肯定是放在having子句中。
	② 能用分组前筛选，就优先考虑用分组前筛选。
	
	2、group by 子句支持单个字段分组，也支持多个字段分组（多个字段之间用逗号隔开没有顺序要求），还支持表达式或函数（用的较少）
	3、也可以添加排序（排序放在分组查询语句之后）
*/

#引入：查询每个部门的平均
SELECT AVG(salary),`department_id` FROM `employees` GROUP BY `department_id`;

#案例1:查询每个工种的最高工资
SELECT MAX(salary),department_id FROM employees GROUP BY department_id ORDER BY MAX(salary) DESC;

#案例2：查询每个位置上的部门个数
SELECT COUNT(*),`location_id` FROM `departments` GROUP BY location_id; 

#添加筛选条件-分组前筛选

#案例1：查询邮箱中包含a字符的，每个部门的平均工资
SELECT 
  AVG(salary),
  `department_id`,
  `email` 
FROM
  `employees` 
WHERE `email` LIKE '%a%' 
GROUP BY `department_id` ;


#案例2：查询有奖金的每个领导手下员工的最高工资
SELECT *,MAX(salary),`manager_id` FROM `employees` WHERE commission_pct IS NOT NULL GROUP  BY `manager_id`;


#添加筛选条件-分组后筛选

#案例1：查询那个部门的员工个数>2
SELECT 
  COUNT(*),
  `department_id` 
FROM
  `employees` 
GROUP BY `department_id` 
HAVING COUNT(*) > 2 ;

#案例2：查询每个工种有奖金的员工的最高工资>12000的工种编号和最高工资
SELECT 
  MAX(salary),
  `job_id` 
FROM
  `employees` 
WHERE `commission_pct` IS NOT NULL 
GROUP BY job_id
HAVING MAX(salary) > 12000;
 

#案例3：查询领导编号>102的每个领导手下的最低工资>5000的领导编号是那个，以及起最低工资。
SELECT 
  MIN(salary),
  manager_id 
FROM
  `employees` 
WHERE `manager_id` > 102 
GROUP BY manager_id 
HAVING MIN(salary) > 5000 ;


#按表达式或函数分组
#案例1：按员工姓名的长度分组，查询每一组的员工个数，筛选员工个数>5的
SELECT 
  COUNT(*),
  LENGTH(last_name) AS len_name 
FROM
  `employees` 
GROUP BY LENGTH(last_name) 
HAVING COUNT(*) > 5 ;

#案例2：查询每个部门每个工种的员工的平均工资
SELECT 
  AVG(salary),
  `department_id`,
  `job_id` 
FROM
  `employees` 
GROUP BY `department_id`,
  `job_id` ;

#案例3：查询每个部门每个工种的员工的平均工资，并且排序
SELECT 
  AVG(salary),
  `department_id`,
  `job_id` 
FROM
  `employees` 
WHERE `department_id` IS NOT NULL 
GROUP BY `department_id`,
  `job_id` 
HAVING AVG(salary) > 10000 
ORDER BY AVG(salary) DESC ;



# 5道小题

#1.查询各job_id的员工工资的最大值，最小值，平均值，总和，并按job_id升序
SELECT 
  MAX(salary),
  MIN(salary),
  AVG(salary),
  SUM(salary),
  job_id 
FROM
  `employees` 
GROUP BY job_id 
ORDER BY job_id ASC;


#2.查询员工最高工资和最低工资的差距(DIFFERNCE)。
SELECT MAX(salary)-MIN(salary) AS DIFFERNCE FROM `employees`;


#3.查询各个管理者手下员工的最低工资，其中最低工不能低于6000，没有管理这的员工不计算在内。
SELECT 
  MIN(salary),
  `manager_id` 
FROM
  `employees` 
WHERE `manager_id` IS NOT NULL 
GROUP BY `manager_id` 
HAVING MIN(salary) >= 6000 ;


#4.查询所有部门的编号，员工数量和工资平均值，并按平均工资降序。
SELECT 
  `department_id`,
  COUNT(*),
  AVG(salary) 
FROM
  `employees` 
GROUP BY `department_id` 
ORDER BY AVG(salary) DESC;

#5.选择具有各个job_id的员工人数。
SELECT COUNT(*),job_id FROM `employees` GROUP BY job_id ORDER BY COUNT(*) ASC;









