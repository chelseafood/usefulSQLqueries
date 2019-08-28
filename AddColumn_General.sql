USE DatabaseName
Go
Declare @temptable table (TABLE_NAME nvarchar(255))         
Insert INTO  @temptable SELECT DISTINCT TABLE_NAME
FROM INFORMATION_SCHEMA.COLUMNS
WHERE 
TABLE_NAME NOT IN (SELECT
    TABLE_NAME
    FROM INFORMATION_SCHEMA.COLUMNS 
    WHERE COLUMN_NAME = 'ColumnName') 
AND TABLE_NAME NOT LIKE 'tblWithColumn%';            
SELECT * FROM @temptable;


DECLARE 
C_TEMPTABLE CURSOR
FOR
       SELECT TABLE_NAME
       FROM @temptable
       ORDER BY TABLE_NAME;
OPEN C_TEMPTABLE
DECLARE @tabnm varchar(max)
FETCH NEXT FROM C_TEMPTABLE INTO @tabnm
WHILE @@FETCH_STATUS=0
BEGIN

              Declare @SQL VarChar(MAX)
              Declare @vary varchar(MAX)
              Declare @final varchar(MAX)
              SELECT @SQL = 'ALTER TABLE ' 
              SELECT @SQL = @SQL + @tabnm
              select @vary = ' ADD [ColumnName] [string] NOT NULL DEFAULT 0 ' 
              select @final = @sql + @vary
              Exec ( @final)
              FETCH NEXT FROM C_TEMPTABLE INTO @tabnm
END
CLOSE C_TEMPTABLE  
DEALLOCATE C_TEMPTABLE 
 
