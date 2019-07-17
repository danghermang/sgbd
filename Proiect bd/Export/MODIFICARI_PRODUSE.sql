--------------------------------------------------------
--  DDL for Trigger MODIFICARI_PRODUSE
--------------------------------------------------------

  CREATE OR REPLACE TRIGGER "PROIECT"."MODIFICARI_PRODUSE" 
AFTER DELETE ON produse
for each row
DECLARE
v_id produse.ID%TYPE:= :OLD.ID;
BEGIN
  delete from CATEGORII_PRODUSE where ID_PRODUS=v_id;
end;
/
ALTER TRIGGER "PROIECT"."MODIFICARI_PRODUSE" ENABLE;
