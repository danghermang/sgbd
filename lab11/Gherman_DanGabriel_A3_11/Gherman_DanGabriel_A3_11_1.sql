CREATE OR REPLACE PROCEDURE REFACERE_MEDII AS
  CURSOR STUDENTI_INTEGRALISTI_1 IS SELECT studenti.nume,AVG(NOTE.VALOARE) MEDIE ,studenti.nr_matricol 
                                      FROM STUDENTI JOIN NOTE ON STUDENTI.NR_MATRICOL=NOTE.NR_MATRICOL JOIN CURSURI ON CURSURI.ID_CURS=NOTE.ID_CURS
                                        WHERE STUDENTI.AN=1
                                          GROUP BY STUDENTI.NUME,studenti.bursa,studenti.nr_matricol
                                            HAVING MIN(NOTE.VALOARE)>=5
                                              ORDER BY AVG(NOTE.VALOARE) DESC;
  CURSOR STUDENTI_INTEGRALISTI_2 IS SELECT studenti.nume,AVG(NOTE.VALOARE) MEDIE ,studenti.nr_matricol 
                                      FROM STUDENTI JOIN NOTE ON STUDENTI.NR_MATRICOL=NOTE.NR_MATRICOL JOIN CURSURI ON CURSURI.ID_CURS=NOTE.ID_CURS
                                        WHERE STUDENTI.AN=2
                                          GROUP BY STUDENTI.NUME,studenti.bursa,studenti.nr_matricol
                                            HAVING MIN(NOTE.VALOARE)>=5
                                              ORDER BY AVG(NOTE.VALOARE) DESC;
  CURSOR STUDENTI_INTEGRALISTI_3 IS SELECT studenti.nume,AVG(NOTE.VALOARE) MEDIE ,studenti.nr_matricol 
                                      FROM STUDENTI JOIN NOTE ON STUDENTI.NR_MATRICOL=NOTE.NR_MATRICOL JOIN CURSURI ON CURSURI.ID_CURS=NOTE.ID_CURS
                                        WHERE STUDENTI.AN=3
                                          GROUP BY STUDENTI.NUME,studenti.bursa,studenti.nr_matricol
                                            HAVING MIN(NOTE.VALOARE)>=5
                                              ORDER BY AVG(NOTE.VALOARE) DESC;
  CURSOR STUDENTI_TOTI IS SELECT * FROM STUDENTI;
  BURSA_AN_1 NUMBER :=1000/3;
  BURSA_AN_2 NUMBER :=1000/3;
  BURSA_AN_3 NUMBER :=1000/3;
  COUNTER_AN_1 NUMBER:=0;
  MEDIE_MAX_AN_1 NUMBER:=0;
  COUNTER_AN_2 NUMBER:=0;
  MEDIE_MAX_AN_2 NUMBER:=0;
  COUNTER_AN_3 NUMBER:=0;
  medie_max_an_3 number:=0;
BEGIN
  FOR LINIE IN STUDENTI_TOTI LOOP
    UPDATE STUDENTI
      set bursa=null;
  END LOOP;
  
  FOR LINIE IN STUDENTI_INTEGRALISTI_1 LOOP
    IF LINIE.MEDIE>MEDIE_MAX_an_1 THEN 
      COUNTER_AN_1:=1;
      MEDIE_MAX_AN_1:=LINIE.MEDIE;
    ELSIF LINIE.MEDIE=MEDIE_MAX_AN_1 THEN
      counter_an_1:=counter_an_1+1;
    end if;
  END LOOP;
  
  FOR LINIE IN STUDENTI_INTEGRALISTI_2 LOOP
    IF LINIE.MEDIE>MEDIE_MAX_an_2 THEN 
      COUNTER_AN_2:=1;
      MEDIE_MAX_AN_2:=LINIE.MEDIE;
    ELSIF LINIE.MEDIE=MEDIE_MAX_AN_2 THEN
      counter_an_2:=counter_an_2+1;
    END IF;
  END LOOP;
  
  FOR LINIE IN STUDENTI_INTEGRALISTI_3 LOOP
    IF LINIE.MEDIE>MEDIE_MAX_an_3 THEN 
      COUNTER_AN_3:=1;
      MEDIE_MAX_AN_3:=LINIE.MEDIE;
    ELSIF LINIE.MEDIE=MEDIE_MAX_AN_3 THEN
      counter_an_3:=counter_an_3+1;
    END IF;
  END LOOP;
  
  IF COUNTER_AN_1=0 AND COUNTER_AN_2=0 AND COUNTER_AN_3=0 THEN 
    
    BURSA_AN_1:=0; BURSA_AN_2:=0; BURSA_AN_3:=0;
    
  ELSE
  
      IF COUNTER_AN_1 = 0 THEN 
        IF COUNTER_AN_2=0 THEN BURSA_AN_3:=BURSA_AN_1+BURSA_AN_2+BURSA_AN_3;
          ELSIF COUNTER_AN_3=0 THEN BURSA_AN_2:=BURSA_AN_1+BURSA_AN_2+BURSA_AN_3;
        else
        BURSA_AN_2:=BURSA_AN_2+BURSA_AN_1/2;
        BURSA_AN_3:=BURSA_AN_3+BURSA_AN_1/2;
        END IF;
        bursa_an_1:=0;
      end if;
      
      IF COUNTER_AN_2 = 0 THEN 
        IF COUNTER_AN_1=0 THEN BURSA_AN_3:=BURSA_AN_1+BURSA_AN_2+BURSA_AN_3;
          ELSIF COUNTER_AN_3=0 THEN BURSA_AN_1:=BURSA_AN_1+BURSA_AN_2+BURSA_AN_3;
        else
          BURSA_AN_1:=BURSA_AN_1+BURSA_AN_2/2;
          BURSA_AN_3:=BURSA_AN_3+BURSA_AN_2/2;
        END IF;
         bursa_an_2:=0;
      end if;
      
      IF COUNTER_AN_3 = 0 THEN 
        IF COUNTER_AN_1=0 THEN BURSA_AN_2:=BURSA_AN_1+BURSA_AN_2+BURSA_AN_3;
          ELSIF COUNTER_AN_2=0 THEN BURSA_AN_1:=BURSA_AN_1+BURSA_AN_2+BURSA_AN_3;
        else
          BURSA_AN_1:=BURSA_AN_1+BURSA_AN_3/2;
          BURSA_AN_2:=BURSA_AN_2+BURSA_AN_3/2;
        END IF;
         bursa_an_3:=0;
      END IF;
      
      IF BURSA_AN_1!=0 THEN
        FOR LINIE IN STUDENTI_INTEGRALISTI_1 LOOP
          IF LINIE.MEDIE=MEDIE_MAX_AN_1 THEN
            UPDATE STUDENTI
              SET BURSA=BURSA_AN_1/COUNTER_AN_1
            where nr_matricol=linie.nr_matricol;
          end if;
        end loop;
      END IF;
      
      IF BURSA_AN_2!=0 THEN
        FOR LINIE IN STUDENTI_INTEGRALISTI_2 LOOP
          IF LINIE.MEDIE=MEDIE_MAX_AN_2 THEN
            UPDATE STUDENTI
              SET BURSA=BURSA_AN_2/COUNTER_AN_2
            where nr_matricol=linie.nr_matricol;
          end if;
        end loop;
      end if;
      
      IF BURSA_AN_3!=0 THEN
        FOR LINIE IN STUDENTI_INTEGRALISTI_3 LOOP
          IF LINIE.MEDIE=MEDIE_MAX_AN_3 THEN
            UPDATE STUDENTI
              SET BURSA=BURSA_AN_3/COUNTER_AN_3
            where nr_matricol=linie.nr_matricol;
          end if;
        END LOOP;
      end if;
  end if;
END;
/
CREATE OR REPLACE TRIGGER RECALCULARE_MEDII_1
AFTER DELETE OR INSERT ON STUDENTI
BEGIN
  refacere_medii();
END;
/
CREATE OR REPLACE TRIGGER RECALCULARE_MEDII_2
AFTER DELETE OR INSERT ON NOTE
BEGIN
  refacere_medii();
END;
/
CREATE OR REPLACE TRIGGER RECALCULARE_MEDII_3
AFTER DELETE OR INSERT ON CURSURI
BEGIN
  refacere_medii();
END;
--INSERT INTO NOTE VALUES ('120', '21',  7, TO_DATE('18/02/2015', 'dd/mm/yyyy'));
DELETE FROM NOTE WHERE NR_MATRICOL=120 AND VALOARE=7 AND ID_CURS=21;