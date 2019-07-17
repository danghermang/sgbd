set serveroutput on;
<<global>>
DECLARE
v_nume VARCHAR2(20):='MIHAI CREANGA';
BEGIN
DBMS_OUTPUT.PUT_LINE('Valoarea variabilei v_nume este: ' || v_nume);  -- va afisa 'MIHAI CREANGA'
  <<bloc2>>
  DECLARE
     v_nume VARCHAR2(20):='Cristi';
  BEGIN
      DBMS_OUTPUT.PUT_LINE('Valoarea variabilei v_nume este: ' || v_nume);  -- va afisa 'Cristi'
      DBMS_OUTPUT.PUT_LINE('Valoarea variabilei v_nume este: ' || global.v_nume);  -- va afisa 'MIHAI CREANGA'
      DBMS_OUTPUT.PUT_LINE('Valoarea variabilei v_nume este: ' || bloc2.v_nume);  -- va afisa 'Cristi'
     <<bloc1>>
     DECLARE
        v_nume NUMBER(3) := 5;
     BEGIN
          DBMS_OUTPUT.PUT_LINE('Valoarea variabilei v_nume este: ' || v_nume); -- va afisa 5
          DBMS_OUTPUT.PUT_LINE('Valoarea variabilei v_nume este: ' || global.v_nume); -- va afisa 'MIHAI CREANGA'
          DBMS_OUTPUT.PUT_LINE('Valoarea variabilei v_nume este: ' || bloc1.v_nume);  -- va afisa '5'
          DBMS_OUTPUT.PUT_LINE('Valoarea variabilei v_nume este: ' || bloc2.v_nume);  -- va afisa 'Cristi'
     END;
     DBMS_OUTPUT.PUT_LINE('Valoarea variabilei v_nume este: ' || v_nume); -- va afisa 'Cristi'
     DBMS_OUTPUT.PUT_LINE('Valoarea variabilei v_nume este: ' || global.v_nume); -- va afisa 'MIHAI CREANGA'
     DBMS_OUTPUT.PUT_LINE('Valoarea variabilei v_nume este: ' || bloc2.v_nume); -- va afisa 'Cristi'
  END;
    DBMS_OUTPUT.PUT_LINE('Valoarea variabilei v_nume este: ' || v_nume); -- va afisa 'MIHAI CREANGA'
    DBMS_OUTPUT.PUT_LINE('Valoarea variabilei v_nume este: ' || global.v_nume); -- va afisa 'MIHAI CREANGA'
END;