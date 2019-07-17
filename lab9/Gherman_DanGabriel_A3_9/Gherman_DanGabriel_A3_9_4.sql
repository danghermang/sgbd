CREATE OR REPLACE PROCEDURE clonare_tabela(tablename varchar2,newtablename varchar2) AS
v_CursorID  integer;
v_CreateTableString  VARCHAR2(500); 
v_NUMRows  INTEGER; -- Number of rows processed - of no use
BEGIN
    v_CursorID := DBMS_SQL.OPEN_CURSOR; -- Get the Cursor ID
    v_CreateTableString := 'CREATE TABLE '||newtablename||' AS SELECT * FROM '||TABLENAME; -- Write SQL code to create table
    DBMS_SQL.PARSE(v_CursorID,v_CreateTableString,DBMS_SQL.NATIVE);
         /* Perform syntax error checking */
    v_NumRows := DBMS_SQL.EXECUTE(v_CursorID);
        /* Execute the SQL code  */
    DBMS_SQL.CLOSE_CURSOR(v_CursorID);
END clonare_tabela;

/
DECLARE
OLD_TABLE VARCHAR2(500):='U62';
NEW_TABLE VARCHAR2(500):='Z62';
BEGIN
  clonare_tabela(NEW_TABLE,OLD_TABLE);
end;