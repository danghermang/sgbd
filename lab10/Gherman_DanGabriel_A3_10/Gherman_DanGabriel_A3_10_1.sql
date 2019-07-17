SELECT OBJECT_NAME,OBJECT_TYPE FROM user_objects WHERE OBJECT_TYPE = 'TABLE'
UNION
SELECT OBJECT_NAME,OBJECT_TYPE FROM user_objects WHERE OBJECT_TYPE = 'FUNCTION'
UNION
SELECT OBJECT_NAME,OBJECT_TYPE FROM user_objects WHERE OBJECT_TYPE = 'PROCEDURE'
UNION
SELECT OBJECT_NAME,OBJECT_TYPE FROM user_objects WHERE OBJECT_TYPE = 'VIEW'
UNION
SELECT OBJECT_NAME,OBJECT_TYPE FROM USER_OBJECTS WHERE OBJECT_TYPE = 'PACKAGE'
UNION
SELECT OBJECT_NAME,OBJECT_TYPE FROM user_objects WHERE OBJECT_TYPE = 'TRIGGER' ORDER BY OBJECT_TYPE;