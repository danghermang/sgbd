SET linesize 140
SET pagesize 500
clear screen;
SET SERVEROUTPUT ON
DECLARE
  CURSOR catei IS SELECT * FROM example order by doggos desc;
  aux doggo;
BEGIN
  DBMS_OUTPUT.PUT_LINE('ID'||chr(9)||chr(9)||chr(9)||chr(9)||chr(9)||'DOGGERUNIS');
  DBMS_OUTPUT.PUT_LINE('-------------------------------------------');
  FOR I IN CATEI LOOP
    DBMS_OUTPUT.PUT(I.ID||chr(9));
    aux:=i.doggos;
    DBMS_OUTPUT.PUT_LINE(chr(9)||chr(9)||chr(9)||chr(9)||chr(9)||aux.getNume);
  END LOOP;
end;