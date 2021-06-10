# sql语法
/*
语法：
	select	
	from 表1 别名 【连接类型】 
	join 表2 别名 
	on 连接条件（92语法是用where）
	【where 筛选条件】
	【group by 分组】
	【having 筛选条件】
	【order by 排序列表】
	
连接类型：
 内连接：inner
 外连接
 	左外：left 【outer】
 	右外：right【outer】
	全外：full 【outer】
 交叉连接：crose


*/

#一）内连接
/*
语法：

select	查询列表 
from	表1 别名
inner join 表2 别名
on	连接条件

分类：
等值连接
非等值连接
自连接

特点：
①添加排序、分组、筛选。
②inner 可以省略。
③筛选条件放在where的后面，连接条件放在on的后面，提高分离性，便于阅读。
④inner join连接和sql92语法中的等值连接效果是一样的，都是查询多表的交集。

*/

#1.等值连接
#案例1.查询员工名，部门名
SELECT 
  last_name,
  department_name,
  e.`department_id` 
FROM
  `employees` AS e 
  INNER JOIN `departments` AS d 
    ON e.`department_id` = d.`department_id` ;


#案例2.查询名字中包含e的员工名和工种名（筛选）
SELECT 
  last_name,
  job_title 
FROM
  `employees` AS e 
  INNER JOIN `jobs` AS j 
    ON e.`job_id` = j.job_id 
WHERE e.`last_name` LIKE '%e%' ;

#案例3.查询部门个数>3的城市名和部门个数（分组+筛选）
SELECT 
  l.`city`,
  COUNT(d.`department_name`) 
FROM
  `departments` AS d 
  INNER JOIN `locations` AS l 
ON d.`location_id` = l.`location_id` 
GROUP BY l.`city` 
HAVING COUNT(d.`department_name`) > 3 ;

#案例4.查询那个部门的部门员工个数>3的部门名和员工个数。并按个数降序排序。
SELECT 
  COUNT(*),
  d.department_name 
FROM
  `employees` AS e 
  INNER JOIN `departments` AS d 
    ON e.`department_id` = d.`department_id` 
GROUP BY d.department_name 
HAVING COUNT(*) > 3 
ORDER BY COUNT(*) DESC ;

 

#案例5.查询员工名、部门名、工种名，按部门名降序

SELECT 
  last_name,
  department_name,
  job_title 
FROM
  `employees` AS e 
  INNER JOIN `departments` AS d 
    ON e.`department_id` = d.`department_id` 
  INNER JOIN `jobs` AS j 
    ON e.`job_id` = j.`job_id` 
ORDER BY d.`department_name` DESC ;


#二）非等值连接

#查询员工的工资级别
SELECT 
  salary,
  grade_level 
FROM
  `employees` AS e 
  INNER JOIN `job_grades` AS j 
    ON e.`salary` BETWEEN j.`lowest_sal` 
    AND j.`highest_sal` ;

#查询工资级别的个数>2的，并且按工资级别降序
SELECT 
  COUNT(salary),
  grade_level 
FROM
  `employees` AS e 
  INNER JOIN `job_grades` AS j 
    ON e.`salary` BETWEEN j.`lowest_sal` 
    AND j.`highest_sal` 
GROUP BY grade_level 
HAVING COUNT(salary) > 20 
ORDER BY COUNT(salary) DESC ;











