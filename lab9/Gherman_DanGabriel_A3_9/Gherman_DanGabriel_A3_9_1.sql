CREATE OR REPLACE procedure CREARE_TABELA_UTILIZATOR(id_ut number) as
      v_CursorID  integer;
      v_CreateTableString  VARCHAR2(500); 
      v_NUMRows  INTEGER; -- Number of rows processed - of no use
      tmpuser VARCHAR2(500);
      tmpputuros INTEGER;
      tmptotal INTEGER;
      tmprelevante INTEGER;
      tmpreptotal INTEGER;
      tmpgresite integer;
 BEGIN
      v_CursorID := DBMS_SQL.OPEN_CURSOR; -- Get the Cursor ID
      v_CreateTableString := 'CREATE TABLE u'||id_ut||'(
           username varchar(500),
           puturos integer,
           intrebari_total integer,
           intrebari_relevante integer,
           report_total integer,
           report_gresite integer)'; -- Write SQL code to create table
      DBMS_SQL.PARSE(v_CursorID,v_CreateTableString,DBMS_SQL.native);
           /* Perform syntax error checking */
      v_NumRows := DBMS_SQL.EXECUTE(v_CursorID);
          /* Execute the SQL code  */
      DBMS_SQL.CLOSE_CURSOR(v_CursorID);
      select username into tmpuser from users where users.id=id_ut;
      
      select lenesi(id_ut) into tmpputuros from dual;
      
      select count(*) into tmptotal from questions where questions.user_id=id_ut;
      
      select count(*) into tmprelevante from questions where questions.user_id=id_ut and reported<5;
     
     select count(*) into tmpreptotal from reports join questions on reports.QUESTION_ID=questions.id where questions.user_id=id_ut;
      
     SELECT count(*) INTO tmpgresite FROM reports JOIN questions ON reports.question_id=questions.ID WHERE reports.user_id=id_ut AND questions.report_resolved=-1;
      
      v_CursorID := DBMS_SQL.OPEN_CURSOR;
      v_CreateTableString := 'insert into u'||id_ut||' VALUES(:q1,:q2,:q3,:q4,:q5,:q6)'; 
      DBMS_SQL.PARSE(v_CursorID,v_CreateTableString,DBMS_SQL.V7);
      DBMS_SQL.BIND_VARIABLE(v_CursorID, ':q1',tmpuser);
      DBMS_SQL.BIND_VARIABLE(v_CursorID, ':q2',tmpputuros);
      DBMS_SQL.BIND_VARIABLE(v_CursorID, ':q3',tmptotal);
      DBMS_SQL.BIND_VARIABLE(v_CursorID, ':q4',tmprelevante);
      DBMS_SQL.BIND_VARIABLE(v_CursorID, ':q5',tmpreptotal);
      DBMS_SQL.BIND_VARIABLE(v_CursorID, ':q6',tmpgresite);
      
           /* Perform syntax error checking */
      v_NumRows := DBMS_SQL.EXECUTE(v_CursorID);
      DBMS_SQL.CLOSE_CURSOR(v_CursorID); -- Close the cursor
 END CREARE_TABELA_UTILIZATOR; -- End PL/SQL block
/
CREATE OR REPLACE procedure STERGERE_TABELA_UTILIZATOR(id_ut users.id%type) as
      v_CursorID  NUMBER;
      v_CreateTableString  VARCHAR2(500); 
      v_NUMRows  INTEGER; -- Number of rows processed - of no use
 BEGIN
      v_CursorID := DBMS_SQL.OPEN_CURSOR; -- Get the Cursor ID
      v_CreateTableString := 'DROP TABLE u'||id_ut; -- Write SQL code to create table
      DBMS_SQL.PARSE(v_CursorID,v_CreateTableString,DBMS_SQL.V7);
           /* Perform syntax error checking */
      v_NumRows := DBMS_SQL.EXECUTE(v_CursorID);
      DBMS_SQL.CLOSE_CURSOR(v_CursorID); -- Close the cursor
 END STERGERE_TABELA_UTILIZATOR; -- End PL/SQL block
/

/*DECLARE
CURSOR studenti_rai IS SELECT user_ID FROM
(SELECT user_id FROM reports 
      GROUP BY user_ID
        ORDER BY count(*) DESC) 
  WHERE ROWNUM <=10;
begin
  FOR stud IN studenti_rai loop
    --STERGERE_TABELA_UTILIZATOR(stud.user_id);
    CREARE_TABELA_UTILIZATOR(stud.user_id);
  END loop;
end;*/