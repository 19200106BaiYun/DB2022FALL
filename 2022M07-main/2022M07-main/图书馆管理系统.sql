##创建图书类型表
CREATE TABLE 图书类型
(
图书分类号 CHAR(7) NOT NULL PRIMARY KEY,
图书分类名称 CHAR(20) NOT NULL,
描述信息 VARCHAR(50)
)

创建图书表
CREATE TABLE 图书
(
图书编号 CHAR(13) NOT NULL PRIMARY KEY,
图书名称 VARCHAR(50) NOT NULL,
图书分类号 CHAR(7) NOT NULL,
作者 CHAR(10) NOT NULL,
出版社 CHAR(30),
价格 MONEY NOT NULL CHECK(价格 > CAST(0 AS MONEY)),
CONSTRAINT BooK_Borrow_fkflh FOREIGN KEY(图书分类号) REFERENCES 图书类型(图书分类号)
)

创建读者信息表
CREATE TABLE 读者
(
证件号 CHAR(10) NOT NULL PRIMARY KEY,
姓名 CHAR(8) NOT NULL,
证件状态 CHAR(4) NOT NULL CHECK(证件状态 IN ('可用','失效')),
联系方式 CHAR(11)
)

创建借阅信息表
CREATE TABLE 借阅
(
证件号 CHAR(10) NOT NULL,
图书编号 CHAR(13) NOT NULL,
借阅日期 DATE NOT NULL,
应还日期 DATE NOT NULL,
归还日期 DATE，
罚款金 MONEY NOT NULL DEFAULT 0.0 CHECK (罚款金>=CAST(0.0 AS MONEY),
CONSTRAINT Book_Borrow_pkzjsh PRIMARY KEY (证件号,图书编号,借阅日期),
CONSTRAINT Book_Borrow_fkzjh FOREIGN KEY ( 证件号) REFERENCES 读者(证件号),
CONSTRAINT Book_Borrow_fktsbh FOREIGN KEY (图书编号) REFERENCES 图书(图书编号)
)

删除指定字段
ALTER TABLE 读者 DROP COLUMN 联系方式

增加属性列
ALTER TABLE 读者 ADD 电话 CHAR(12)

修改属性
ALTER TABLE 图书 ALTER COLUMN 图书名称 VARCHAR(50) NUL

删除表格
DROP TABLE 图书类型副本 CASCADE

建立视图
CREATE VIEW 计算机图书
AS
   SELECT 图书.*，图书类型.图书分类名称
   FROM 图书，图书类型
   WHERE 图书.图书分类号=图书类型.图书分类号
   AND 图书类型.图书分类名称 LIKE ‘计算机%’

删除视图
DROP VIEW 计算机图书

在“借阅”表中建立索引
CREATE INDEX BookBorrowInfo_ZJH_JYRQ
ON 借阅(证件号，借阅日期)

在“图书”表中建立索引
CREATE INDEX BookBorrowInfo_ZJH_FLH
ON 图书(图书分类号)

CREATE INDEX BookBorrowInfo_ZJH_TSMC
ON 图书(图书名称)

CREATE INDEX BookBorrowInfo_ZJH_CBS
ON 图书(出版社)

查询指定信息
SELECT 图书名称，出版社，价格 FROM 图书 WHERE 作者 = ‘杨万华’
SELECT DISTING 图书名称，价格 FROM 图书 WHERE 图书名称=‘计算机主板维修从业技能全程通’

