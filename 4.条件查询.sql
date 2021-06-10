# 进阶2：条件查询
/*

语法：
	SELECT 
		查询列表
	FROM
		表明
	WHERE
		筛选条件;
	
分类：
	一、按条件表达式筛选表
	条件运算符：> < = != <> >= <=
	解释：这里的 = 不是赋值，是比较是否相等，<> 和 != 用意一样。
	
	二、按逻辑表达式筛选
	逻辑运算符：
		&&  ||  !
		and or not 
	三、模糊查询
		like
		between and
		in
		is null | is not null
*/

# 一、按条件表达式筛选表
# 案例
# 1 工资>12000的员工信息
SELECT 
  * 
FROM
  `employees` 
WHERE `salary` > 12000 ;

# 2 查询部门编号不等于90号的员工名和部门编号
SELECT 
  `department_id`,
  `first_name` 
FROM
  `employees` 
WHERE `department_id` <> 100 ;

#二、按逻辑表达式筛选

# 1 查询工资在10000到20000之间的的员工名，工资以及奖金；
SELECT 
  `last_name` AS '名',
  `salary` AS '工资',
  IFNULL(`commission_pct`, 0) AS '奖金' 
FROM
  `employees` 
WHERE salary >= 10000 
  AND salary <= 20000 ;

# 2 查询部门编号不是90到110之间，或者工资高于15000的员工信息。
SELECT 
  * 
FROM
  `employees` 
WHERE NOT (
    `department_id` >= 90 
    AND `department_id` <= 110
  ) 
  OR `salary` > 15000 ;
/*WHERE `department_id` < 90 
  or `department_id` > 110 
  or `salary` > 15000 ;
  */


#三、 模糊查询
/*
like
特点：
①一般和通配符搭配使用
	通配符：% 任意多个字符，包含0个字符，_ 任意单个字符，
*/

#1.like
#案例
# 1.1：查询员工名中包含字符a的员工信息
SELECT 
	*
FROM
	`employees`
WHERE
	`last_name` LIKE '%a%';

# 1.2：查询员工名中第二个字符为c，第六个字符为a的员工名和工资。
SELECT 
  last_name,
  salary 
FROM
  `employees` 
WHERE last_name LIKE '_c___n' ;

# 1.3:查出员工名中第二个字符为_的员工名，使用转义符号 \ 。
SELECT 
  * 
FROM
  `employees` 
WHERE last_name LIKE '_\_%'; 
# 指定一个转义符号： last_name LIKE '_$_%' ESCAPE '$' # 指定 $ 为转义字符。

#2.between and 
/*
①使用between and 可以提高代码的简洁度。
②包含临界值。
③两分临界值不要调换。
*/
#案例
# 1.1：查询员工编号100到120之间的员工信息
SELECT 
  * 
FROM
  `employees` 
WHERE `employee_id` >= 100 
  AND `employee_id` <= 120 ;
  
# 上下两块代码意义一样 — — — — — — — — — — — —

SELECT * FROM `employees` WHERE `employee_id` BETWEEN 100 AND 120;

#3.in
/*
含义：判断某字段的值是否属于in列表中的某一项
特点：
	①使用in相对某些情况代码相对简洁。
	②in列表的值类型必须统一。
	③不支持使用模糊查询格式的值。
*/
#案例
#1.1 查询员工的工种编号是 IT_PROG 、AD_VD 、AD_PRES 中的一个员工名和工种编号。
SELECT 
  last_name,
  job_id 
FROM
  `employees` 
WHERE job_id = 'IT_PROT' 
  OR job_id = 'AD_VP' 
  OR job_id = 'AD_PRES' ;
  
# 上下两块代码意义一样 — — — — — — — — — — — —

SELECT 
  last_name,
  job_id 
FROM
  `employees` 
WHERE job_id IN ('IT_PROG', 'AD_VP', 'AD_PRES')


#4. is null
#案例
#1.1：查询没有奖金的员工名和奖金率, mysql语句 xxx = null 是不能判断 xxx 是否等于null的。
SELECT 
  last_name,
  IFNULL(commission_pct, '是的是null') 
FROM
  `employees` 
WHERE commission_pct IS NULL ;
#1.2：查询有奖金的员工名和奖金率。
SELECT 
  last_name,
  commission_pct 
FROM
  `employees` 
WHERE commission_pct IS NOT NULL ;

 
# 安全等于：<=>
#案例
#1.1：查询没有奖金的员工名和奖金率,安全等于可以直接用来判断目标等不等于null。
SELECT 
  last_name,
  commission_pct 
FROM
  `employees` 
WHERE (`commission_pct` <=> NULL) ;

#1.2: 查询员工工资为12000的员工信息。
SELECT 
  last_name,
  salary 
FROM
  `employees` 
WHERE salary <=> 12000 ;

# is null pk <=>
IS NULL :仅仅可以判断NULL值，可读性相对好点。
<=>	:既可以判断NULL值，又可以判断普通的数值，但是可读性相对低。



# 条件查询2
# 查询员工号为176的员工的姓名和部门号和年薪
SELECT 
  last_name,
  department_id,
  salary * 12 * (1+ IFNULL(commission_pct, 0)) AS 年薪 
FROM
  `employees` ;



# 作业
# 1. 查询没有奖金，且工资小于18000的salary，last_name

SELECT * FROM `employees` WHERE `salary`<18000 AND `commission_pct` IS NULL;

# 2. 查询部门，job_id不为 ‘IT’ 或者工资为12000的员工信息

SELECT * FROM `employees` WHERE job_id != 'IT' OR salary = 12000;

# 3. 查看部门`departments`表的结构
DESC `departments`;

# 4. 查询部门`departments`表中涉及到了那些位置编号
SELECT location_id FROM `departments`;

# 5. 
#试问：
/*
SELECT 
  * 
FROM
  `employees` ;

和 
SELECT 
  * 
FROM
  `employees` 
WHERE `commission_pct` LIKE '%%' AND last_name like '%%';
结果是否一样？并说明原因。
*/
SELECT 
  * 
FROM
  `employees` 
WHERE `commission_pct` LIKE '%%' 
  AND last_name LIKE '%%' ;
# 答案：不一样，因为判断的值有的可能为null，如果全部没有为null的那么就是一样的。
