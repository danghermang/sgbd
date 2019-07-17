DECLARE
  CURSOR log_cursor IS SELECT * FROM LOG ORDER BY time_stamp ASC;
  v_nr_matricol NOTE.NR_MATRICOL%TYPE;
  v_id_Curs NOTE.ID_CURS%TYPE;
  v_valoare NOTE.VALOARE%TYPE;
  v_data_notare NOTE.DATA_NOTARE%type;
BEGIN
  FOR linie IN log_cursor loop
    IF linie.operatie LIKE 'INSERT' THEN INSERT INTO note(nr_matricol,id_curs,valoare,data_notare) VALUES (linie.nr_matricol,linie.id_curs,linie.valoare,linie.data_notare);
    
    elsif linie.operatie LIKE 'DELETE' THEN 
      DELETE FROM NOTE WHERE NR_MATRICOL=linie.nr_matricol AND id_curs=linie.id_curs AND valoare=linie.valoare AND data_notare=linie.data_notare;
    
    elsif linie.operatie LIKE 'UPDATE_FROM' THEN 
      V_NR_MATRICOL:=LINIE.NR_MATRICOL; V_ID_CURS:=LINIE.ID_CURS; V_VALOARE:= LINIE.VALOARE; V_DATA_NOTARE:=LINIE.DATA_NOTARE;
    
    elsif linie.operatie LIKE 'UPDATE_TO' THEN 
      UPDATE NOTE SET NR_MATRICOL=LINIE.NR_MATRICOL, ID_CURS=LINIE.ID_CURS, VALOARE=LINIE.VALOARE,DATA_NOTARE=LINIE.DATA_NOTARE
        WHERE NR_MATRICOL=V_NR_MATRICOL AND ID_CURS=V_ID_CURS AND VALOARE=V_VALOARE AND DATA_NOTARE=V_DATA_NOTARE;
    
    end if;
  end loop;
END;
/*INSERT INTO NOTE_view VALUES ('120', '21',  7, TO_DATE('18/02/2015', 'dd/mm/yyyy'));
DELETE FROM NOTE_VIEW WHERE NR_MATRICOL=120 AND VALOARE=7 AND ID_CURS=21;
update note_view set valoare=3 where valoare=4;
SELECT * FROM note;
*/