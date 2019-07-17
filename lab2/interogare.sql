select * from users u where instr(trim(lower(u.name)),trim(lower('dan')))!=0 order by id asc;
