set serveroutput on;
CREATE OR REPLACE PACKAGE problema1_lab7 AS
  FUNCTION intrebare_repetata(question_id questions.ID%TYPE) RETURN NUMBER;
  CURSOR intrebari IS SELECT * FROM questions;
  cursor intrebari2 is select * from newquestions;
  FUNCTION inserare_relevanta(question_id questions.ID%TYPE) RETURN NUMBER;

END problema1_lab7;
/
create or replace PACKAGE BODY problema1_lab7 AS
  current_id questions.ID%TYPE :=-1;
  current_chapter_id questions.chapter_id%TYPE;
  current_user_id questions.user_id%TYPE;
  current_question questions.question%TYPE;
  current_answer questions.answer%TYPE;
  current_asked questions.asked%TYPE;
  current_solved questions.solved%TYPE;
  current_reported questions.reported%TYPE;
  current_report_resolved questions.report_resolved%TYPE;
  current_created_at questions.created_at%TYPE;
  current_updated_at questions.updated_at%TYPE;
  question_found_already exception;
  parameter_not_found exception;
  zero_relevance exception;
  
  
  FUNCTION intrebare_repetata(question_id questions.ID%TYPE)  RETURN NUMBER AS
  BEGIN
    FOR linie IN intrebari loop
      IF linie.ID=question_id THEN 
        current_id:=linie.ID;
        current_chapter_id:=linie.chapter_id;
        current_user_id:=linie.user_id;
        current_question:=linie.question;
        current_answer:=linie.answer;
        current_asked:=linie.asked;
        current_solved:=linie.solved;
        current_reported:=linie.reported;
        current_report_resolved:=linie.report_resolved;
        current_created_at:=linie.created_at;
        current_updated_at:=linie.updated_at;
        exit;
      END IF;
    END loop;
    FOR linie2 IN intrebari2 loop
      IF linie2.ID=current_id THEN
        IF linie2.chapter_id=current_chapter_id THEN
          IF linie2.user_id=current_user_id THEN
            IF linie2.question=current_question THEN
              IF linie2.answer=current_answer THEN
                IF linie2.asked=current_asked THEN
                  IF linie2.solved=current_solved THEN
                    IF linie2.reported=current_reported THEN
                      IF linie2.report_resolved=current_report_resolved THEN
                        IF linie2.created_at=current_created_at THEN
                          IF linie2.updated_at=current_updated_at THEN
                              raise question_found_already;
                              RETURN -1;
                          END IF;
                        END IF;
                      END IF;
                    END IF;
                  END IF;
                END IF;
              END IF;
            END IF;
          END IF;
        END IF;
      END IF;
    END loop;
    
  RETURN 1;
  
  exception 
    WHEN problema1_lab7.question_found_already THEN
      raise_application_error(-20665, 'Question already found in new table,man.');
    WHEN problema1_lab7.parameter_not_found THEN
      raise_application_error(-20666, 'parameter not found');
      
  END intrebare_repetata;
  
  
  FUNCTION inserare_relevanta(question_id questions.ID%TYPE) RETURN NUMBER AS
    relevanta_intrebare NUMBER :=0;
  BEGIN
    current_id :=-1;
    relevanta_intrebare:=relevanta(question_id);
    IF relevanta_intrebare=0 THEN
      raise zero_relevance;
      RETURN -1;
    END IF;
    IF intrebare_repetata(question_id)!=-1 THEN
      FOR linie IN intrebari loop
        IF linie.ID=question_id THEN 
          current_id:=linie.ID;
          current_chapter_id:=linie.chapter_id;
          current_user_id:=linie.user_id;
          current_question:=linie.question;
          current_answer:=linie.answer;
          current_asked:=linie.asked;
          current_solved:=linie.solved;
          current_reported:=linie.reported;
          current_report_resolved:=linie.report_resolved;
          current_created_at:=linie.created_at;
          current_updated_at:=linie.updated_at;
        END IF;
      END loop;
      INSERT INTO NEWQUESTIONS(ID,CHAPTER_ID,USER_ID,QUESTION,ANSWER,ASKED,SOLVED,REPORTED,REPORT_RESOLVED,CREATED_AT,UPDATED_AT) VALUES
        (current_id,current_chapter_id,current_user_id,current_question,current_answer,current_asked,current_solved,current_reported,current_report_resolved,current_created_at,current_updated_at);
        RETURN 1;
    END IF;
    exception WHEN problema1_lab7.zero_relevance THEN
        raise_application_error(-20666, 'Question has 0 relevance, man.');
  END inserare_relevanta;
  
END problema1_lab7;

/

DECLARE
numar_intrebari NUMBER :=0;
cursor questionz is select * from questions;
BEGIN
  FOR linie IN questionz loop
    IF numar_intrebari = 1000 THEN
      exit;
    end if;
    IF PROBLEMA1_LAB7.inserare_relevanta(linie.ID)!=-1 THEN
      numar_intrebari:= numar_intrebari+1;
    end if;
  end loop;
end;