	/*
  复习
  
  SQL语法
  
  一、连接查询
  
  1、内连接
  select	查询列表
  from		表名1 as 别名1 
  【inner】 join	表名2 as 别名2 on 连接条件
  where		分组去过滤条件
  gourp by	分组语句 
  having	分组后过滤
  order by	排序语句
  limit 	分页语句;
  
  特点：
   Ⅰ 表的顺序可以调换
   Ⅱ 内连接的结果=多表的交集
   Ⅲ n表连接至少需要n-1个连接条件
   
  分类：
  等值连接
  非等值连接
  自链接
  
  2、外连接
  
  select	查询列表
  from		表名1 as 别名1 
  left|right|full 【outer】 join  表名2 as 别名2  on 连接条件
  where		分组去过滤条件
  gourp by	分组语句 
  having	分组后过滤
  order by	排序语句
  limit 	分页语句;
  
  特点：
   Ⅰ 查询的结果=主表中所有的行，如果从表和它匹配的将显示匹配行，如果从表没有匹配的则显示null。
   Ⅱ left join 左边的就是主表，right join 右边的就是主表。
   Ⅲ 一般用于查询除了交际部分的剩余的不匹配的行。
   
  3、交叉连接
  
  语法：
  select	查询列表 
  from		表1 别名1 
  cross join	表2 别名2;
  
  特点：
  类似于笛卡尔乘积
  
  
  
  二、子查询
  
  子查询的意义：
    嵌套再其它语句内部的select语句称为子查询或内查询，
  外面的语句可以是insert、update、delete、select等，一般select作为外面语句较多，
  外面如果为select语句，则此语句称为外查询或主查询。
  
  分类：
    Ⅰ 按出现位置
    select 后面：
		仅仅支持标量子查询
    from 后面：
		表子查询
    where或having 后面：
			标量子查询
			列子查询
			行子查询
    exists 后面：
		标量子查询
		列子查询
		行子查询
		表子查询
    
   Ⅱ 按结果集的行列
    标量子查询（单行子查询）：结果集为一行一列。
    列子查询（多行子查询）：结果集为多行一列。
    行字查询：结果为多行多列。
    表子查询（嵌套子查询）：结果集为多行多列。
    
  示例：
  where 或 having 后面
  1、标量子查询
   案例：查询一下最低工资的员工姓名和工资
   ① 查询最低工资
   select min(salary) from employees
   
   ②查询员工的姓名和工资、要求工资=①
   select last_name,salary from employees
   where salary =(select min(salary) from employees)   
      
   2、列子查询  
    案例：查询所有是领导的员工姓名
    ①查询所有的员工的 manager_id
    select manager_id from employees 
    
    ②查询姓名，employee_id属于①列表的一个
    select last_name 
    from employees
    where employee_id in(
	select manager_id
	from employees
    )
  
  
  三、分页子查询
  应用场景：
	当要查询的条目数太多，一页显示不全
  语法：
  
	select 查询列表
	from	表
	limit	【offset,】size;
	
	注意：offset代表的是起始的条目索引，默认从0开始。
		size表示的是显示条目数
		
	公式：
	假如要显示的页数为page，每页条目数为size
	select 查询列表
	from	表
	
	limit (page-1)*size,size;
  

*/

