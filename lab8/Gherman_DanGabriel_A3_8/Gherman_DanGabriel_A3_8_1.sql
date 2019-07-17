SET serveroutput ON;

DROP TYPE pupper FORCE;
DROP TYPE doggo force;

CREATE OR REPLACE TYPE doggo AS OBJECT
(nume VARCHAR2(100),
 good_boy NUMBER,
 rasa VARCHAR2(100),
 data_nastere DATE,
 greutate NUMBER,
 constructor FUNCTION doggo(nume VARCHAR2,good_boy NUMBER,rasa VARCHAR2,data_nastere DATE,greutate NUMBER) RETURN self AS result,
 CONSTRUCTOR FUNCTION doggo(nume VARCHAR2,rasa VARCHAR2) RETURN self AS result,
 NOT FINAL MEMBER PROCEDURE borks,
 MEMBER PROCEDURE borks(more number),
 MEMBER FUNCTION can_have_treat RETURN NUMBER,
 member function getNume return varchar2,
 ORDER MEMBER FUNCTION sorty(dogger doggo) RETURN NUMBER,
 MEMBER FUNCTION current_age RETURN NUMBER
)NOT FINAL;

/

CREATE OR REPLACE TYPE BODY doggo AS 


  CONSTRUCTOR FUNCTION doggo(nume VARCHAR2,good_boy NUMBER,rasa VARCHAR2,data_nastere DATE,greutate NUMBER)
      RETURN SELF AS RESULT
    AS
    BEGIN
      SELF.nume := nume;
      SELF.good_boy := good_boy;
      SELF.rasa := rasa;
      SELF.data_nastere := data_nastere;
      SELF.greutate := greutate;
      RETURN;
    END;
    
    
  CONSTRUCTOR FUNCTION doggo(nume VARCHAR2,rasa VARCHAR2)
      RETURN SELF AS RESULT
    AS
    BEGIN
      SELF.nume := nume;
      SELF.good_boy := 1;
      SELF.rasa := rasa;
      SELF.data_nastere := SYSDATE - 1;
      SELF.greutate := 1;
      RETURN;
    END;
  
  
  NOT FINAL MEMBER PROCEDURE borks is
    BEGIN
      IF self.good_boy = 1 THEN DBMS_OUTPUT.PUT_LINE('B000RK');
        ELSE
          IF self.greutate > 10 THEN DBMS_OUTPUT.PUT_LINE('B000RK B000RK B000RK');
            ELSE
              DBMS_OUTPUT.PUT_LINE('B000RK B000RK');
          end if;
      END IF;
  END borks;
  
  NOT FINAL MEMBER PROCEDURE borks(more number) is
    BEGIN
      FOR i IN 1..more loop
        DBMS_OUTPUT.PUT_LINE('B00RK');
      end loop;
      IF self.good_boy = 1 THEN DBMS_OUTPUT.PUT_LINE('B0RK');
        ELSE
          IF self.greutate > 10 THEN DBMS_OUTPUT.PUT_LINE('B0RK B0RK B0RK');
            ELSE
              DBMS_OUTPUT.PUT_LINE('B0RK B0RK');
          end if;
      END IF;
  END borks;
  
  MEMBER FUNCTION current_age RETURN NUMBER is
  BEGIN
  return to_number(to_char(sysdate-self.data_nastere,'yy'));
  end current_age;
  
  
  ORDER MEMBER FUNCTION sorty(dogger doggo) RETURN NUMBER IS
    BEGIN
      IF data_nastere<dogger.data_nastere THEN RETURN -1;
      elsif data_nastere>dogger.data_nastere THEN RETURN 1;
      ELSE 
          IF good_boy<dogger.good_boy THEN RETURN -1;
          elsif good_boy>dogger.good_boy THEN RETURN 1;
          ELSE 
              IF greutate<dogger.greutate THEN RETURN -1;
              elsif greutate>dogger.greutate THEN RETURN 1;
              else return 0;
              end if;
          END IF;
      end if;
      return 0;
  end sorty;
  
  
  MEMBER FUNCTION getNume RETURN VARCHAR2 IS
    BEGIN
     RETURN nume;
  end getNume;
  
  
  MEMBER FUNCTION can_have_treat RETURN NUMBER is
    BEGIN
    IF self.good_boy = 0 
      THEN RETURN 0; -- :(
    ELSE
      IF self.current_age>1 AND greutate>10 
        THEN RETURN 10;
      ELSE
        RETURN 5;
      end if;
    end if;
  end can_have_treat;
END;

/
CREATE OR REPLACE TYPE pupper UNDER doggo
(
  OVERRIDING MEMBER PROCEDURE borks
  --,OVERRIDING MEMBER PROCEDURE borks(more number)
)

/
CREATE OR REPLACE TYPE BODY pupper AS
  
  OVERRIDING MEMBER PROCEDURE borks is
    BEGIN
      IF self.good_boy = 1 THEN DBMS_OUTPUT.PUT_LINE('w00f');
        ELSE
          IF self.greutate > 10 THEN DBMS_OUTPUT.PUT_LINE('w00f w00f w00f');
            ELSE
              DBMS_OUTPUT.PUT_LINE('w00f w00f');
          end if;
      END IF;
  END borks;
  
  /*OVERRIDING MEMBER PROCEDURE borks(more number) is
    BEGIN
      FOR i IN 0..more loop
        DBMS_OUTPUT.PUT_LINE('w00000f');
      end loop;
      IF self.good_boy = 1 THEN DBMS_OUTPUT.PUT_LINE('w00f');
        ELSE
          IF self.greutate > 10 THEN DBMS_OUTPUT.PUT_LINE('w00f w00f w00f');
            ELSE
              DBMS_OUTPUT.PUT_LINE('w00f w00f');
          end if;
      END IF;
  END borks;*/
END;
/
drop table example;
CREATE TABLE example(
ID INT NOT NULL,
doggos doggo not null,
primary key(id)
);

DECLARE
pup1 doggo;
pup2 doggo;
pup3 pupper;
BEGIN
pup1:=doggo('Roger',0,'Labradoodle',to_date('01-03-2007','dd-mm-yyyy'),13);
pup2:=doggo('Biggus','Pug');
pup3:=pupper('Doge',1,'Shib',to_date('05-05-2017','dd-mm-yyyy'),2);
pup1.borks;
DBMS_OUTPUT.PUT_LINE('');
pup1.borks(4);
DBMS_OUTPUT.PUT_LINE('');
pup3.borks;
DBMS_OUTPUT.PUT_LINE('');
pup3.borks(4);
DBMS_OUTPUT.PUT_LINE('');
DBMS_OUTPUT.PUT_LINE(pup1.sorty(pup2));
INSERT INTO example(ID,doggos) VALUES (1,pup1);
INSERT INTO example(ID,doggos) VALUES (2,pup2);
insert into example(id,doggos) values (3,pup3);
END;