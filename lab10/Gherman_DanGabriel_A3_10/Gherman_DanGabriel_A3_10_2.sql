/*CREATE OR REPLACE DIRECTORY TEMP_DIR AS 'D:\EXTRACT';
/

grant read, write on directory temp_dir to student;
*/
SET SERVEROUTPUT ON;
DECLARE
  file_buffer VARCHAR(30000);
  FISIER  UTL_FILE.FILE_TYPE;
  CURSOR OBJECTS IS SELECT * FROM USER_OBJECTS WHERE OBJECT_TYPE IN ('TABLE','PROCEDURE','FUNCTION','PACKAGE','VIEW','TRIGGER','INDEX') AND OBJECT_NAME!= 'LISTA' ORDER BY OBJECT_TYPE DESC;
  COUNTER INTEGER ;
BEGIN
  FISIER := UTL_FILE.FOPEN('TEMP_DIR' , 'EXPORT.sql' , 'w');
    FOR LINIE IN objects LOOP
      SELECT DBMS_METADATA.GET_DDL( LINIE.OBJECT_TYPE, LINIE.OBJECT_NAME ) INTO file_buffer FROM DUAL;
      UTL_FILE.PUT_LINE(FISIER,file_buffer,TRUE);
    END LOOP;
  COUNTER := 0;
  FOR LINIE IN (SELECT * FROM ANSWERS) LOOP
     COUNTER := COUNTER + 1 ;
     file_buffer := 'INSERT INTO QUESTIONS VALUES 
     ('||LINIE.ID||','||LINIE.QUESTION_ID||','||LINIE.USER_ID||','||LINIE.SOLVED||','
     ||LINIE.STARTED_AT||','||LINIE.FINISHED_AT||','||LINIE.TIME_TAKEN||','||LINIE.CREATED_AT||','||LINIE.UPDATED_AT||');';
     UTL_FILE.PUT_LINE(FISIER,file_buffer,TRUE);
     EXIT WHEN COUNTER = 100;
  END LOOP;
  COUNTER := 0;
  FOR LINIE IN (SELECT * FROM CHAPTERS) LOOP
      COUNTER := COUNTER + 1 ;
     FILE_BUFFER := 'INSERT INTO CHAPTERS VALUES 
     ('||LINIE.ID||','||LINIE.NAME||','||LINIE.COLOR||','||LINIE.DESCRIPTION||','||LINIE.DISPLAY_ORDER||','||LINIE.CREATED_AT||','||LINIE.UPDATED_AT||');';
     UTL_FILE.PUT_LINE(FISIER,file_buffer,TRUE);
     EXIT WHEN COUNTER = 100;
  END LOOP;
  COUNTER := 0;
  FOR LINIE IN (SELECT * FROM DELETED_QUESTIONS) LOOP
     COUNTER := COUNTER + 1;
     FILE_BUFFER := 'INSERT INTO DELETED_QUESTIONS VALUES 
     ('||LINIE.ID||','||LINIE.CHAPTER_ID||','||LINIE.USER_ID||','||LINIE.DELETED||','||LINIE.CREATED_AT||','||LINIE.UPDATED_AT||');';
     UTL_FILE.PUT_LINE(FISIER,file_buffer,TRUE);
     EXIT WHEN COUNTER = 100;
  END LOOP;
  COUNTER := 0;
  FOR LINIE IN (SELECT * FROM QUESTION_CACHE) LOOP
      COUNTER := COUNTER + 1 ;
     FILE_BUFFER := 'INSERT INTO QUESTION_CACHE VALUES 
     ('||LINIE.ID||','||LINIE.USER_ID||','||LINIE.QUIZ_QUESTION_ID||','||LINIE.QUIZ_CHAPTER_ID||','||LINIE.QUIZ_QUESTION_STARTED_AT||');';
     UTL_FILE.PUT_LINE(FISIER,file_buffer,TRUE);
     EXIT WHEN COUNTER = 100;
  END LOOP;
  COUNTER := 0;
  FOR LINIE IN (SELECT * FROM QUESTIONS) LOOP
      COUNTER := COUNTER + 1 ;
     file_buffer := 'INSERT INTO QUESTIONS VALUES 
     ('||LINIE.ID||','||LINIE.CHAPTER_ID||','||LINIE.USER_ID||','||LINIE.QUESTION||','||LINIE.ANSWER||','
     ||LINIE.ASKED||','||LINIE.SOLVED||','||LINIE.REPORTED||','||LINIE.REPORT_RESOLVED||','||LINIE.CREATED_AT||','||LINIE.UPDATED_AT||');';
     UTL_FILE.PUT_LINE(FISIER,file_buffer,TRUE);
     EXIT WHEN COUNTER = 100;
  END LOOP;
  COUNTER := 0;
  FOR LINIE IN (SELECT * FROM REPORTS) LOOP
      COUNTER := COUNTER + 1 ;
     FILE_BUFFER := 'INSERT INTO REPORTS VALUES 
     ('||LINIE.ID||','||LINIE.QUESTION_ID||','||LINIE.USER_ID||','||LINIE.CREATED_AT||','||LINIE.UPDATED_AT||');';
     UTL_FILE.PUT_LINE(FISIER,file_buffer,TRUE);
     EXIT WHEN COUNTER = 100;
  END LOOP;
  COUNTER := 0;
  FOR LINIE IN (SELECT * FROM USERS) LOOP
     COUNTER := COUNTER + 1 ;
     FILE_BUFFER := 'INSERT INTO USERS VALUES 
     ('||LINIE.ID||','||LINIE.NAME||','||LINIE.USERNAME||','||LINIE.USER_ROLE||','||LINIE.CREATED_AT||','||LINIE.UPDATED_AT||');';
     UTL_FILE.PUT_LINE(FISIER,file_buffer,TRUE);
     EXIT WHEN COUNTER = 100;
  END LOOP;
  UTL_FILE.FCLOSE(FISIER);
END;