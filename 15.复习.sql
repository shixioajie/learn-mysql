	/*
  复习
  
  SQL语法
  
  1、内连接
  select	查询列表
  from		表名1 as 别名1 
  【inner】 join	表名2 as 别名2
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
  left|right|full 【outer】 join	表名2 as 别名2
  where		分组去过滤条件
  gourp by	分组语句 
  having	分组后过滤
  order by	排序语句
  limit 	分页语句;
  
  特点：
   Ⅰ 查询的结果=主表中所有的行，如果从表和它匹配的将显示匹配行，如果从表没有匹配的则显示null。
   Ⅱ left join 左边的就是主表，right join 右边的就是主表。
   Ⅲ 一般用于查询除了交际部分的剩余的剩余的不匹配的行。
   
  3、交叉连接
  
  语法：
  select	查询列表 
  from		表1 别名1 
  cross join	表2 别名2;
  
  特点：
  类似于笛卡尔乘积
  
  
  
  2、子查询
  
  子查询的意义：
    嵌套再其它语句内部的select语句称为子查询或内查询，
  外面的语句可以是insert、update、delete、select等，一般select作为外面语句较多，
  外面如果为select语句，则此语句称为外查询或主查询。
  
  分类：
    Ⅰ 按出现位置
    select
    from
    where或having后面
    exists后面
    
    Ⅱ 按结果集的行列
    标量子查询（单行子查询）：结果集为一行一列。
    列子查询（多行子查询）：结果集为多行一列。
    行字查询：结果为多行多列。
    表子查询（嵌套子查询）：结果集为多行多列。
  
  
  
  
  
  
  
  
  

*/