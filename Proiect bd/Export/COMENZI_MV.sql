--------------------------------------------------------
--  DDL for Materialized View COMENZI_MV
--------------------------------------------------------

  CREATE MATERIALIZED VIEW "PROIECT"."COMENZI_MV" ("DATA_COMENZII", "ID_PRODUS", "ID_ANGAJAT", "ID", "DATA_LIVRARE", "ADRESS", "ID_USER")
  ORGANIZATION HEAP PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SYSTEM" 
  BUILD IMMEDIATE
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SYSTEM" 
  REFRESH FORCE ON DEMAND
  WITH PRIMARY KEY USING DEFAULT LOCAL ROLLBACK SEGMENT
  USING ENFORCED CONSTRAINTS FOR UPDATE DISABLE QUERY REWRITE
  AS SELECT "COMENZI"."DATA_COMENZII" "DATA_COMENZII","COMENZI"."ID_PRODUS" "ID_PRODUS","COMENZI"."ID_ANGAJAT" "ID_ANGAJAT","COMENZI"."ID" "ID","COMENZI"."DATA_LIVRARE" "DATA_LIVRARE","COMENZI"."ADRESS" "ADRESS","COMENZI"."ID_USER" "ID_USER" FROM "COMENZI" "COMENZI";

   COMMENT ON MATERIALIZED VIEW "PROIECT"."COMENZI_MV"  IS 'snapshot table for snapshot PROIECT.COMENZI_MV';
