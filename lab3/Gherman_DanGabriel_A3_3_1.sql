/* Construiti o tabela cu utilizatori avand urmatoarele campuri: 
ID (pk), nume, prenume, data nastere, telefon(unic), adresa email (unica). 
Creati un script care sa populeze tabela de mai sus plecand de la o 
multime de informatii a?ate intr-o alta baza de date. 
Astfel: plecand de la tabela users (cea din baza de date importata in lab1), 
generati o tabela care sa contina nume si prenume valide 
(Unele prenume trebuie sa ?e formate din doua cuvinte Vasile Ionut. 
Tinand cont ca prenumele fetelor se termina cu litera a, 
aveti grija sa nu asociati un prenume de baiat cu unul al unei fete in noua tabela). 
Data de nastere sa ?e generata aleator in intervalul unui aceluiasi an (1997).
*/
set SERVEROUTPUT ON;
drop table TABELA2;
CREATE TABLE TABELA2(
TABLE_ID NUMBER(15),
NUME VARCHAR(200) not null,
PRENUME VARCHAR(200) not null,
DATA_NASTERE DATE not null,
TELEFON VARCHAR(200) not null,
EMAIL VARCHAR(200) not null
);

ALTER TABLE TABELA2
ADD CONSTRAINT PK PRIMARY KEY(TABLE_ID);
ALTER TABLE TABELA2
ADD CONSTRAINT UNIQUE_FIELDS UNIQUE (TELEFON,EMAIL);
ALTER TABLE TABELA2
ADD CONSTRAINT CORRECT_YEAR CHECK (TO_CHAR(DATA_NASTERE,'YYYY') ='1997');
/*ALTER TABLE TABELA2
ADD CONSTRAINT CORRECT_MAIL CHECK (EMAIL LIKE '%@%\.%');*/
ALTER TABLE TABELA2
ADD CONSTRAINT CORRECT_PHONE CHECK(trim(translate(TELEFON,'x+1234567890','x'))=NULL );

DECLARE
temp_username USERS.NAME%TYPE;
temp_prenume2 tabela2.prenume%TYPE;
temp_prenume tabela2.prenume%TYPE;
temp_nume TABELA2.NUME%TYPE;
temp_id NUMBER;
temp_telefon tabela2.telefon%type;
temp_data tabela2.data_nastere%type;
temp_email tabela2.email%TYPE;

BEGIN
FOR i IN 1..600 LOOP
  SELECT upper(substr(username,instr(username,'.')+1, length(username))) into temp_nume from (select * from users u order by dbms_random.value) where rownum=1;
  SELECT upper(substr(username,0,instr(username,'.')-1)) into temp_prenume from (select * from users u order by dbms_random.value) where rownum=1;
  temp_id:=i;
  temp_telefon:='07'||trunc(dbms_random.value(1000000000,9999999999));
  temp_email:= lower(temp_prenume)||'.'||lower(temp_nume)||temp_id||'@gmail.com';
  temp_data:= TO_DATE (TRUNC(DBMS_RANDOM.VALUE (2450450, 2450814)),'J');
  if(trunc(dbms_random.value(0,100))<=50) THEN
  SELECT upper(substr(username,0,instr(username,'.')-1)) into temp_prenume2 from (select * from users u order by dbms_random.value) where rownum=1;
    IF(TRIM(temp_prenume) like '%A' and trim(temp_prenume2) like '%A' or TRIM(temp_prenume) not like '%A' and trim(temp_prenume2) not like '%A') then
      temp_prenume:= temp_prenume||'-'||temp_prenume2;
    end if;
  END IF;
  if(temp_prenume is null) then
    SELECT upper(substr(username,0,instr(username,'.')-1)) into temp_prenume from (select * from users u order by dbms_random.value) where rownum=1;
  end if;
  INSERT INTO TABELA2(TABLE_ID,NUME,PRENUME,DATA_NASTERE,TELEFON,EMAIL)
    VALUES(temp_id,temp_nume,temp_prenume,temp_data,temp_telefon,temp_email);
END LOOP;
END;
