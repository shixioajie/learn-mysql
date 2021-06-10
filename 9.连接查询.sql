#连接查询
/*
含义：又称多表查询，当查询的字段来自于多个表时，就会用到连接查询
笛卡尔乘积现象：表1有m行，表2有n行，结果=m*n行。
发生原因：没有有效的连接条件。
如何避免：添加有效的连接条件。

分类：
	按年代分类；
	sql92标准：仅支持内连接
	sql99标准【推荐】：支持自连接+外连接（左外和右外）+交叉连接
	
	按功能分类：
		内连接：
			等值连接
			非等值连接
			自连接
		外连接：
			左外连接
			右外连接
			全外连接
		交叉连接

*/

SELECT NAME,boyName FROM `beauty`,`boys`;
#笛卡尔集的错误情况：
/*
SELECT count(*) from beauty;
假设输出12行
select count(*) from boys;
假设输出4行
最终结果：12*4=48行
*/


#一、sql92标准
#1、等值连接
/*
① 多表等值连接的结果为多表的交集部分。
② n个表连接，至少需要n-1个连接条件。
③ 多表的顺序没有要求。
④ 可以搭配前面介绍的所有子句使用，比如排序、分组、筛选。
*/

#案例1：查询女神名和对应的男神名
#提示：在使用到有‘歧义’的表头字段的时候，可以使用表明.表头字段的方式明确表头字段。
 SELECT NAME,boyName FROM `beauty`,`boys` WHERE beauty.boyfriend_id=boys.id;
 
#案例2：查询员工名和对应的部门名
SELECT 
  last_name,
  department_name 
FROM
  `employees`,
  `departments` 
WHERE `employees`.`department_id` = `departments`.`department_id` ;


#2、为表起别名
/*
①提高语句的简洁度
②区分多个重名的字段
注意：当使用了别名，使用查询的字段就不能使用原来的表名，sql表示不认识了。

*/
#查询员工名，工种号，工种名
SELECT 
  e.`last_name`,
  e.`job_id`,
  j.`job_title` 
FROM
  `employees` AS e,
  `jobs` AS j 
WHERE e.`job_id` = j.`job_id` ;


#3、两个表的顺序是否可以调换
#查询员工名，工种号，工种名
#答案是可以
SELECT 
  j.`job_title`,
  e.last_name,
  e.job_id 
FROM
  `employees` AS e,
  `jobs` AS j 
WHERE j.`job_id` = e.`job_id` ;



#4、可以加筛选
#案例1：查询有奖金的员工名、部门名
SELECT 
  e.`last_name`,
  d.`department_name` 
FROM
  `employees` AS e,
  `departments` AS d 
WHERE e.`commission_pct` IS NOT NULL 
  AND e.`department_id`=d.`department_id` ;
  
  
#案例2：查询部门所在城市名中第二个字符为o的
SELECT 
  l.`city`,
  d.`department_name` 
FROM
  `locations` AS l,
  `departments` AS d 
WHERE `city` LIKE '_o%' AND l.`location_id`=d.`location_id`;

  

#5、可以分组

#案例1：查询每个城市的部门个数
SELECT 
  COUNT(d.`department_name`) AS 个数,
  city 
FROM
  `departments` AS d,
  `locations` AS l 
WHERE d.`location_id` = l.`location_id` 
GROUP BY city 

#案例2：查询有奖金的每个部门的部门名称和部门领导编号和该部门的最低工资
SELECT 
  d.`department_name`,
  d.`manager_id`,
  MIN(salary) 
FROM
  `departments` AS d,
  `employees` AS e 
WHERE d.`department_id` = e.department_id 
  AND e.`commission_pct` IS NOT NULL 
 GROUP BY d.`department_name`,d.`manager_id`;

  
#6、可以加排序
#案例：查询每个工种的工种名和员工的个数，并且按员工个数排序
SELECT 
  job_title,
  COUNT(*) 
FROM
  `employees` AS e,
  `jobs` AS j 
WHERE e.`job_id` = j.`job_id` 
GROUP BY job_title
ORDER BY COUNT(*) DESC;


#7、可以实现三表连接
#案例：查询员工名、部门名、所在的城市
SELECT 
  last_name,
  department_name,
  city 
FROM
  `employees` AS e,
  `departments` AS d,
  `locations` AS l 
WHERE e.`department_id` = d.`department_id` 
  AND d.`location_id` = l.`location_id` 
ORDER BY `department_name` DESC  ;










 


