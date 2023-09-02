ALTER PROCEDURE GenerateExam 
    @ExamId INT,
    @courseName NVARCHAR(50),
    @NoOfMCQ INT,
    @NoOfTF INT,
    @duration INT
AS
BEGIN
    /* First, we need to check if an exam with the same ID already exists */
    IF EXISTS (SELECT Ex_ID FROM Exam WHERE Ex_ID = @ExamId)
    BEGIN
        SELECT 'There is already an exam with this ID.'
    END
    ELSE
    BEGIN
        /* Check if the course exists */
        IF EXISTS (SELECT Cr_ID FROM Course WHERE Name = @courseName)
        BEGIN
            DECLARE @Cr_id INT
            SELECT @Cr_id = Cr_ID 
            FROM Course
            WHERE Name = @courseName

            /* Insert exam details */
            INSERT INTO Exam (Ex_ID, No_MCQ, No_TF, Cr_ID, Duration)
            VALUES (@ExamId, @NoOfMCQ, @NoOfTF, @Cr_id, @duration)

            /* Insert MCQ questions */
            INSERT INTO Ex_Qu_St (Qu_ID, Ex_ID)
            SELECT TOP (@NoOfMCQ) Que_ID, @ExamId
            FROM Question Q , student
            WHERE Type = 'MCQ' AND Cr_ID = @Cr_id 
            ORDER BY NEWID()

            /* Insert True/False questions */
            INSERT INTO Ex_Qu_St (Qu_ID, Ex_ID)
            SELECT TOP (@NoOfTF) Que_ID, @ExamId
            FROM Question Q , student
            WHERE Type = 'T&F' AND Cr_ID = @Cr_id
            ORDER BY NEWID()



        END
        ELSE
        BEGIN
            SELECT 'This course is not found.'
        END
    END
    
    SELECT Ex_ID,Qu_ID, Body, Ques_Mark
    from Ex_Qu_St inner JOIN Question
    on Qu_ID = Que_ID 
    where Ex_ID = @ExamId
END



EXEC GenerateExam 1222, 'Java', 2, 2, 10


DELETE from Ex_Qu_St
DELETE from    Exam