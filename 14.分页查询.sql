#进阶：分页查询
/*
应用场景：当要显示的数据，一页显示不全，需要分页提交sql请求
语法：
	select  查询列表		(step7)
	from	表    			(step1)
	【join type join 表2		(step2)		
	  on 连接条件			(step3)
	  where 筛选条件		(step4)
	  group by 分组字段		(step5)
	  having 分组后的筛选		(step6)
	  order by 排序的字段		(step8)
	】limit 【offset,】size;	(step9)
	
	offset要显示条目的起始索引（起始索引从0开始）
	size 要显示的条目个数
	
特点：
	①limit语句放在查询语句的最后(执行逻辑和语法上都是在最后)
	②公式
	要显示的页数 page，每条目数size
	
	select 查询列表
	from 表
	limit (page-1)*size,size;
	
*/

#案例1：查询前五条员工信息

SELECT 
  * 
FROM
  `employees` 
LIMIT 0, 5 ;

#案例2：查询第11条——第25条
SELECT * FROM employees LIMIT 10,15;

#案例3：有奖金的员工信息，并且工资较高的前10名显示出来
SELECT 
  * 
FROM
  employees AS em 
WHERE em.`commission_pct` IS NOT NULL 
ORDER BY em.`salary` DESC 
LIMIT 0, 10 ;


/*
已知表 stuinfo
id 学号
name 姓名
email 邮箱 示例： john@126.com
gradeId 年纪编号
sex 性别 男 女
age 年龄

已知表 grade
id 年纪编号
gradeName 年纪名称
*/

# 一、查询所有学员的邮箱的用户名（注，邮箱中 @前面的字符）
SELECT SUBSTR(email,1,INSTR(email,'@')-1) 用户名 FROM stuinfo;

# 二、查询男生和女生的个数
SELECT COUNT(id) AS 个数,sex FROM stuinfo GROUP BY sex;

# 三、查询年龄>18的所有学生的姓名和年纪名称
SELECT 
  NAME,
  gradeName 
FROM
  stuinfo 
  INNER JOIN grade 
    ON stuinfo.gradeId = grade.id 
WHERE age > 18 ;


# 四、查询那个年纪的学生最小年龄>20岁
# ① 每个年纪的最小年龄。 ② 在①的结果上最小年龄>20
SELECT 
  MIN(age),
  gradeid 
FROM
  stuinfo 
GROUP BY gradeid 
HAVING MIN(age) > 20;


# 五、试说出查询语句中涉及道所有的关键字，以及它们的先后执行顺序
SELECT 查询列表 [6]
FROM    
表A 连接类型 JOIN 表B   [1]
ON 筛选条件 [2]
WHERE 筛选条件  [3]
GROUP BY 分组列表 [4]
HAVING 分组后的筛选 [5]
ORDER BY 排序列表  [7]
LIMIT 偏移,条目数;  [8]

#备注：每一条语句都会生成一个虚拟的表格直到真正查出来。













