#子查询
/*
含义：
出现在其它语句中的select语句，称为子查询或内查询
内部嵌套其它select语句的查询，称为外查询或主查询

示列：
select first_name from employees where 
	department_id in(select department_id from departments where location_id=1700)
	
分类：
按子查询出现的位置：

	select后面：
		仅支持标量子查询
	from后面：
		支持表子查询
	where后面或having后面： （重点）★
		标量子查询	（单行）√ 
		列子查询	（多行）√
		行子查询
	exists后面（相关子查询）
		表子查询
	
按结果集的行列数不同：
	标量子查询（结果集只有一行一列）
	列子查询（结果集只有一列多行）
	行子查询（结果集有一行多列）
	表子查询（结果集一般为多行多列）
*/

#一、where或having后面
/*
1、标量子查询（单行子查询）
2、列子查询（多行子查询）
3、行子查询（多列多行）

特点：
①子查询放在小括号内
②子查询一般放在条件的右侧
③标量子查询，一般搭配单行操作符使用如：   > < >= <= = <>
列子查询，一般搭配多行操作符号使用
in、any|some、all
④子查询的执行优先于主查询执行，主查询的条件用到了子查询的结果。


*/

#1.标量子查询

#案例1：谁的工资比 Abel 高？

#①查询Abel的工资
SELECT 
  salary 
FROM
  employees 
WHERE last_name = 'Abel' ;

#②查询员工的信息，满足 salary>①结果
SELECT 
  * 
FROM
  employees 
WHERE salary > 
  (SELECT 
    salary 
  FROM
    employees 
  WHERE last_name = 'Abel')

#案例2：返回job_id与141号员工相同，salary比143号员工多的员工的姓名、 job_id、 工资
#①查询141号员工的job_id
SELECT 
  job_id
  FROM `employees`
  WHERE `employee_id` = 141;

#②查询143号员工的salary
SELECT salary FROM employees WHERE employee_id = 143;

#③查询员工的姓名、job_id 、 工资，要求 job_id=①并且salary>②
SELECT 
  `last_name`,
  `job_id`,
  `salary` 
FROM
  employees 
WHERE job_id = 
  (SELECT 
    job_id 
  FROM
    `employees` 
  WHERE `employee_id` = 141) 
  AND salary > 
  (SELECT 
    salary 
  FROM
    employees 
  WHERE employee_id = 143) ;


#案例3：返回公司工资最少的员工的last_name,job_id和salary

#①查询公司的最低工资
SELECT MIN(salary) FROM `employees`;

#②查询last_name,job_id和salary，要求salary=①
SELECT last_name,job_id,salary FROM employees WHERE salary = (SELECT MIN(salary) FROM `employees`);

#案例4：查询最低工资大于50号部门最低工资的部门id和其最低工资

#①查询50号部门的最低工资
SELECT MIN(salary)
FROM `employees` WHERE department_id = 50;

#②查询每个部门的最低工资
SELECT MIN(salary),department_id
FROM employees
GROUP BY department_id

#② 最低工资大于①的部门id和其最低工资
SELECT 
  department_id,
  MIN(salary) AS minS 
FROM
  employees 
GROUP BY department_id
HAVING minS > (SELECT MIN(salary)
FROM `employees` WHERE department_id = 50);


#非法使用标量子查询
SELECT 
  department_id,
  MIN(salary) AS minS 
FROM
  employees 
GROUP BY department_id 
HAVING minS > 
  (SELECT 
    salary ## 这里成了列子查询
  FROM
    `employees` 
  WHERE department_id = 00 # 查了个不存在的肯定不存在
  ) ;


#列子查询（多行子查询）
/*
返回多行
使用多行比较操作符。

操作符		含义
IN/NOT IN 	等于列表中的任意一个
ANY|SOME	和子查询返回的某一个值比较
ALL		和子查询返回的所有值比较

-》 体会any和all的区别 
any 任意有任意一个的意思，只要有一个符合就都可以。
all 全部的意思，必须全部符合才可以。
*/


#案例1：返回 location_id 是1400或1700的部门中的所有员工姓名


#①查询location_id是1400或1700的部门编号
SELECT DISTINCT 
  `department_id` 
FROM
  `departments` AS depar 
WHERE depar.`location_id` IN (1400, 1700) ;

#②查询员工姓名，要求部门号是①列表中的某一个
SELECT 
  em.`last_name` 
FROM
  `employees` AS em 
WHERE em.`department_id` IN 
  (SELECT DISTINCT 
    `department_id` 
  FROM
    `departments` AS depar 
  WHERE depar.`location_id` IN (1400, 1700)) ;


#这个也可以
SELECT 
  em.`last_name` 
FROM
  `employees` AS em 
  LEFT JOIN `departments` AS depar 
    ON em.`department_id` = depar.`department_id` 
WHERE depar.`location_id` IN (1400, 1700) ;



#案例2：返回其它工种中比job_id为`IT_PROG`工种任意工资低的员工的：工号、姓名、job_id 以及 salary

#①查询job_id为`IT_PROG`部门所有工资
SELECT 
DISTINCT
salary
FROM `employees` WHERE job_id = 'IT_PROG';


#②查询员工的：工号、姓名、job_id 以及 salary，salary<①的任意一个
SELECT 
  `employee_id`,
  `last_name`,
  `job_id`,
  `salary` 
FROM
  `employees` 
WHERE job_id != 'IT_PROG' 
  AND salary < ANY 
  (SELECT DISTINCT 
    salary 
  FROM
    `employees` 
  WHERE job_id = 'IT_PROG' 
) ;

#或小于最大的
SELECT 
  `employee_id`,
  `last_name`,
  `job_id`,
  `salary` 
FROM
  `employees` 
WHERE job_id != 'IT_PROG' 
  AND salary < 
  (SELECT DISTINCT 
    MAX(salary) 
  FROM
    `employees` 
  WHERE job_id = 'IT_PROG') ;
  
  
#案例3：返回其它部门中比job_id为`IT_PROG`部门所有工资都低的员工，的员工号、姓名、job_id以及salary
#①job_id为`IT_PROG`部门所有工资
SELECT 
DISTINCT
salary
FROM `employees`  WHERE job_id= 'IT_PROG';

#②其它部门的工资<① 都低的员工的：员工号、姓名、job_id以及salary 
SELECT 
  `employee_id`,
  `last_name`,
  `job_id`,
  `salary` 
FROM
  `employees` 
WHERE salary < ALL 
  (SELECT DISTINCT 
    salary 
  FROM
    `employees` 
  WHERE job_id = 'IT_PROG') 
  AND job_id <> 'IT_PROG' ;

#或
SELECT 
  `employee_id`,
  `last_name`,
  `job_id`,
  `salary` 
FROM
  `employees` 
WHERE salary < 
  (SELECT 
    MIN(salary) 
  FROM
    `employees` 
  WHERE job_id = 'IT_PROG') 
  AND job_id <> 'IT_PROG' ;

  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  

