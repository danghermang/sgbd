--------------------------------------------------------
--  DDL for Function CATEGORIE_PREFERATA
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "PROIECT"."CATEGORIE_PREFERATA" (user_id users.ID%TYPE) RETURN categorii.nume%TYPE AS
maxim NUMBER:=0;
id_categorie categorii.ID%TYPE;
nume_categorie categorii.nume%type;
aux number;
BEGIN
FOR linie IN (SELECT * FROM categorii) loop
  aux:=0;
  FOR linie2 IN (SELECT * FROM comenzi c 
                  JOIN categorii_produse cp ON c.id_produs=cp.id_produs 
                    JOIN categorii ca ON cp.id_categorie=ca.ID 
                      WHERE c.ID_USER=user_id AND ca.ID=linie.ID) loop
      aux:=aux+1;
  END loop;
  IF aux>=maxim THEN 
    maxim:= aux; 
    id_categorie:=linie.ID; 
    nume_categorie:=linie.nume;
  end if;
END loop;
return nume_categorie;
END categorie_preferata;

/
