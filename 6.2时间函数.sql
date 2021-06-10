
# 日期函数
# now 返回当前系统日期+时间
SELECT NOW() AS 'NOW';

# curdate 返回当前系统日期，不包含时间
SELECT CURDATE();

# curtime 返回当前时间，不包含日期
SELECT CURTIME();

#可以获取指定的部分，年、月、日、小时、分钟、秒
#年
SELECT YEAR(NOW()) AS 年 ;
SELECT YEAR('1998-1-1') AS 年;
#月
SELECT MONTH(NOW()) AS 月;
SELECT MONTHNAME(NOW()) AS 月; #这个返回的是月份的英文。
#日
SELECT DAY(NOW()) AS 日;
SELECT DAY('1990-1-2') AS 日;
#小时
SELECT HOUR(NOW()) AS 时间;
#分钟
SELECT MINUTE(NOW()) AS 分钟;
#秒
SELECT SECOND(NOW()) AS 秒;

#str_to_date:将日期格式的字符转换成指定格式的日期
SELECT STR_TO_DATE('9-8-1999','%m-%d-%Y') AS 'time';

#date_format:将日期转换成字符
SELECT DATE_FORMAT(NOW(),'%Y年%m月%d日') AS 'time';
SELECT DATE_FORMAT('1994/11/8','%Y年%m月%d日') AS 'time';


