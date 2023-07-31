--1 
SELECT Name, Places
FROM Wards
WHERE DepartmentId IN (SELECT Id FROM Departments WHERE Building = 5 AND EXISTS (SELECT * FROM Wards WHERE DepartmentId = Id AND Places > 15))
  AND Places >= 5

--2 
SELECT DISTINCT d.Name
FROM Diseases d
INNER JOIN DoctorsExaminations de ON d.Id = de.DiseaseId
WHERE de.Date >= DATEADD(day, -7, GETDATE())

--3 
SELECT d.Name
FROM Diseases d
LEFT OUTER JOIN DoctorsExaminations de ON d.Id = de.DiseaseId
WHERE de.Id IS NULL

--4 
SELECT Name + ' ' + Surname AS FullName
FROM Doctors
WHERE Id NOT IN (SELECT DoctorId FROM DoctorsExaminations)

--5 
SELECT Name
FROM Departments
WHERE NOT EXISTS (SELECT 1 FROM DoctorsExaminations WHERE WardId = Departments.Id)

--6 
SELECT Surname
FROM Doctors d
INNER JOIN Inters i ON d.Id = i.DoctorId

--7 
SELECT d.Surname
FROM Doctors d
INNER JOIN Inters i ON d.Id = i.DoctorId
WHERE d.Salary > ANY (SELECT Salary FROM Doctors)

--8 
SELECT Name
FROM Wards
WHERE Places > ALL (SELECT Places FROM Wards WHERE DepartmentId IN (SELECT Id FROM Departments WHERE Building = 3))

--9 
SELECT DISTINCT d.Name + ' ' + d.Surname AS FullName
FROM Doctors d
INNER JOIN DoctorsExaminations de ON d.Id = de.DoctorId
INNER JOIN Departments dp ON de.WardId = dp.Id
WHERE dp.Name IN ('Отделение терапии', 'Отделение онкологии')
  
--10 
SELECT DISTINCT d.Name
FROM Departments d
INNER JOIN Wards w ON w.DepartmentId = d.Id
LEFT JOIN (SELECT DoctorId FROM Inters UNION SELECT DoctorId FROM Professors) dp ON dp.DoctorId = ANY (SELECT Id FROM Doctors WHERE EXISTS (SELECT DepartmentId FROM Departments WHERE Departments.Id = w.DepartmentId)) 
WHERE dp.DoctorId IS NOT NULL

--11
SELECT d.Name + ' ' + d.Surname AS FullName, dp.Name AS DepartmentName
FROM Doctors d
INNER JOIN DoctorsExaminations de ON d.Id = de.DoctorId
INNER JOIN Departments dp ON de.WardId = dp.Id
WHERE dp.Financing > 20000

--12 
SELECT TOP 1 dp.Name
FROM DoctorsExaminations de
INNER JOIN Doctors d ON de.DoctorId = d.Id
INNER JOIN Departments dp ON de.WardId = dp.Id
ORDER BY d.Salary DESC

--13
SELECT d.Name, COUNT(de.Id) AS ExaminationCount
FROM Diseases d
LEFT JOIN DoctorsExaminations de ON d.Id = de.DiseaseId
GROUP BY d.Name