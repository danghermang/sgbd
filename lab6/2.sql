set serveroutput on;
GRANT CREATE TYPE TO STUDENT; 

/*CREATE OR REPLACE TYPE lista_prenume AS TABLE OF VARCHAR2(10);
/
CREATE TABLE persoane (nume varchar2(10), 
       prenume lista_prenume)
       NESTED TABLE prenume STORE AS lista;
/       

--INSERT INTO persoane VALUES('Popescu', lista_prenume('Ionut', 'Razvan'));
--INSERT INTO persoane VALUES('Ionescu', lista_prenume('Elena', 'Madalina'));
--INSERT INTO persoane VALUES('Rizea', lista_prenume('Mircea', 'Catalin'));

/*/
--INSERT INTO persoane VALUES('Gherman', lista_prenume('Mihai', 'uuu'));
declare
cursor linie is select nume,prenume from persoane;
name persoane.nume%type;
surname persoane.prenume%type;
name2 varchar2(200);
counter number:=0;
checky number :=0;
begin
open linie;
dbms_output.put_line('Studenti cu u in prenume:');
loop
  name2:='';
  checky:=0;
  fetch linie into name,surname;
  exit when linie%NOTFOUND;
  for iterator in surname.first..surname.last loop 
    name2:=concat(name2,concat(' ',surname(iterator)));
    if(surname(iterator) like '%u%')
      then checky:=1;
    end if;
  end loop;
  if checky =1 then 
    counter:=counter+1;
    dbms_output.put_line(name||name2);
  end if;
END LOOP;
dbms_output.put_line('Numarul de studenti este: '||counter);
end;

