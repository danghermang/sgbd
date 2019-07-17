set serveroutput on;
drop table zodiac;

create table zodiac(
nume varchar(50),
data_inceput date,
data_final date
);
insert into ZODIAC(nume,data_inceput,data_final) VALUES ('Berbec',to_date('21-03','dd-mm'),to_date('20-04','dd-mm'));
insert into ZODIAC(nume,data_inceput,data_final) VALUES ('Taur',to_date('21-04','dd-mm'),to_date('20-05','dd-mm'));
insert into ZODIAC(nume,data_inceput,data_final) VALUES ('Gemeni',to_date('21-05','dd-mm'),to_date('22-06','dd-mm'));
insert into ZODIAC(nume,data_inceput,data_final) VALUES ('Rac',to_date('23-06','dd-mm'),to_date('22-07','dd-mm'));
insert into ZODIAC(nume,data_inceput,data_final) VALUES ('Leu',to_date('23-07','dd-mm'),to_date('22-08','dd-mm'));
insert into ZODIAC(nume,data_inceput,data_final) VALUES ('Fecioara',to_date('23-08','dd-mm'),to_date('22-09','dd-mm'));
insert into ZODIAC(nume,data_inceput,data_final) VALUES ('Balanta',to_date('23-09','dd-mm'),to_date('22-10','dd-mm'));
insert into ZODIAC(nume,data_inceput,data_final) VALUES ('Scorpion',to_date('23-10','dd-mm'),to_date('21-11','dd-mm'));
insert into ZODIAC(nume,data_inceput,data_final) VALUES ('Sagetator',to_date('22-11','dd-mm'),to_date('20-12','dd-mm'));
insert into ZODIAC(nume,data_inceput,data_final) VALUES ('Capricorn',to_date('21-12','dd-mm'),to_date('19-01','dd-mm'));
insert into ZODIAC(nume,data_inceput,data_final) VALUES ('Varsator',to_date('20-01','dd-mm'),to_date('18-02','dd-mm'));
insert into ZODIAC(nume,data_inceput,data_final) VALUES ('Pesti',to_date('19-02','dd-mm'),to_date('20-03','dd-mm'));

select UPPER(zodiac.nume),tabela2.nume,tabela2.prenume from tabela2 join zodiac on to_char(tabela2.data_nastere,'dd-mm') in 
(to_char(zodiac.data_inceput,'dd-mm'),to_char(zodiac.data_final,'dd-mm')) order by zodiac.nume;