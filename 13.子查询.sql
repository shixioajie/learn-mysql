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

#1、标量子查询

#案例1：谁的工资比 Abel 高？

#①查询Abel的工资
SELECT salary
FROM employees
WHERE last_name = 'Abel';

#②查询员工的信息，满足 salary>①结果
SELECT *
FROM employees
WHERE salary >
      (SELECT salary
       FROM employees
       WHERE last_name = 'Abel')

#案例2：返回job_id与141号员工相同，salary比143号员工多的员工的姓名、 job_id、 工资
#①查询141号员工的job_id
SELECT job_id
FROM `employees`
WHERE `employee_id` = 141;

#②查询143号员工的salary
SELECT salary
FROM employees
WHERE employee_id = 143;

#③查询员工的姓名、job_id 、 工资，要求 job_id=①并且salary>②
SELECT `last_name`,
       `job_id`,
       `salary`
FROM employees
WHERE job_id =
      (SELECT job_id
       FROM `employees`
       WHERE `employee_id` = 141)
  AND salary >
      (SELECT salary
       FROM employees
       WHERE employee_id = 143);


#案例3：返回公司工资最少的员工的last_name,job_id和salary

#①查询公司的最低工资
SELECT MIN(salary)
FROM `employees`;

#②查询last_name,job_id和salary，要求salary=①
SELECT last_name, job_id, salary
FROM employees
WHERE salary = (SELECT MIN(salary) FROM `employees`);

#案例4：查询最低工资大于50号部门最低工资的部门id和其最低工资

#①查询50号部门的最低工资
SELECT MIN(salary)
FROM `employees`
WHERE department_id = 50;

#②查询每个部门的最低工资
SELECT MIN(salary), department_id
FROM employees
GROUP BY department_id

#② 最低工资大于①的部门id和其最低工资
SELECT department_id,
       MIN(salary) AS minS
FROM employees
GROUP BY department_id
HAVING minS > (SELECT MIN(salary)
               FROM `employees`
               WHERE department_id = 50);


#非法使用标量子查询
SELECT department_id,
       MIN(salary) AS minS
FROM employees
GROUP BY department_id
HAVING minS >
       (SELECT salary ## 这里成了列子查询
        FROM `employees`
        WHERE department_id = 00 # 查了个不存在的肯定不存在
       );


#2、列子查询（多行子查询）
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
SELECT DISTINCT `department_id`
FROM `departments` AS depar
WHERE depar.`location_id` IN (1400, 1700);

#②查询员工姓名，要求部门号是①列表中的某一个
SELECT em.`last_name`
FROM `employees` AS em
WHERE em.`department_id` IN
      (SELECT DISTINCT `department_id`
       FROM `departments` AS depar
       WHERE depar.`location_id` IN (1400, 1700));


#这个也可以
SELECT em.`last_name`
FROM `employees` AS em
         LEFT JOIN `departments` AS depar
                   ON em.`department_id` = depar.`department_id`
WHERE depar.`location_id` IN (1400, 1700);



#案例2：返回其它工种中比job_id为`IT_PROG`工种任意工资低的员工的：工号、姓名、job_id 以及 salary

#①查询job_id为`IT_PROG`部门所有工资
SELECT DISTINCT salary
FROM `employees`
WHERE job_id = 'IT_PROG';


#②查询员工的：工号、姓名、job_id 以及 salary，salary<①的任意一个
SELECT `employee_id`,
       `last_name`,
       `job_id`,
       `salary`
FROM `employees`
WHERE job_id != 'IT_PROG'
  AND salary < ANY
      (SELECT DISTINCT salary
       FROM `employees`
       WHERE job_id = 'IT_PROG'
      );

#或小于最大的
SELECT `employee_id`,
       `last_name`,
       `job_id`,
       `salary`
FROM `employees`
WHERE job_id != 'IT_PROG'
  AND salary <
      (SELECT DISTINCT MAX(salary)
       FROM `employees`
       WHERE job_id = 'IT_PROG');


#案例3：返回其它部门中比job_id为`IT_PROG`部门所有工资都低的员工，的员工号、姓名、job_id以及salary
#①job_id为`IT_PROG`部门所有工资
SELECT DISTINCT salary
FROM `employees`
WHERE job_id = 'IT_PROG';

#②其它部门的工资<① 都低的员工的：员工号、姓名、job_id以及salary 
SELECT `employee_id`,
       `last_name`,
       `job_id`,
       `salary`
FROM `employees`
WHERE salary < ALL
      (SELECT DISTINCT salary
       FROM `employees`
       WHERE job_id = 'IT_PROG')
  AND job_id <> 'IT_PROG';

#或
SELECT `employee_id`,
       `last_name`,
       `job_id`,
       `salary`
FROM `employees`
WHERE salary <
      (SELECT MIN(salary)
       FROM `employees`
       WHERE job_id = 'IT_PROG')
  AND job_id <> 'IT_PROG';



#3、行子查询（结果集一行多列或多行多列）

#案例：查询员工编号最小并且工资最高的员工信息
#------- 使用标量子查询 ---------#
#①查询最小的员工编号
SELECT MIN(employee_id)
FROM employees;

#②查询最高工资
SELECT MAX(salary)
FROM employees;


#③查询员工信息
SELECT *
FROM employees
WHERE employee_id =
      (SELECT MIN(employee_id)
       FROM employees)
  AND salary =
      (SELECT MAX(salary)
       FROM employees);


/* ----- 列子查询 ----- */
SELECT *
FROM employees
WHERE (employee_id, salary) =
      (SELECT MIN(employee_id),
              MAX(salary)
       FROM employees);



# select 后面
# 仅支持标量子查询
#案例：查询每个部门的员工个数

/* 分组的效果 */
SELECT COUNT(employee_id),
       department_id
FROM `employees`
GROUP BY `department_id`;

/* select后子查询的效果 */
SELECT depar.*,
       (SELECT COUNT(*)
        FROM `employees` AS e
        WHERE e.department_id = depar.`department_id`) AS me
FROM `departments` AS depar;


#案例2：查询员工号=102的部门名

SELECT *
FROM `departments` AS d
WHERE d.`department_id` =
      (SELECT e.`department_id`
       FROM `employees` AS e
       WHERE e.`employee_id` = 102);


SELECT (SELECT department_name
        FROM departments AS d
                 INNER JOIN employees AS e
                            ON d.`department_id` = e.`department_id`
        WHERE e.`employee_id` = 102
       ) AS 部门名;



#三、from 后面
/*
将子查询结果充当一张表，要求必须起别名
*/

#案例：查询每个部门的平均工资的工资等级
#①查询每个部门的平均工资
SELECT AVG(salary), department_id
FROM employees
GROUP BY `department_id`;

#②查询平均工资等级
SELECT ag_dep.*,
       jg.`grade_level`
FROM (SELECT AVG(salary) AS ag,
             department_id
      FROM `employees`
      GROUP BY department_id) ag_dep
         INNER JOIN job_grades AS jg
                    ON ag_dep.ag BETWEEN jg.`lowest_sal` AND jg.`highest_sal`;



#四、exists后面（相关子查询）
/*
语法：
exists（完整的查询语句）
结果：1或0.
是否存在，返回布尔类型 1 为 true 0 为 false 。
*/

SELECT EXISTS(SELECT employee_id FROM employees);# 1
SELECT EXISTS(SELECT employee_id FROM employees WHERE `salary` <= 0);
#0

#是否存在，返回布尔类型。 

#案例1：查询有员工的部门名 

#in
SELECT department_name
FROM departments AS dep
WHERE dep.`department_id` IN
      (SELECT `employee_id`
       FROM `employees`);

#exists    
SELECT department_name
FROM `departments` AS dep
WHERE EXISTS
          (SELECT em.`last_name`
           FROM `employees` AS em
           WHERE em.`department_id` = dep.`department_id`);


#案例2：查询没有女朋友的男生信息

#用in
SELECT *
FROM boys AS boy
WHERE boy.`id` NOT IN
      (SELECT be.`boyfriend_id`
       FROM `beauty` AS be);

#exists
SELECT *
FROM boys AS boy
WHERE NOT EXISTS
    (SELECT *
     FROM `beauty` AS be
     WHERE be.`boyfriend_id` = boy.`id`);


# 7道小题
SELECT department_id
FROM `employees`
WHERE last_name = 'Zlotkey';
# 1、查询和Zlotkey相同部门的员工姓名和工资
SELECT em.salary,
       em.last_name,
       em.`department_id`
FROM `employees` AS em
WHERE em.`department_id` = (SELECT em2.`department_id`
                            FROM `employees` AS em2
                            WHERE last_name = 'Zlotkey');

# 2、查询工资比公司平均工资高的员工的：工号、姓名、工资

# ①部门平均工资
SELECT AVG(salary)
FROM `employees`;

# ②工资>①
SELECT em1.`employee_id`,
       em1.`last_name`,
       em1.`salary`
FROM employees AS em1
WHERE em1.`salary` > (SELECT AVG(salary) FROM `employees`)
ORDER BY em1.`salary`
;


# 3、查询各部门中工资比本部门平均工资高的员工的：工号、姓名、工资。

#①部门平均工资
SELECT AVG(em.salary),
       dep.`department_id`
FROM employees AS em,
     departments AS dep
WHERE em.`department_id` = dep.`department_id`
GROUP BY em.`department_id`;

#②本部门员工工资高于本部门平均
SELECT em1.`employee_id`,
       em1.`last_name`,
       em1.`salary`,
       em1.department_id
FROM `employees` AS em1
         INNER JOIN
     (SELECT AVG(em.salary) AS ag,
             em.`department_id`
      FROM employees AS em
      GROUP BY em.`department_id`) AS ag_dep
     ON ag_dep.`department_id` = em1.`department_id`
WHERE em1.salary > ag;


#4、查询和姓名中包含字母u的员工在相同部门的员工的：员工号、姓名。

#①查询姓名中包含字母u的员工的部门
SELECT DISTINCT department_id
FROM `employees`
WHERE last_name LIKE '%u%';
#②查询部门号=①中的任意一个的员工号和名字
SELECT last_name,
       employee_id
FROM employees
WHERE department_id IN
      (SELECT DISTINCT department_id
       FROM `employees`
       WHERE last_name LIKE '%u%');

#5、查询在部门的location_id为1700的部门工作的员工的员工号

#①部门为1700的有那也
SELECT *
FROM `departments`
WHERE location_id = 1700;
#②部门=①的
SELECT em.`employee_id`
FROM `employees` AS em
WHERE em.`department_id` IN
      (SELECT DISTINCT dep.`department_id`
       FROM `departments` AS dep
       WHERE location_id = 1700);

#6、查询管理者是K_ing的员工姓名和工资

SELECT last_name, employee_id
FROM `employees`
WHERE last_name = 'K_ing';
#②查询那个员工的manager_id = ①
SELECT em1.last_name,
       em1.salary,
       em1.`manager_id`
FROM `employees` AS em1
WHERE em1.`manager_id` = ANY
      (SELECT em2.employee_id
       FROM `employees` AS em2
       WHERE em2.last_name = 'K_ing');


# 7、查询工资最高的员工的名字，要求first_name,last_name显示为一列，列名为：姓.名

#①查询最高工资
SELECT MAX(salary)
FROM `employees`;
#②查询工资=①的姓名.名
SELECT CONCAT(first_name, last_name) AS '姓.名'
FROM `employees`
WHERE salary =
      (SELECT MAX(salary)
       FROM `employees`);




