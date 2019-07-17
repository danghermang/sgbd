set serveroutput on;
accept nume prompt 'Introduceti numele cautat: ';
DECLARE
   secventa users.name%type := '&nume';
   new_id users.id%type;
   nume_familie users.name%type;
   prenume users.name%type;
   nr_intrebari number;
   nr_studenti number;
   random_nr number;
BEGIN
    select count(*) into nr_studenti from users u where instr(trim(lower(u.name)),trim(lower(secventa)))!=0
        order by u.id asc; 
    random_nr:=round(DBMS_RANDOM.VALUE(1,nr_studenti));  
    select y.id into new_id from 
    (select * from(
      select * from users u where instr(trim(lower(u.name)),trim(lower(secventa)))!=0 
        order by u.id asc) x where rownum<=random_nr
          order by x.id desc) y where rownum=1;
    select initcap(substr(u.name, 1,instr(u.name,' ')-1)), upper(substr(u.name, instr(u.name,' '))) into prenume,nume_familie
      from users u
      where u.id=new_id;
    select count(*) into nr_intrebari from questions 
    where user_id=new_id and reported<5;
    DBMS_OUTPUT.PUT_LINE('Numarul studentilor: '||nr_studenti);
    DBMS_OUTPUT.PUT_LINE('Numarul random: '||random_nr);
    DBMS_OUTPUT.PUT_LINE('ID: '||new_id);
    DBMS_OUTPUT.PUT_LINE('Prenume: '||prenume);
    DBMS_OUTPUT.PUT_LINE('Nume_familie: '||nume_familie);
    DBMS_OUTPUT.PUT_LINE('Numar intrebari: '||nr_intrebari);
    
END;
