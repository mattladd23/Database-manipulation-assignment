-- CPMPS DML STATEMENTS --

-- QUESTION A --

INSERT INTO student VALUES (600,'Peterson, J','PeteJ@myhome.com');


-- QUESTION B --

INSERT INTO exam VALUES ('VB03','Visual Basic 3','London','2022-06-03','09:00');


-- QUESTION C --

DELETE FROM student 
WHERE sno='200';


-- QUESTION D --

DELETE FROM exam
WHERE excode='VB01';

DELETE FROM exam
WHERE excode='SQL1';


-- QUESTION E --

INSERT INTO entry(excode,sno) 
SELECT 'VB03','100'
WHERE
	NOT EXISTS (SELECT sno, excode, exdate from entry_unique) or
	NOT EXISTS (SELECT sno, exdate, extime from entry_unique);


-- QUESTION F --

UPDATE entry
SET egrade = 60
WHERE eno = 10;


-- QUESTION P --

-- student no 100 --

SELECT sname AS student_name, exlocation AS exam_location,
exam.excode AS exam_code, extitle AS title, exdate AS date, extime AS start_time 
FROM student 
LEFT JOIN entry ON
student.sno = entry.sno
LEFT JOIN exam ON
entry.excode = exam.excode
WHERE student.sno = '100';

-- student no 200 --

SELECT sname AS student_name, exlocation AS exam_location,
exam.excode AS exam_code, extitle AS title, exdate AS date, extime AS start_time 
FROM student 
LEFT JOIN entry ON
student.sno = entry.sno
LEFT JOIN exam ON
entry.excode = exam.excode
WHERE student.sno = '200';


-- QUESTION Q --

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


-- QUESTION R -- 

SELECT student_name, grade, final_result
FROM entries_grade_class
WHERE exam_code = 'VB01';


-- QUESTION S --

SELECT sname AS student_name, exam.excode AS exam_code, extitle AS title, egrade AS grade 
FROM student 
LEFT JOIN entry ON
student.sno = entry.sno
LEFT JOIN exam ON
entry.excode = exam.excode
WHERE student.sno = 100 AND egrade IS NOT NULL
ORDER BY entry.excode ASC;


-- QUESTION T --

SELECT student_name, status
FROM accredited_pending
WHERE student_no = '100';

SELECT student_name, status
FROM accredited_pending
WHERE student_no = '200';