-- SSRS SP
1--

ALTER PROCEDURE DepReport 
@deptid INT
as 
SELECT  S.* , T.NAME 
from student S INNER join track T
on T.ID = S.Tr_ID
where Tr_ID = @deptid

Exec DepReport 1

-----------------------------------------------------------------------------------------------------------------------------
2---

Alter PROCEDURE StudGrade
    @stid int
AS
BEGIN
    SELECT Sum ([St_Grade]) / (COUNT(Qu_Id) * 5) AS Student_Grade, Ex_ID
    FROM Ex_Qu_St
    WHERE St_ID = @stid
    GROUP BY Ex_ID;
END
-----------------------------------------------------------------------------------------------------------------------------
3---

ALTER PROCEDURE GetCrsIns
	@InsSSN INT
AS
BEGIN
	SELECT CI.Cr_ID, C.Name, CI.SSN, COUNT(St_ID) AS numbers_of_Students
	FROM Instructor I
	INNER JOIN Cr_Ins CI ON I.SSN = CI.SSN
	INNER JOIN Course C ON CI.Cr_ID = C.Cr_ID
	INNER JOIN Student_Course SC ON C.Cr_ID = SC.Cr_ID
	WHERE I.SSN = @InsSSN
	GROUP BY CI.Cr_ID, C.Name, CI.SSN;
END

Exec GetCrsIns 12345

-----------------------------------------------------------------------------------------------------------------------------
4---

CREATE PROCEDURE GetCrsTopics
	@Crsid INT

AS
 SELECT T.* 
 from topic T inner join Course C
 on T.Top_ID = C.Top_ID
 where C.Cr_ID  = @Crsid

 Exec GetCrsTopics 1

 -----------------------------------------------------------------------------------------------------------------------------
5---
CREATE PROCEDURE GetExamQues
	@ExamID int
AS

SELECT Q.body FROM Question Q
inner join Ex_Qu_St EQS ON Que_ID = Qu_ID and Q.Type='MCQ'
inner join Exam E ON E.Ex_ID = EQS.Ex_ID and E.Ex_ID = @ExamID

-----------------------------------------------------------------------------------------------------------------------------
6---

CREATE PROCEDURE GetExamQuesAns
	@ExamID int,
    @stid int
AS

SELECT Q.Body as Exam_questions, EQS.St_Answer as Student_Answers
FROM Question Q
INNER JOIN Ex_Qu_St EQS ON Q.Que_ID = EQS.Qu_ID AND EQS.St_ID = @stid
INNER JOIN Exam E ON EQS.Ex_ID = E.Ex_ID AND EQS.Ex_ID = @ExamID;
