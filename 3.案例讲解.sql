# 下面的语句是否可以执行成功，并且改错，假设已经 use `myemployees`。

# salary 起别名
SELECT 
  last_name,
  job_id,
  salary AS sal 
FROM
  `employees` ;
  
# slqary * 12 起别名
SELECT 
  `employee_id`,
  `last_name`,
  `salary` * 12 AS 'ANNUAL SALARY' 
FROM
  `employees` ;


# 显示表departments的结构，并查询其中的全部数据。
DESC `departments`;
SELECT * FROM `departments`;

# 显示出表`employees`中的全部job_id(不重复)
SELECT DISTINCT job_id FROM `employees`;


# 显示出表`employees`的全部列，各个列之间用逗号连接，列头显示成out_put
# SELECT IFNULL(expr1，expr2);判断是否为NULL,可替换。
SELECT IFNULL(commission_pct,0) AS 奖金率 FROM `employees`;

SELECT CONCAT(`job_id`,',',`manager_id`,',',`salary`,',', IFNULL(`commission_pct`,0)) AS OUT_PUT FROM `employees`;

