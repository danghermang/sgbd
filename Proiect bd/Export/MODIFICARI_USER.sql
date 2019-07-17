--------------------------------------------------------
--  DDL for Trigger MODIFICARI_USER
--------------------------------------------------------

  CREATE OR REPLACE TRIGGER "PROIECT"."MODIFICARI_USER" 
AFTER DELETE ON users
for each row
DECLARE
v_id users.id%type:= :old.id;
BEGIN

delete from comenzi where id_user=v_id;
end;
/
ALTER TRIGGER "PROIECT"."MODIFICARI_USER" ENABLE;
