# 数学函数
#round 四舍五入
SELECT ROUND(1.65); #2
SELECT ROUND(-1.65);#-2
# 小数点保留,第二个参数为保留小数点后几位，有进位也只会近1位。
SELECT ROUND(1.567,2);#1.57

#ceil 向上取整,返回>=该参数的最小整数。
SELECT CEIL(1.002); # 2
SELECT CEIL(-1.02); # -1

#floor 向下取整，返回<=该参数的最大整数。
SELECT FLOOR(-9.9);# -10 

#truncate 截断
SELECT TRUNCATE(1.69999,1);# 1.6 

#mod取余
/*
	mod(a,b): a-a/b*b,这里的除法运算被除数和除数都是整数结果也会是整数。
	
*/
SELECT MOD(-11,5);# 1
#上下代码等价
SELECT -11%5; # 1


