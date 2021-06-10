# 1. 显示所有员工的姓名，部门号和部门名称
SELECT 
  e.`first_name`,
  d.`department_name`,
  d.`department_id` 
FROM
  `employees` AS e,
  `departments` AS d 
WHERE e.`department_id` = d.`department_id` ;

#2. 查询90号部门员工的job_id和90号部门的location_id
SELECT 
  e.`job_id`,
  d.`location_id`,
  e.`department_id`
FROM
  `employees` AS e,
  `departments` AS d 
WHERE e.`department_id` = d.`department_id` 
  AND e.`department_id` = 90;


#3.选择所有奖金的员工的 last_name,department_name,location_id,city
SELECT 
  e.last_name,
  e.`commission_pct`,
  d.department_name,
  d.location_id,
  l.city 
FROM
  `employees` AS e,
  `locations` AS l,
  `departments` AS d 
WHERE e.`commission_pct` IS NOT NULL 
  AND e.`department_id` = d.`department_id` 
  AND d.`location_id` = l.`location_id` ;


#4.选择city在Toronto工作的员工的 
#last_name , job_id , department_id,department_name
SELECT 
  e.`last_name`,
  e.`job_id`,
  e.`department_id`,
  d.`department_name`,
  l.`city` 
FROM
  `employees` AS e,
  `departments` AS d,
  `locations` AS l 
WHERE e.`department_id` = d.`department_id` 
  AND d.`location_id` = l.`location_id` 
  AND l.`city` = 'Toronto' ;


#5.查询每个工种、每个部门的部门名、工种名和最低工资
SELECT 
  d.department_name,
  j.job_title,
  MIN(e.salary) AS 最低工资 
FROM
  `departments` AS d,
  `employees` AS e,
  `jobs` AS j
WHERE d.`department_id` = e.`department_id` 
AND e.`job_id` = j.job_id 
GROUP BY d.department_name,j.job_title 
ORDER BY 最低工资 DESC;

#6.查询每个国家的部门个数大于2的国家编号
SELECT 
  country_id,
  COUNT(*) 部门个数 
FROM
  departments AS d,
  locations AS l 
WHERE 
d.`location_id` = l.`location_id`
GROUP BY country_id 
HAVING 部门个数 > 2;

 


#7.选择指定员工的姓名，员工号，以及他的管理者的姓名和员工号，结果类似于下面的格式
/*
employees	Emp#		manager 	Mgr#
kochhar 	101		king		100
*/
SELECT 
  e.`last_name` AS employees,
  e.employee_id AS 'Emp#' ,
  m.last_name AS manager,
  m.employee_id AS 'Mgr#'
FROM
  employees AS e,
  employees AS m 
 WHERE e.manager_id  = m.employee_id AND e.last_name = 'kochhar';










