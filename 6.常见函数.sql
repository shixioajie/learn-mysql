# 常见函数
/*
概念：类似于java的方法，将一组逻辑语句封装在方法中，对外暴露方法名。
好处：1、隐藏了实现细节。 2、提高了代码的复用性。
调用：SELECT 函数名(参数列表) 【from 表】；
特点：
	①函数名
	②函数功能
分类：
	1.单行函数，如concat、length、ifnull等。
	2.分组函数，功能:做统计使用的、又称为统计函数、聚合函数、组函数
	
*/
# 一、字符函数
#1.length 获取参数值的字节个数
SELECT 
  LENGTH('English') ;

# 7
SELECT 
  LENGTH('汉字') ;

# 6 注意这里一个汉字占据3字节。
SHOW VARIABLES LIKE '%char%' #2.concat 拼接字符串
SELECT 
  CONCAT(last_name, '_', first_name) AS 姓名 
FROM
  `employees` ;

#3.upper、lower
SELECT 
  UPPER('john') ;

SELECT 
  LOWER('joHN') ;

#示例：将姓变为大写，名变小写，然后拼接
SELECT 
  CONCAT(
    LOWER(first_name),
    ' ',
    UPPER(last_name)
  ) AS 姓名 
FROM
  `employees` ;

#4. 字符串截取 substr(originStr,index+1,length) 
# substr和substring是同一功能函数 。
# 注意了再类似与 java、python、js等语言索引下标从0开始，而再sql语言中，下标是从1开始。
SELECT 
  SUBSTR('张无忌藏书处', 4) AS books ;

#藏书处 
# 还是注意了一般语言截取有开始参数有结束参数是左闭右开的形式，而sql中结束参数是截取长度的意思。
SELECT 
  SUBSTR('张无忌藏书处', 1, 3) AS name1 ;

# 案例：姓名中首字符大写，其它字符小写然后_拼接，显示出来
SELECT 
  CONCAT(
    SUBSTR(UPPER(first_name), 1, 1),
    SUBSTR(LOWER(first_name), 2),
    '_',
    LOWER(last_name)
  ) AS 姓名 
FROM
  `employees` ;

#5. 字符串查找 instr(originStr,tagetStr)
# 返回字符串第一次出现的索引，如果找不到返回0
SELECT 
  INSTR('新华字典', 'zid') AS out_put ;

#6. trim 
# 去除字符串前后不想要的字符，默认只写一个字符串会去除该前后空格。
SELECT 
  LENGTH(TRIM('   令狐冲   ')) AS out_put ;

SELECT 
  TRIM(
    'a' FROM 'aaaaaaa令aaaaa狐aaa冲aa'
  ) AS out_put ;

#7. lpad
# 左填充，填充的字符指定参数。
# 注意：当第二个参数过小时，返回的值会是字符串剪裁掉的结果，从字符串右侧开始剪裁。
SELECT 
  LPAD('殷素素', 10, '*') AS out_put ;

SELECT 
  LPAD('殷素素', 1, '*') AS out_put ;

#8. rpad
#右填充
SELECT 
  RPAD('-独孤九剑-', 12, '剑气') AS out_put ;

# 分组查询
# 关键字：group by
/*
语法：
	SELECT 分组函数，列（要求出现在group by的后面）
	from 表
	【where 筛选条件】
	group by 分组的列表
	【order by 子句】
注意：
	查询列表必须特殊，要求是分组函数和group by后出现的字段

特点：
	1、分组查询中的筛选条件分为两类
			数据源			位置			关键字
	分组前筛选	原始表 			group by子句的前面	where
	分组后筛选	分组后的结果集		group by子句的后面	having

	①分组函数做条件肯定是放在having子句中
	②能用分组前筛选的，就优先考虑使用分组前筛选的
*/
# 引入：查询平均工资
SELECT 
  AVG(salary) 
FROM
  `employees` ;

#简单分分组查询
# 案例1：查询每个工种的最高工资
SELECT 
  MAX(salary),
  job_id 
FROM
  `employees` 
GROUP BY job_id ;

# 案例2：查询每个位置上的部门个数
SELECT 
  COUNT(*),
  location_id 
FROM
  `departments` 
GROUP BY `location_id` ;

# 案例3：查询邮箱中包含a字符的，每个部门的平均工资
SELECT 
  AVG(salary),
  `department_id` 
FROM
  `employees` 
WHERE `email` LIKE '%a%' 
GROUP BY `department_id` ;

# 案例4：查询有奖金的每个领导手下的员工的最高工资
SELECT 
  MAX(salary),
  manager_id 
FROM
  `employees` 
WHERE commission_pct IS NOT NULL 
GROUP BY `manager_id` 
ORDER BY MAX(salary) ASC ;

#添加复杂的筛选条件
#案例1：查询那个部门的员工个数>2
SELECT 
  COUNT(*) AS C,
  `department_id` 
FROM
  `employees` 
GROUP BY `department_id` 
HAVING C > 2 ;

# 注意 C>2比较特殊在from 表中是没有这个C的，作为一个后出现的
#案例2：查询每个工种有奖金的员工的最高工资>12000的工种编号和最高工资
#①查询每个工种有奖金的员工的最高工资
SELECT 
  MAX(salary),
  job_id 
FROM
  `employees` 
WHERE commission_pct IS NOT NULL 
GROUP BY job_id ;

#②根据①的结果继续筛选，最高工资>12000
SELECT 
  MAX(salary) AS MS,
  job_id 
FROM
  `employees` 
WHERE commission_pct IS NOT NULL 
GROUP BY job_id 
HAVING MS > 12000 ;

#案例3：查询领导编号>102的每个领导手下的最低工资>5000的领导编号是那个，以及最低工资。
#① 查询领导编号>102的领导
SELECT 
  `manager_id` 
FROM
  `employees` 
WHERE manager_id > 102 ;

#②查询这些领导手下的最低工资
SELECT 
  MIN(salary),
  `manager_id` 
FROM
  `employees` 
WHERE `manager_id` > 102 
GROUP BY `manager_id` ;

#③最低工资>5000的
SELECT 
  MIN(salary),
  `manager_id` 
FROM
  `employees` 
WHERE `manager_id` > 102 
GROUP BY `manager_id` 
HAVING MIN(salary) > 5000 ;




