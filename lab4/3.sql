--create index index_answers on answers(user_id,solved);
--create index index_questions on questions(id,user_id);

SET serveroutput ON;

DECLARE
  CURSOR id_special IS SELECT questions.ID,users.username FROM questions JOIN users ON questions.user_id=users.ID WHERE users.user_role NOT LIKE 'admin' ORDER BY questions.ID;
  temp_id users.ID%TYPE:=0;
  temp_relevance NUMBER:=0;
  temp_relevance_max NUMBER:=0;
  temp_username users.username%TYPE :='null';
BEGIN
  FOR line IN id_special loop
    temp_relevance:=relevanta(line.ID);
    dbms_output.put_line(line.username||' '||line.ID||' '||temp_relevance);
    IF(temp_relevance_max<temp_relevance)
      THEN temp_relevance_max:=temp_relevance;
          temp_username:=line.username;
          temp_id:=line.ID;
    END IF;
  END loop;
  dbms_output.put_line('');
  dbms_output.put_line('username:'||temp_username||'   id:'||temp_id||'   relevanta maxima:'||temp_relevance_max);
END;