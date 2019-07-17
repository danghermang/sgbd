CREATE OR REPLACE PROCEDURE creare_intrebari_promotie(id_question questions.ID%TYPE) AS
USERNAME VARCHAR2(500);
raspunsuri INTEGER;
raspunsuri_corecte INTEGER;
data_postarii date;
v_CursorID  integer;
v_CreateTableString  VARCHAR2(500); 
v_NUMRows  INTEGER; -- Number of rows processed - of no use
BEGIN
  SELECT users.username INTO username FROM questions JOIN users ON questions.user_id=users.ID WHERE questions.ID=id_question;
  SELECT asked INTO raspunsuri FROM questions WHERE questions.ID=id_question;
  SELECT solved INTO raspunsuri_corecte FROM questions WHERE questions.ID=id_question;
  SELECT created_at INTO data_postarii FROM questions WHERE questions.ID=id_question;
    v_CursorID := DBMS_SQL.OPEN_CURSOR; -- Get the Cursor ID
    v_CreateTableString := 'CREATE TABLE intrebare_'||id_question||'(
         username varchar(500),
         raspunsuri integer,
         raspunsuri_corecte integer,
         data_postarii date)'; -- Write SQL code to create table
    DBMS_SQL.PARSE(v_CursorID,v_CreateTableString,DBMS_SQL.native);
         /* Perform syntax error checking */
    v_NumRows := DBMS_SQL.EXECUTE(v_CursorID);
        /* Execute the SQL code  */
    DBMS_SQL.CLOSE_CURSOR(v_CursorID);
   
    v_CursorID := DBMS_SQL.OPEN_CURSOR;
    v_CreateTableString := 'insert into intrebare_'||id_question||' VALUES(:q1,:q2,:q3,:q4)'; 
    DBMS_SQL.PARSE(v_CursorID,v_CreateTableString,DBMS_SQL.V7);
    DBMS_SQL.BIND_VARIABLE(v_CursorID, ':q1',username);
    DBMS_SQL.BIND_VARIABLE(v_CursorID, ':q2',raspunsuri);
    DBMS_SQL.BIND_VARIABLE(v_CursorID, ':q3',raspunsuri_corecte);
    DBMS_SQL.BIND_VARIABLE(v_CursorID, ':q4',data_postarii);
    
         /* Perform syntax error checking */
    v_NumRows := DBMS_SQL.EXECUTE(v_CursorID);
    DBMS_SQL.CLOSE_CURSOR(v_CursorID); -- Close the cursor
END creare_intrebari_promotie;

/
cREATE OR REPLACE PROCEDURE stergere_intrebari_promotie(id_question questions.ID%TYPE) AS
USERNAME VARCHAR2(500);
raspunsuri INTEGER;
raspunsuri_corecte INTEGER;
data_postarii date;
v_CursorID  integer;
v_CreateTableString  VARCHAR2(500); 
v_NUMRows  INTEGER; -- Number of rows processed - of no use
BEGIN
  SELECT users.username INTO username FROM questions JOIN users ON questions.user_id=users.ID WHERE questions.ID=id_question;
  SELECT asked INTO raspunsuri FROM questions WHERE questions.ID=id_question;
  SELECT solved INTO raspunsuri_corecte FROM questions WHERE questions.ID=id_question;
  SELECT created_at INTO data_postarii FROM questions WHERE questions.ID=id_question;
    v_CursorID := DBMS_SQL.OPEN_CURSOR; -- Get the Cursor ID
    v_CreateTableString := 'drop TABLE INTREBARE_'||'id_question'; -- Write SQL code to create table
    DBMS_SQL.PARSE(v_CursorID,v_CreateTableString,DBMS_SQL.native);
         /* Perform syntax error checking */
    v_NumRows := DBMS_SQL.EXECUTE(v_CursorID);
        /* Execute the SQL code  */
    DBMS_SQL.CLOSE_CURSOR(v_CursorID);
    EXCEPTION
   WHEN OTHERS THEN
      IF SQLCODE != -942 THEN
         RAISE;
      END IF;
END stergere_intrebari_promotie;
/

DECLARE
CURSOR intrebari IS SELECT id FROM questions WHERE created_at>=to_date('15-01-2017','DD-MM-YYYY') AND reported>=5;
BEGIN
  FOR intrebare IN intrebari loop
    creare_intrebari_promotie(intrebare.id);
  end loop;
end;