--------------------------------------------------------
--  DDL for Function NUMAR_COMENZI
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "PROIECT"."NUMAR_COMENZI" (user_id users.ID%TYPE) RETURN NUMBER AS
numberof NUMBER:=0;
cursor curs_comenzi is select * from comenzi where user_id=comenzi.id_user;
BEGIN
 FOR linie IN curs_comenzi loop
  numberof:= numberof+1;
 end loop;
  return numberof;
END numar_Comenzi;

/
