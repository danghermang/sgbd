--------------------------------------------------------
--  DDL for Procedure EXPORT_DB
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "PROIECT"."EXPORT_DB" AS
  file_buffer VARCHAR(30000);
  FISIER  UTL_FILE.FILE_TYPE;
  CURSOR OBJECTS IS SELECT * FROM USER_OBJECTS WHERE OBJECT_TYPE IN ('TABLE','PROCEDURE','FUNCTION','PACKAGE','VIEW','TRIGGER','INDEX') AND OBJECT_NAME!= 'LISTA' ORDER BY OBJECT_TYPE DESC;
  counter number;
BEGIN
  FISIER := UTL_FILE.FOPEN('TEMP_DIR' , 'EXPORT_PROIECT.sql' , 'w');
    FOR LINIE IN objects LOOP
      SELECT DBMS_METADATA.GET_DDL( LINIE.OBJECT_TYPE, LINIE.OBJECT_NAME ) INTO file_buffer FROM DUAL;
      UTL_FILE.PUT_LINE(FISIER,file_buffer,TRUE);
    END LOOP;
    
  counter:=0;
  FOR LINIE IN (SELECT * FROM ANGAJAT) LOOP
      counter:=counter+1;
     file_buffer := 'INSERT INTO ANGAJAT VALUES 
     ('||LINIE.NUME||','||LINIE.PRENUME||','||LINIE.MAIL||','||LINIE.ID||','
     ||LINIE.ORA_VENIRE||','||LINIE.ORA_PLECARE||','||LINIE.BONUS||');';
     UTL_FILE.PUT_LINE(FISIER,file_buffer,TRUE);
     exit when counter=50;
  END LOOP;
  
  counter:=0;
  FOR LINIE IN (SELECT * FROM ANGAJAT_FUNCTIE) LOOP
  counter:=counter+1;
     FILE_BUFFER := 'INSERT INTO ANGAJAT_FUNCTIE VALUES 
     ('||LINIE.ID_ANGAJAT||','||LINIE.ID_FUNCTIE||');';
     UTL_FILE.PUT_LINE(FISIER,file_buffer,TRUE);
     exit when counter=50;
  END LOOP;
  
  counter:=0;
  FOR LINIE IN (SELECT * FROM ANGAJATI_MAGAZIN) LOOP
  counter:=counter+1;
     FILE_BUFFER := 'INSERT INTO ANGAJATI_MAGAZIN VALUES 
     ('||LINIE.ID_ANGAJAT||','||LINIE.ID_MAGAZIN||');';
     UTL_FILE.PUT_LINE(FISIER,file_buffer,TRUE);
     exit when counter=50;
  END LOOP;
  
  counter:=0;
  FOR LINIE IN (SELECT * FROM CATEGORII) LOOP
  counter:=counter+1;
     FILE_BUFFER := 'INSERT INTO CATEGORII VALUES 
     ('||LINIE.NUME||','||LINIE.ID||');';
     UTL_FILE.PUT_LINE(FISIER,file_buffer,TRUE);
     exit when counter=50;
  END LOOP;
  
  counter:=0;
  FOR LINIE IN (SELECT * FROM CATEGORII_PRODUSE) LOOP
  counter:=counter+1;
     file_buffer := 'INSERT INTO CATEGORII_PRODUSE VALUES 
     ('||LINIE.ID_CATEGORIE||','||LINIE.ID_PRODUS||');';
     UTL_FILE.PUT_LINE(FISIER,file_buffer,TRUE);
     exit when counter=50;
  END LOOP;
  
  counter:=0;
  FOR LINIE IN (SELECT * FROM COMENZI) LOOP
  counter:=counter+1;
     FILE_BUFFER := 'INSERT INTO COMENZI VALUES 
     ('||LINIE.DATA_COMENZII||','||LINIE.ID_PRODUS||','||LINIE.ID_ANGAJAT||','||LINIE.ID||','||LINIE.DATA_LIVRARE||','||LINIE.ADRESS||','||LINIE.ID_USER||');';
     UTL_FILE.PUT_LINE(FISIER,file_buffer,TRUE);
     exit when counter=50;
  END LOOP;
  
  counter:=0;
  FOR LINIE IN (SELECT * FROM FUNCTIE) LOOP
  counter:=counter+1;
     FILE_BUFFER := 'INSERT INTO FUNCTIE VALUES 
     ('||LINIE.NUME||','||LINIE.ID||','||LINIE.SALAR||');';
     UTL_FILE.PUT_LINE(FISIER,file_buffer,TRUE);
     exit when counter=50;
  END LOOP;
  
 counter:=0;
  FOR LINIE IN (SELECT * FROM MAGAZIN) LOOP
  counter:=counter+1;
     FILE_BUFFER := 'INSERT INTO MAGAZIN VALUES 
     ('||LINIE.NUME||','||LINIE.ID||','||LINIE.LOCATIE||');';
     UTL_FILE.PUT_LINE(FISIER,file_buffer,TRUE);
     exit when counter=50;
  END LOOP;
  
  counter:=0;
  FOR LINIE IN (SELECT * FROM PRODUSE) LOOP
  counter:=counter+1;
     FILE_BUFFER := 'INSERT INTO PRODUSE VALUES 
     ('||LINIE.NUME||','||LINIE.ID||','||LINIE.PRET||','||LINIE.RATING||','||LINIE.OFERTA||','||LINIE.NUMBEROF||');';
     UTL_FILE.PUT_LINE(FISIER,file_buffer,TRUE);
     exit when counter=50;
  END LOOP;
  
  counter:=0;
  FOR LINIE IN (SELECT * FROM USERS) LOOP
  counter:=counter+1;
     FILE_BUFFER := 'INSERT INTO USERS VALUES 
     ('||LINIE.NUME||','||LINIE.PRENUME||','||LINIE.MAIL||','||LINIE.ID||','||LINIE.data_nastere||','||LINIE.adresa||');';
     UTL_FILE.PUT_LINE(FISIER,file_buffer,TRUE);
     exit when counter=50;
  END LOOP;
  
  UTL_FILE.FCLOSE(FISIER);
END EXPORT_DB;

/
