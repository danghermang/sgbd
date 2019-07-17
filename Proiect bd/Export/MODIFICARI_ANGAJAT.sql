--------------------------------------------------------
--  DDL for Trigger MODIFICARI_ANGAJAT
--------------------------------------------------------

  CREATE OR REPLACE TRIGGER "PROIECT"."MODIFICARI_ANGAJAT" 
AFTER DELETE ON angajat
for each row
declare
v_id angajat.id%type:= :old.id;
BEGIN

DELETE FROM ANGAJAT_FUNCTIE WHERE ID_ANGAJAT=v_id;
DELETE FROM angajati_magazin WHERE id_angajat=v_id;
update comenzi set ID_ANGAJAT=null where id_angajat=v_id;
end;
/
ALTER TRIGGER "PROIECT"."MODIFICARI_ANGAJAT" ENABLE;
