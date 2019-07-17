set serveroutput on;
CREATE OR REPLACE procedure afisare_TABELA_UTILIZATOR(id_ut users.id%type) as
      v_CursorID  NUMBER;
      v_SelectRecords  VARCHAR2(500); 
      v_NUMRows  INTEGER; -- Number of rows processed - of no use
      username1 VARCHAR(500);
      puturos1 INTEGER;
      intrebari_total1 INTEGER;
      intrebari_relevante1 INTEGER;
      report_total1 INTEGER;
      report_gresite1 integer;
 BEGIN
       v_SelectRecords := 'SELECT * from u'||id_ut; -- SQL to view records

      DBMS_SQL.PARSE(v_CursorID,v_SelectRecords,DBMS_SQL.native);
           /* Perform syntax error checking */
      --DBMS_SQL.BIND_VARIABLE(v_CursorID, ':ID_UT',id_ut);

      DBMS_SQL.DEFINE_COLUMN(v_CursorID,1,username1,500);
      DBMS_SQL.DEFINE_COLUMN(v_CursorID,2,puturos1);
      DBMS_SQL.DEFINE_COLUMN(v_CursorID,3,intrebari_total1);
      DBMS_SQL.DEFINE_COLUMN(v_CursorID,4,intrebari_relevante1);
      DBMS_SQL.DEFINE_COLUMN(v_CursorID,5,report_total1);
      DBMS_SQL.DEFINE_COLUMN(v_CursorID,6,report_gresite1);
      v_NumRows := DBMS_SQL.EXECUTE(v_CursorID);
           /* Execute the SQL code  */
      LOOP
      IF DBMS_SQL.FETCH_ROWS(v_CursorID) = 0 THEN
           EXIT;
      END IF;

      DBMS_SQL.COLUMN_VALUE(v_CursorID,1,username1);
      DBMS_SQL.COLUMN_VALUE(v_CursorID,2,puturos1);
      DBMS_SQL.COLUMN_VALUE(v_CursorID,3,intrebari_total1);
      DBMS_SQL.COLUMN_VALUE(v_CursorID,4,intrebari_relevante1);
      DBMS_SQL.COLUMN_VALUE(v_CursorID,5,report_total1);
      DBMS_SQL.COLUMN_VALUE(v_CursorID,6,report_gresite1);
      DBMS_OUTPUT.PUT_LINE(username1 || ' ' || puturos1 || ' ' || intrebari_total1 || ' ' || intrebari_relevante1 || ' ' || report_total1 || ' ' || report_gresite1);

 END LOOP;
    EXCEPTION
      WHEN OTHERS THEN
                      RAISE;
    DBMS_SQL.CLOSE_CURSOR(v_CursorID); 
 END afisare_TABELA_UTILIZATOR; 