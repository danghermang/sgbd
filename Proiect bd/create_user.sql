DROP TABLESPACE football INCLUDING CONTENTS CASCADE CONSTRAINTS;

CREATE TABLESPACE football
  DATAFILE 'tbs_perm_0001.dat'
    SIZE 500M
    REUSE
    AUTOEXTEND ON NEXT 50M MAXSIZE 2000M
/
    
CREATE TEMPORARY TABLESPACE football
  TEMPFILE 'tbs_temp_0001.dbf'
    SIZE 5M
    AUTOEXTEND ON
/    

CREATE UNDO TABLESPACE football
  DATAFILE 'tbs_undo_0001.dbf'
    SIZE 5M 
    AUTOEXTEND ON
  RETENTION GUARANTEE
/


drop user dba cascade;
create user java_lab identified by JAVA_LAB;
alter user java_lab default tablespace java_lab quota 1990M on java_lab;

grant connect to java_lab;
grant all privileges to java_lab;
