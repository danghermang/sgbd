--------------------------------------------------------
--  Ref Constraints for Table ANGAJATI_MAGAZIN
--------------------------------------------------------

  ALTER TABLE "PROIECT"."ANGAJATI_MAGAZIN" ADD CONSTRAINT "ANGAJATI_MAGAZIN_FK1" FOREIGN KEY ("ID_ANGAJAT")
	  REFERENCES "PROIECT"."ANGAJAT" ("ID") ON DELETE CASCADE ENABLE;
  ALTER TABLE "PROIECT"."ANGAJATI_MAGAZIN" ADD CONSTRAINT "ANGAJATI_MAGAZIN_FK2" FOREIGN KEY ("ID_MAGAZIN")
	  REFERENCES "PROIECT"."MAGAZIN" ("ID") ON DELETE CASCADE ENABLE;
