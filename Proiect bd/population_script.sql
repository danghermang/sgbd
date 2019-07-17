SET SERVEROUTPUT ON;
DECLARE
    F UTL_FILE.FILE_TYPE;
    V_LINE VARCHAR2(50);
    USER_ID INT;
    NUME VARCHAR2 (20);
    PRENUME VARCHAR2 (25);
    EMAIL VARCHAR2(30);
    DATA_NASTERE VARCHAR2(30);
    ADRESA VARCHAR2(30);
  BEGIN
    F := UTL_FILE.FOPEN ('D:\Proiect bd', 'USERS_DATA.csv', 'R');
    IF UTL_FILE.IS_OPEN(F) THEN
    LOOP
      BEGIN
      UTL_FILE.GET_LINE(F, V_LINE, 1000);
      IF V_LINE IS NULL THEN
        EXIT;
      END IF;
        USER_ID := REGEXP_SUBSTR(V_LINE, '[^,]+', 1, 1);
        NUME := REGEXP_SUBSTR(V_LINE, '[^,]+', 1, 2);
        PRENUME := REGEXP_SUBSTR(V_LINE, '[^,]+', 1, 3);
        EMAIL := REGEXP_SUBSTR(V_LINE, '[^,]+', 1, 4);
        DATA_NASTERE := REGEXP_SUBSTR(V_LINE, '[^,]+', 1, 5);
        ADRESA := REGEXP_SUBSTR(V_LINE, '[^,]+', 1, 6);
        INSERT INTO USERS VALUES(USER_ID, NUME, PRENUME, EMAIL, DATA_NASTERE, ADRESA);
        COMMIT;
        EXCEPTION
        WHEN NO_DATA_FOUND THEN
          EXIT;
        END;
  END LOOP;
  END IF;
  UTL_FILE.FCLOSE(F);
END;