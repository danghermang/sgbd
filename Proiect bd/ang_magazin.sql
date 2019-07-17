set serveroutput on;
DECLARE
  random_produs number:=0;
  random_angajat number:=0;
  random_user number:=0;
  min_produs number:=0;
  max_produs number:=0;
  min_user number:=0;
  max_user number:=0;
  min_angajat number:=0;
  max_angajat number:=0;
  random_data_comanda date;
  data_sosire date;
  random_adress varchar2(100);
BEGIN

select min(id),max(id) into min_produs,max_produs from produse;
select min(id),max(id) into min_angajat,max_angajat from angajat;
select min(id),max(id) into min_user,max_user from users;
  for i in 1..10000 loop
    random_produs:=floor(dbms_random.value(min_produs,max_produs));
    random_angajat:=floor(dbms_random.value(min_angajat,max_angajat));
    random_user:=floor(dbms_random.value(min_user,max_user));
    random_data_comanda:=TO_DATE(TRUNC(DBMS_RANDOM.VALUE(TO_CHAR(DATE '2000-01-01','J'),TO_CHAR(sysdate,'J'))),'J');
    data_sosire:=random_data_comanda+3;
    select adresa into random_adress from users where id=random_user;
    insert into comenzi(data_comenzii,id_produs,id_angajat,id,data_livrare,adress,id_user) values
      (random_data_comanda,random_produs,random_angajat,i,data_sosire,random_adress,random_user);
  end loop;
END;
