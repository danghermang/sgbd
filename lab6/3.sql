set serveroutput on;
create or replace Function Relevanta123(Numestudent Users.Username%Type) Return Number As
    Temp_Relevance Number :=0;
    Temp_Relevance_Max Number :=0;
    Temp_User_Id Users.Id%Type;
    contor integer:=0;
    Cursor Lista_Intrebari Is Select Questions.Id From Questions Where Questions.User_Id = (Select Id From Users Where Users.Username=Numestudent);
  Begin
    For Line In Lista_Intrebari
      Loop
        Temp_Relevance := Relevanta(Line.Id);
        If (Temp_Relevance !=0)
          Then contor:=contor+1;
        End If;
      End Loop;
      Return contor;
  End;
  /
DECLARE 
   
   CURSOR curs IS SELECT nume,prenume from 
   (select Initcap(substr(username,instr(username,'.')+1, length(username))) nume, initcap(substr(username,0,instr(username,'.')-1)) prenume from users where id >30 and id<70);
   TYPE array IS RECORD(
      nume varchar2(20),  
      prenume varchar2(20)
      );
   student array; 
   
  procedure procedura_colectie(persoana array) as
  counter number:=0;
  begin
    counter:=relevanta123(lower(persoana.prenume)||'.'||lower(persoana.nume));
    dbms_output.put_line(counter);
  end procedura_colectie;
   
   
  begin
    for linie in curs loop
      student.nume:=linie.nume;
      student.prenume:=linie.prenume;
      dbms_output.put(student.nume||' '||student.prenume||' ');
      procedura_colectie(student);
    end loop;
  end;