--------------------------------------------------------
--  DDL for Trigger MODIFICARI_MAGAZIN
--------------------------------------------------------

  CREATE OR REPLACE TRIGGER "PROIECT"."MODIFICARI_MAGAZIN" 
AFTER DELETE ON magazin
for each row
DECLARE
v_id magazin.ID%TYPE:= :OLD.ID;
BEGIN
  delete from angajati_magazin where ID_MAGAZIN=v_id;
end;
/
ALTER TRIGGER "PROIECT"."MODIFICARI_MAGAZIN" ENABLE;
