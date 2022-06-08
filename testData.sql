-- CPMPS TEST DATA --


-- exam

INSERT INTO exam VALUES ('AP01','Apps Prog 1','Norwich','2022-06-06','10:00');
INSERT INTO exam VALUES ('AP02','Apps Prog 2','Norwich','2022-06-10','10:00');
INSERT INTO exam VALUES ('WI01','Web Internet 1','Exeter','2022-06-15','11:00');
INSERT INTO exam VALUES ('WI02','Web Internet 2','Exeter','2022-06-18','11:00');
INSERT INTO exam VALUES ('DM01','Databases 1','Glasgow','2022-06-24','09:00');
INSERT INTO exam VALUES ('DM02','Databases 2','Glasgow','2022-06-27','09:00');
INSERT INTO exam VALUES ('RT01','Research Techs 1','Liverpool','2022-06-28','14:00');
INSERT INTO exam VALUES ('RT02','Research Techs 2','Liverpool','2022-06-29','14:00');
INSERT INTO exam VALUES ('AS01','Applied Stats 1', 'Birmingham','2022-06-06','10:00');

-- student

INSERT INTO student VALUES (101,'Matt Ritchie','ritchie@gmail.com');
INSERT INTO student VALUES (102,'Ciaran Clark','clark@gmail.com');
INSERT INTO student VALUES (103,'Paul Dummett','dummett@gmail.com');
INSERT INTO student VALUES (104,'Sean Longstaff','longy@gmail.com');
INSERT INTO student VALUES (105,'Jamaal Lascelles','lasc@gmail.com');
INSERT INTO student VALUES (106,'Jonjo Shelvey','shelv@gmail.com');
INSERT INTO student VALUES (107,'Joelinton','joe7@gmail.com');
INSERT INTO student VALUES (108,'Isaac Hayden','ihayden@gmail.com');
INSERT INTO student VALUES (109,'Callum Wilson','cw9@gmail.com');
INSERT INTO student VALUES (110,'Allan Saint Max','asm10@gmail.com');

-- entry

INSERT INTO entry (excode, sno) VALUES ('AP01',101);
INSERT INTO entry (excode, sno) VALUES ('AP02',102);
INSERT INTO entry (excode, sno) VALUES ('WI01',103);
INSERT INTO entry (excode, sno) VALUES ('WI02',104);
INSERT INTO entry (excode, sno) VALUES ('DM01',105);
INSERT INTO entry (excode, sno) VALUES ('DM02',106);
INSERT INTO entry (excode, sno) VALUES ('WI01',105);
INSERT INTO entry (excode, sno) VALUES ('DM01',104);
INSERT INTO entry (excode, sno) VALUES ('DM01',107);
INSERT INTO entry (excode, sno) VALUES ('DM02',107);
INSERT INTO entry (excode, sno) VALUES ('AP01',107);
INSERT INTO entry (excode, sno) VALUES ('AP02',109);
INSERT INTO entry (excode, sno) VALUES ('WI01',110);
INSERT INTO entry (excode, sno) VALUES ('WI02',110);


-- USING UPDATE 

UPDATE entry
SET egrade = 55
WHERE eno = 2;

UPDATE entry
SET egrade = 44
WHERE eno = 5;

UPDATE entry
SET egrade = 90
WHERE eno = 9;

UPDATE entry
SET egrade = 67
WHERE eno = 7;

UPDATE entry
SET egrade = 31
WHERE eno = 4;

UPDATE entry
SET egrade = 77
WHERE eno = 12;

UPDATE entry
SET egrade = 81
WHERE eno = 10;

UPDATE entry
SET egrade = 71
WHERE eno = 13;