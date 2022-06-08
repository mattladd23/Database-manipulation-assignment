CREATE SCHEMA cpmps;
SET search_path to cpmps;

-- BASE TABLES =============================================================

-- exam table --------------------------------------------------------------

CREATE TABLE exam ( 
     excode       CHAR(4) NOT NULL,
     extitle      VARCHAR(20) NOT NULL,
     exlocation   VARCHAR(20) NOT NULL,
     exdate       DATE NOT NULL
  		  CHECK (exdate >= '2022-06-01' AND exdate <= '2022-06-30'),			
     extime       TIME NOT NULL
 		  CHECK (extime >= '09:00' AND extime <= '18:00'),
     CONSTRAINT exam_pk PRIMARY KEY(excode)
);



-- student table ------------------------------------------------------------

CREATE TABLE student (
     sno          INTEGER NOT NULL,
     sname        VARCHAR(20) NOT NULL,
     semail       VARCHAR(20) NOT NULL,
     CONSTRAINT student_pk PRIMARY KEY (sno)
);



-- examination entry table ---------------------------------------------------

-- a weak entity based on exam and student

CREATE TABLE entry (
     eno          INTEGER NOT NULL
                  CHECK (eno > 0),
     excode       CHAR(4) NOT NULL,
     sno          INTEGER NOT NULL,
     egrade       DECIMAL(5,2)
                  CHECK (egrade IS NULL OR
                  (egrade >= 0 AND egrade <= 100)),
     CONSTRAINT entry_pk	PRIMARY KEY (eno),
     CONSTRAINT entry_fk1 FOREIGN KEY (excode) REFERENCES exam
		ON UPDATE CASCADE ON DELETE RESTRICT,
     CONSTRAINT entry_fk2 FOREIGN KEY (sno) REFERENCES student
		ON UPDATE CASCADE ON DELETE CASCADE
);



-- cancel table ----------------------------------------------------------------

-- a weak entity based on entry

CREATE SEQUENCE cancel_cuser_seq;
    
CREATE TABLE cancel (
     eno          INTEGER NOT NULL,
     excode       CHAR(4) NOT NULL,
     sno          INTEGER NOT NULL,
     cdate        TIMESTAMP NOT NULL,
     cuser        VARCHAR(128),
 	 CONSTRAINT cancel_pk PRIMARY KEY (eno, cdate) 
         	
);


ALTER SEQUENCE cancel_cuser_seq
OWNED BY cancel.cuser;



-- TRIGGERS =====================================================================

-- used in question C --

-- trigger to delete student from student table and move their exam entries from
-- the entry table to cancel table

CREATE FUNCTION delete_student()
 RETURNS TRIGGER AS $$
 BEGIN
  INSERT INTO cpmps.cancel(eno, excode, sno, cdate, cuser)
  SELECT entry.eno, entry.excode, entry.sno, CURRENT_DATE, 1
   FROM entry
   WHERE entry.sno = OLD.sno;
  RETURN OLD;
 END;
 $$
 LANGUAGE 'plpgsql';


CREATE TRIGGER deleteStudent
 BEFORE DELETE ON student
 FOR EACH ROW
 EXECUTE PROCEDURE delete_student();


-- VIEWS =======================================================================



-- used in question E --

CREATE VIEW entry_unique AS
SELECT entry.sno, entry.excode, exam.exdate, exam.extime
FROM entry
JOIN exam
ON entry.excode = exam.excode;



-- used in question Q --

CREATE VIEW result_each_exam AS
SELECT sname AS student_name, exam.excode AS exam_code, extitle AS title, egrade AS grade 
FROM student 
LEFT JOIN entry ON
student.sno = entry.sno
LEFT JOIN exam ON
entry.excode = exam.excode
ORDER BY entry.excode, sname ASC;



-- used in question R --

CREATE VIEW entries_grade_class AS
SELECT student_name, exam_code, title, grade, 'Distinction' AS final_result 
FROM result_each_exam
WHERE grade >=70
	UNION
SELECT student_name, exam_code, title, grade, 'Pass' AS final_result
FROM result_each_exam
WHERE grade < 70 AND grade >= 50
	UNION
SELECT student_name, exam_code, title, grade, 'Fail' AS final_result
FROM result_each_exam
WHERE grade < 50
	UNION
SELECT student_name, exam_code, title, grade, 'Not Taken' AS final_result
FROM result_each_exam
WHERE grade ISNULL
ORDER BY exam_code, student_name ASC;



-- used in question T --

-- step 1 --

CREATE VIEW sno_exams_taken AS
SELECT entry.sno AS student_no, count(entry.egrade) as exams_taken
FROM entry
GROUP BY entry.sno;


CREATE VIEW sno_avg_grade AS
SELECT entry.sno AS student_no, round(avg(entry.egrade),2) as avg_grade
FROM entry
GROUP BY entry.sno;


-- step 2 --

CREATE VIEW sno_exams_avg AS
SELECT sno_exams_taken.student_no, exams_taken, avg_grade
FROM sno_exams_taken 
JOIN sno_avg_grade ON
sno_exams_taken.student_no = sno_avg_grade.student_no;


-- step 3 --

CREATE VIEW name_no_exams_avg AS
SELECT student.sname AS student_name, student_no, exams_taken, avg_grade
FROM student
JOIN sno_exams_avg
ON student.sno = sno_exams_avg.student_no;


-- step 4 --

CREATE VIEW accredited_pending AS
SELECT student_name, student_no, 'Accredited' AS status
FROM name_no_exams_avg
WHERE exams_taken >= 4 AND avg_grade >= 50
	UNION
SELECT student_name, student_no, 'Pending' AS status
FROM name_no_exams_avg
WHERE exams_taken < 4 OR avg_grade <50;