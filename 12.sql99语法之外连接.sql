#二、外连接
/*
应用场景：用于查询一个表中有，而另一个表没有的记录 

特点：
1、外连接的查询结果为‘主’表中的所有记录
	如果‘从’表中有和它匹配的，则显示匹配的值
	如果从表中没有和它匹配的，则显示null
	外连接查询结果=内连接结果+主表中有而从表没有的记录
2、左外连接，lefe，join左边的是主表
   右外连接，right，join右边的是主表
3、左外和右外交换两个表的顺序，可以实现同样的效果
*/
#复习：查询男朋友 在 男生表的女生名
SELECT 
  NAME,
  boyName 
FROM
  beauty 
  INNER JOIN boys 
    ON beauty.`boyfriend_id` = boys.`id` ;

#引入：查询男朋友 不在 男生表的女生名
#左外连接
SELECT 
  be.`name`,
  bo.* 
FROM
  beauty AS be 
  LEFT OUTER JOIN boys AS bo 
    ON be.`boyfriend_id` = bo.`id` 
WHERE bo.`id` IS NULL ;

#右外连接
SELECT 
  be.`name`,
  bo.* 
FROM
  boys AS bo 
  RIGHT OUTER JOIN beauty AS be 
    ON be.`boyfriend_id` = bo.`id` 
WHERE bo.`id` IS NULL ;

#主从调换
SELECT 
  be.*,
  bo.* 
FROM
  boys AS bo 
  LEFT OUTER JOIN beauty be 
    ON be.`boyfriend_id` = bo.`id` 
WHERE be.`id` IS NULL ;


#案例1：查询那个部门没有员工
#左外
SELECT 
  d.`department_name`,
  e.*
FROM
  `departments` AS d 
  LEFT OUTER JOIN `employees` AS e 
    ON d.`department_id` = e.`department_id` 
    WHERE e.`employee_id` IS NULL;

#右外
SELECT 
  DISTINCT d.`department_name`
FROM
  `employees` AS e 
  RIGHT OUTER JOIN `departments` AS d 
    ON d.`department_id` = e.`department_id` 
WHERE e.`employee_id` IS NULL ;















