--------------------------------------------------------
--  Ref Constraints for Table FUNCTIE
--------------------------------------------------------

  ALTER TABLE "PROIECT"."FUNCTIE" ADD CONSTRAINT "FUNCTIE_FK1" FOREIGN KEY ("ID")
	  REFERENCES "PROIECT"."ANGAJAT" ("ID") ON DELETE CASCADE ENABLE;
