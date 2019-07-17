l/*DROP TABLE LOG;
CREATE TABLE LOG(
  time_stamp DATE,
  operatie VARCHAR2(200),
  nr_matricol VARCHAR2(200), 
	id_curs VARCHAR2(200), 
	valoare NUMBER, 
	data_notare DATE
  );
/
  */

CREATE OR REPLACE VIEW note_view AS SELECT * FROM note;
/
CREATE OR REPLACE TRIGGER log_note_update
INSTEAD OF UPDATE ON note_view
DECLARE
curr_date DATE:=SYSDATE;
v_operatie VARCHAR2(200):='UPDATE_TO';
v_nr_matricol CHAR(4 BYTE):= :NEW.nr_matricol; 
v_id_curs CHAR(2 BYTE):= :NEW.id_curs; 
v_valoare NUMBER(2,0):= :NEW.valoare; 
v_data_notare DATE:= :NEW.data_notare;

v2_operatie VARCHAR2(200):='UPDATE_FROM';
v2_nr_matricol CHAR(4 BYTE):= :OLD.nr_matricol; 
v2_id_curs CHAR(2 BYTE):= :OLD.id_curs; 
V2_valoare NUMBER(2,0):= :OLD.valoare; 
v2_data_notare DATE:= :OLD.data_notare;
BEGIN
INSERT INTO LOG(time_stamp, operatie, nr_matricol, id_curs, valoare, data_notare) VALUES (curr_date,v2_operatie,v2_nr_matricol,v2_id_curs,v2_valoare,v2_data_notare);
INSERT INTO LOG(time_stamp, operatie, nr_matricol, id_curs, valoare, data_notare) VALUES (curr_date,v_operatie,v_nr_matricol,v_id_curs,v_valoare,v_data_notare);
END;
/
CREATE OR REPLACE TRIGGER log_note_delete
INSTEAD OF DELETE ON note_view
DECLARE
curr_date DATE:=SYSDATE;
v_operatie VARCHAR2(200):='DELETE';
v_nr_matricol CHAR(4 BYTE):= :OLD.nr_matricol; 
v_id_curs CHAR(2 BYTE):= :OLD.id_curs; 
v_valoare NUMBER(2,0):= :OLD.valoare; 
v_data_notare DATE:= :OLD.data_notare;
BEGIN
INSERT INTO LOG(time_stamp, operatie, nr_matricol, id_curs, valoare, data_notare) VALUES (curr_date,v_operatie,v_nr_matricol,v_id_curs,v_valoare,v_data_notare);
END;
/
CREATE OR REPLACE TRIGGER log_note_insert
INSTEAD OF insert ON note_view
DECLARE
curr_date DATE:=SYSDATE;
v_operatie VARCHAR2(200):='INSERT';
v_nr_matricol CHAR(4 BYTE):= :NEW.nr_matricol; 
v_id_curs CHAR(2 BYTE):= :NEW.id_curs; 
v_valoare NUMBER(2,0):= :NEW.valoare; 
v_data_notare DATE:= :NEW.data_notare;
BEGIN
INSERT INTO LOG(time_stamp, operatie, nr_matricol, id_curs, valoare, data_notare) VALUES (curr_date,v_operatie,v_nr_matricol,v_id_curs,v_valoare,v_data_notare);
END;