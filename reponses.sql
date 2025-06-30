-- 1 - Afficher le nom complet de l’étudiant et l’intitulé de sa formation.
SELECT CONCAT(last_name, " ", first_name) "étudiants", course.course_name 
FROM Student INNER JOIN course ON Student.course_id = course.course_id;


-- 2 - Lister les étudiants inscrits en "Data Analyst".
SELECT CONCAT(last_name, " ", first_name) "étudiants"
FROM Student INNER JOIN course ON Student.course_id = course.course_id WHERE course.course_name LIKE "Data Analyst";


-- 3 - Lister les examens avec le prénom, nom de l’étudiant, le nom du cours, la note et la date.
SELECT CONCAT(last_name, " ", first_name) "étudiants", course.course_name, score, exam_date FROM exam 
INNER JOIN Student ON exam.student_id = Student.student_id
INNER JOIN course ON Student.course_id = course.course_id;


-- 4 - Afficher tous les étudiants avec leur formation, y compris ceux sans formation.
SELECT CONCAT(last_name, " ", first_name) "étudiants", course.course_name 
FROM Student LEFT JOIN course ON Student.course_id = course.course_id;

-- 5 - Afficher les étudiants sans formation (champ NULL).
SELECT CONCAT(last_name, " ", first_name) "étudiants"
FROM Student LEFT JOIN course ON Student.course_id = course.course_id
WHERE course.course_name IS NULL;

-- 6 - Afficher tous les étudiants avec leurs examens, même s’ils n’en ont pas passé.
SELECT CONCAT(last_name, " ", first_name) "étudiants", exam.* FROM Student
LEFT JOIN exam ON Student.student_id = exam.student_id;

-- 7 - Afficher toutes les formations même si aucun étudiant n'y est inscrit.
select * from course;

-- 8 - Afficher les examens associés à un cours, y compris les cours sans examens (si possible).
SELECT exam.* FROM exam
RIGHT JOIN course ON exam.course_id = course.course_id;

-- 9 - Lister toutes les combinaisons étudiant-formation même sans correspondance.
SELECT CONCAT(last_name, " ", first_name) "étudiants", course.* FROM Student
LEFT JOIN course ON Student.course_id = course.course_id
UNION
SELECT CONCAT(last_name, " ", first_name) "étudiants", course.* FROM Student
RIGHT JOIN course ON Student.course_id = course.course_id;


-- 10 - Lister tous les examens et étudiants, même si l'un des deux est manquant.
SELECT CONCAT(last_name, " ", first_name) "étudiants", exam.* FROM Student
LEFT JOIN exam ON Student.student_id = exam.student_id
UNION
SELECT CONCAT(last_name, " ", first_name) "étudiants", exam.* FROM Student
RIGHT JOIN exam ON Student.student_id = exam.student_id;

-- 11 - Trouver les paires d’étudiants nés la même année.
SELECT CONCAT(s1.last_name, " ", s1.first_name) "étudiants", CONCAT(s2.last_name, " ", s2.first_name) "étudiants", s1.birth_year
FROM Student s1, Student s2 WHERE s1.birth_year = s2.birth_year AND NOT s1.student_id = s2.student_id AND s1.student_id > s2.student_id;


-- 12 - Associer chaque étudiant à ceux qui sont plus âgés qu’eux.
SELECT CONCAT(s1.last_name, " ", s1.first_name) "étudiants", CONCAT(s2.last_name, " ", s2.first_name) "étudiants", s1.birth_year, s2.birth_year
FROM Student s1, Student s2 WHERE s1.birth_year > s2.birth_year;

-- 13 - Générer toutes les combinaisons possibles entre étudiants et types d’examen ('Écrit', 'Oral', 'Projet').
SELECT CONCAT(last_name, " ", first_name) "étudiants", exam.exam_type FROM Student
CROSS JOIN exam;

-- 14 - Compter le nombre de lignes produites par ce CROSS JOIN.
SELECT COUNT(Student.student_id) "nombres de lignes" FROM Student, exam;

-- 15 - Afficher la moyenne des notes par étudiant.
SELECT CONCAT(last_name, " ", first_name) "étudiants", ROUND(AVG(exam.score),2) "moyenne"
FROM exam INNER JOIN Student ON exam.student_id = Student.student_id
GROUP BY Student.student_id;

-- 16 - Afficher la note maximale obtenue par cours.
SELECT MAX(score) "note maximale", course.course_name FROM exam
RIGHT JOIN course ON exam.course_id = course.course_id
GROUP BY course.course_id;


-- 17 - Lister les étudiants ayant obtenu une note supérieure à 15 à au moins un examen.
SELECT CONCAT(last_name, " ", first_name) "étudiants" FROM Student
RIGHT JOIN exam ON Student.student_id = exam.student_id
GROUP BY Student.student_id
HAVING Max(exam.score) > 15;