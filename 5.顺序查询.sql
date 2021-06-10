# 排序查询

/*
引入：
	SELECT * FROM `employees`;
语法:
	select 	查询列表
	from	表
	【where 筛选条件】
	order by 排序列表 【asc|desc】
特点：
	1.asc代表的是升序，desc代表的是降序，如果不写默认是升序。
	如果不写，默认是升序。
	2、order by子句中可以支援单个字段、多个字段、表达式、函数、别名。
	3、order by子句一般是放在查询语句的最后面，limit子句除外。
*/

# 案例1：查询员工信息，工资从高到低排序
SELECT * FROM `employees` ORDER BY salary DESC;
SELECT * FROM `employees` ORDER BY salary ASC;# 不特意指出默认是 ASC。

# 案例2：查询部门编号>=90的员工信息，按入职时间的先后进行
SELECT 
  * 
FROM
  `employees` 
WHERE department_id >= 90 
ORDER BY hiredate ASC ;

# 案例3：按年薪的高低显示员工的信息和年薪【可按表达式排序,表达式别名亦可用】
SELECT 
  *,
  salary * 12 * (1+ IFNULL(commission_pct, 0)) 年薪 
FROM
  `employees` 
ORDER BY 年薪 DESC 

# 案例4：按姓名的长度显示员工的姓名和工资【函数LENGTH() 排序】
SELECT 
  LENGTH(last_name) AS 字节长度,
  last_name,
  salary 
FROM
  `employees` 
ORDER BY 字节长度 ASC ;


# 案例5：查询员工信息，要求先按工资升序，在按员工编号降序【按多个字段排序,ORDER BY 后的表达式可用逗号(,)隔开。】
SELECT 
  * 
FROM
  `employees` 
ORDER BY salary ASC,
  `employee_id` DESC ; # 会先按salary的标准排序，在salary有相同的数值情况下，为employee_id排序。


# 小题

# 1. 查询员工的姓名和部门号和年薪，按年薪排降序，按姓名排升序。
SELECT 
  last_name,
  department_id,
  salary * 12 * (1+ IFNULL(commission_pct, 0)) AS 年薪 
FROM
  `employees` 
ORDER BY 年薪 ASC,
  last_name DESC ;

# 2. 选择工资不到8000到17000的员工姓名和工资，按工资降序
SELECT 
  last_name,
  salary 
FROM
  `employees` 
WHERE NOT(salary BETWEEN 8000 AND 17000)
/*
WHERE salary < 8000 
  OR salary > 17000 
ORDER BY salary ASC ;
*/
ORDER BY salary DESC;

# 3. 查询邮箱中包含e的员工信息，并先按邮箱的字节数排降序，再按部门号升序。
SELECT 
  * , LENGTH(email) AS eLength
FROM
  `employees` 
WHERE `email` LIKE '%e%' 
ORDER BY eLength DESC,
  `department_id` ASC ;






