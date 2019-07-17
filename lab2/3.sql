set serveroutput on;
accept newid1 prompt 'Introduceti primul id: ';
accept newid2 prompt 'Introduceti al doilea id: ';
declare
  id1 users.id%type :=&newid1;
  id2 users.id%type :=&newid2;
  intrebari_puse1 NUMBER;
  intrebari_puse2 NUMBER;
  intrebari_raspunse1 NUMBER;
  intrebari_raspunse2 NUMBER;
begin
  select count(*) into intrebari_puse1 from questions
    where user_id=id1;
  select count(*) into intrebari_puse2 from questions
    where user_id=id2;
  select count(*) into intrebari_raspunse1 from answers
    where user_id=id1;
  select count(*) into intrebari_raspunse2 from answers
    where user_id=id2;
  if(intrebari_puse1>intrebari_puse2) then
    DBMS_OUTPUT.PUT_LINE('Id cu mai multe intrebari puse: ' || id1); 
    else
      if(intrebari_puse1<intrebari_puse2) then
        DBMS_OUTPUT.PUT_LINE('Id cu mai multe intrebari puse: ' || id2);
        else
          if(intrebari_puse1>intrebari_puse2) then
            DBMS_OUTPUT.PUT_LINE('Id cu mai multe intrebari raspunse: ' || id1); 
            else
            DBMS_OUTPUT.PUT_LINE('Id cu mai multe intrebari raspunse: ' || id2);
          end if;
        end if;
  end if;
end;