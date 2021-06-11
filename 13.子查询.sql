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
	where后面或having后面：（重点）
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
