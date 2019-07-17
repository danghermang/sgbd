DECLARE
   statementz VARCHAR2(300);
   executa INTEGER;
   CURSOR_ID INTEGER;
   CURSOR user_obj is select * FROM USER_objects;
BEGIN
   FOR linie IN user_obj LOOP
    statementz := 'DROP '||linie.object_type||' '||linie.object_name; 
    cursor_id := DBMS_SQL.OPEN_CURSOR;
    DBMS_SQL.PARSE(cursor_id, statementz, dbms_sql.native);  
    executa := dbms_sql.execute(cursor_id);
    END LOOP;
   DBMS_SQL.CLOSE_CURSOR(cursor_id);
END;

