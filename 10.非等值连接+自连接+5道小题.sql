#非等值连接

/*
建表不必多说

/*CREATE TABLE job_grades
(grade_level VARCHAR(3),
 lowest_sal  int,
 highest_sal int);

INSERT INTO job_grades
VALUES ('A', 1000, 2999);

INSERT INTO job_grades
VALUES ('B', 3000, 5999);

INSERT INTO job_grades
VALUES('C', 6000, 9999);

INSERT INTO job_grades
VALUES('D', 10000, 14999);

INSERT INTO job_grades
VALUES('E', 15000, 24999);

INSERT INTO job_grades
VALUES('F', 25000, 40000);*/

*/



#案例1：查询员工的工资和工资级别
SELECT 
  salary,
  grade_level 
FROM
  `employees` AS e,
  `job_grades` AS jg 
WHERE e.`salary` >= jg.`lowest_sal` 
  AND e.`salary` <= jg.`highest_sal` 
ORDER BY salary ASC;



#自连接
#案例：查询员工和上级的名称
SELECT 
  e.`employee_id`,
  e.`last_name`,
  m.`employee_id`,
  m.`last_name` 
FROM
  `employees` AS e,
  `employees` AS m 
WHERE 
e.`manager_id` = m.`employee_id`





#五道小题
#一、显示员工表的最大工资，工资平均值
SELECT MAX(salary),AVG(salary) FROM `employees`;

#二、查询员工的employee_id,job_id,last_name,按department_id降序，salary升序。
SELECT 
  employee_id,
  job_id,
  last_name ,
  salary
FROM
  `employees` 
ORDER BY 
  department_id DESC,
  salary ASC ;

#三、查询员工表的job_id中包含 a和e的并且a在e的前面
SELECT 
  job_id 
FROM
  `employees` 
WHERE job_id LIKE '%a%e%' 

#四、已知表 student，里面有id（学号）,name，gradeId（年纪编号）
#已知表grade，里面有id（年纪编号），name（年纪名）
#已知表result，里面有id，score，studentNo（学号）
# 要求查询姓名，年纪名、成绩
/*
SELECT s.NAME,g.name,
FROM student AS s,grade AS g,result AS r
WHERE s.id=r.studentNo AND s.gradeId=grade.id
*/



#五、显示当前日期，以及去除前后空格，截取字符串的函数。
SELECT NOW();
SELECT TRIM() ;
/*
SELECT SUBSTR(str,startIndex);
SELECT SUBSTR(str,startIndex,length);
*/

















