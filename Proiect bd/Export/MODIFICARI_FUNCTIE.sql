--------------------------------------------------------
--  DDL for Trigger MODIFICARI_FUNCTIE
--------------------------------------------------------

  CREATE OR REPLACE TRIGGER "PROIECT"."MODIFICARI_FUNCTIE" 
AFTER DELETE ON functie
for each row
DECLARE
v_id functie.ID%TYPE:= :OLD.ID;
BEGIN
  delete from angajat_functie where ID_FUNCTIE=v_id;
end;
/
ALTER TRIGGER "PROIECT"."MODIFICARI_FUNCTIE" ENABLE;
