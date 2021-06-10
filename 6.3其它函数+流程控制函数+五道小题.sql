# 其它函数
SELECT VERSION();
SELECT DATABASE();
SELECT USER();


# 流程控制函数
#1.if函数：if else 的效果
SELECT IF(10=10,'yes','no') AS 'if';
SELECT 
  last_name,
  commission_pct,
  IF(
    `commission_pct` IS NULL,
    '没有奖金',
    '有奖金'
  ) 
FROM
  `employees`; 
  
#2.case函数的使用一：switch case 的效果

/*
java中：
switch(变量或表达式)：
	case 常量1：语句1；break；
	...
	default：语句n；break；
	
mysql中
case 要判断的字段或表达式
when 常量1 then 要显示的值1或语句1;
when 常量2 then 要显示的值2或语句2;
...
else 要显示的值n或语句n;
end
*/ 

/*案例：查询员工的工资，要求:

部门号=30，显示的工资为1.1倍
部门号=40，显示的工资为1.2倍
部门号=50，显示的工资为1.3倍
其它部门，显示的工资为原工资

*/ 
SELECT salary AS 原始工资,`department_id`,
CASE `department_id`
WHEN 30 THEN salary*1.1
WHEN 40 THEN salary*1.2
WHEN 50 THEN salary*1.3
ELSE salary
END AS 处理后
FROM `employees`;

#3. case 函数的使用二：类似于多重if
/*
java中：
if(条件1){
	语句1：
}else if(条件2){
	语句2：
}
...
else{
	语句
}

mysql中：

case
when 条件1 then 要显示的值1或语句1
when 条件2 then 要显示的值2或语句2
...
else 要显示的值n或语句n
end
*/

#案例：查询员工的工资情况
/*
如果工资>20000,显示A级别
如果工资>15000,显示B级别
如果工资>10000,显示C级别
否则：显示D级别
*/
SELECT salary AS 工资,
CASE
WHEN salary>20000 THEN 'A'
WHEN salary>15000 THEN 'B'
WHEN salary>10000 THEN 'C'
ELSE 'D级别'
END AS '级别'
FROM `employees`;


#1. 显示系统时间（注：日期+时间）
SELECT NOW()  AS '时间';

#2. 查询员工号，姓名，工资，以及工资提搞百分之二十的结果（new salary）
SELECT 
  `employee_id`,
  `first_name`,
  `salary`,
  `salary` * 1.2 AS 'new salary' 
FROM
  `employees` ;

#3. 将员工的姓名按首字母排序，并写出姓名的长度（length）
SELECT 
  `last_name`,
  SUBSTR(last_name, 1, 1) AS 首字符,
  LENGTH(`first_name`) AS 'length' 
FROM
  `employees` 
ORDER BY 首字符 ASC ;

#4. 做一个查询，产生下面的结果
/*
<last_name> earns <salary> monthly but wants <salary*3>
Dream Salary
King earns 2400 monthly but wants 72000
*/
SELECT 
  CONCAT(
    last_name,
    ' earns ',
    salary,
    ' monthly but wants ',
    salary * 3
  ) AS 'Dream Salary' 
FROM
  `employees` 
WHERE salary = 24000 ;

 

#5. 使用CASE-WHEN，按照下面的条件：
/*
job		grade
AD_PRES		A
ST_MAN		B
IT_PROG		C
SA_REP		D
ST_CLERK	E

产生下面的结果
Last_name	Job_id   Grade
king 		AD_PRES  A
*/
SELECT last_name, job_id AS 'job', 
CASE job_id
WHEN 'AD_PRES' THEN 'A'
WHEN 'ST_MAN' THEN 'B'
WHEN 'IT_PROG' THEN 'C'
WHEN 'SA_REP' THEN 'D'
WHEN 'ST_CLERK' THEN 'E'
END AS 'Grade'
FROM `employees`
WHERE job_id = 'AD_PRES';















  
  