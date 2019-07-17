--------------------------------------------------------
--  DDL for Trigger MODIFICARI_CATEGORII
--------------------------------------------------------

  CREATE OR REPLACE TRIGGER "PROIECT"."MODIFICARI_CATEGORII" 
AFTER DELETE ON categorii
for each row
DECLARE
v_id categorii.ID%TYPE:= :OLD.ID;
BEGIN
  delete from CATEGORII_PRODUSE where ID_CATEGORIE=v_id;
end;
/
ALTER TRIGGER "PROIECT"."MODIFICARI_CATEGORII" ENABLE;
