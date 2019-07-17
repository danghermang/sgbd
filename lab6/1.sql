SET serveroutput ON;

DECLARE 
TYPE vector IS TABLE OF VARCHAR2(50) INDEX BY pls_integer;
TYPE matrice IS TABLE OF vector;
termen1 matrice;
termen2 matrice;
rezultat matrice;
size_n INTEGER := trunc(dbms_random.VALUE(2,5));
size_m INTEGER := trunc(dbms_random.VALUE(2,5));
size_p INTEGER := trunc(dbms_random.VALUE(2,5));
suma NUMBER;
maxim NUMBER:=0;
thing VARCHAR2(500);
indentare INTEGER:=0;
BEGIN
termen1:=matrice();
termen2:=matrice();
rezultat:=matrice();
termen1.extend(10);
termen2.extend(10);
rezultat.extend(10);
  
  
  maxim:=0;
  FOR i IN 1..size_n loop
      FOR j IN 1..size_m loop
        termen1(i)(j):=floor(dbms_random.VALUE(0,30));
        IF(maxim < termen1(i)(j)) THEN
        maxim := termen1(i)(j);
        END IF;
      END loop;
  END loop;
  indentare:=length(maxim)+2;
  dbms_output.put_line('Prima matrice:');
  FOR i IN 1..size_n loop
    FOR j IN 1..size_m loop
    dbms_output.put(lpad(termen1(i)(j), indentare));
    END loop;
    dbms_output.put_line('');
  END loop;
  
  
  
  maxim:=0;
  FOR i IN 1..size_m loop
      FOR j IN 1..size_p loop
        termen2(i)(j):=floor(dbms_random.VALUE(0,30));
        IF(maxim < termen2(i)(j)) THEN
        maxim := termen2(i)(j);
        END IF;
      END loop;
  END loop;
  indentare:=length(maxim)+2;
  dbms_output.put_line('A doua matrice:');
  FOR i IN 1..size_m loop
    FOR j IN 1..size_p loop
    dbms_output.put(lpad(termen2(i)(j), indentare));
    END loop;
    dbms_output.put_line('');
  END loop;
    
  FOR i IN 1..size_n loop
      FOR j IN 1..size_p loop
        rezultat(i)(j):=0;
      END loop;
  END loop;
  FOR i IN 1..size_n loop
    FOR j IN 1..size_p loop
      FOR k IN 1..size_m loop
        rezultat(i)(j):= rezultat(i)(j)+ termen1(i)(k)*termen2(k)(j);
      END loop;
    END loop;
  END loop;
  
  FOR i IN 1..size_n loop
    FOR j IN 1..size_p loop
      IF(maxim < rezultat(i)(j)) THEN
        maxim := rezultat(i)(j);
        END IF;
    END loop;
  END loop;
  indentare := LENGTH(maxim)+2;
  dbms_output.put_line('Matricea rezultat:');
  FOR it IN 1..size_n loop
    FOR j IN 1..size_p loop
    dbms_output.put(lpad(rezultat(it)(j), indentare));
    END loop;
    dbms_output.put_line('');
  END loop;
END;