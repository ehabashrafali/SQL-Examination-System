ALTER PROCEDURE CorrectExam  
    @ExamId INT, 
    @st_id INT    
AS
BEGIN
    IF EXISTS (SELECT Ex_ID FROM Ex_Qu_St WHERE Ex_ID = @ExamId)
    BEGIN
        IF EXISTS (SELECT St_ID FROM Ex_Qu_St WHERE St_ID = @st_id)
        BEGIN
            DECLARE @ques_id INT;
            DECLARE @i INT;
            SET @i = 0;
            WHILE @i <= (SELECT COUNT(St_Answer) FROM Ex_Qu_St WHERE Ex_ID = @ExamId)
            BEGIN 
                IF (SELECT St_Answer FROM Ex_Qu_St WHERE Qu_ID = @ques_id) = (SELECT Ques_Answer FROM Question WHERE  Que_ID = @ques_id)
                BEGIN
                    UPDATE Ex_Qu_St
                    SET St_Grade += 5
                    WHERE Qu_ID = @ques_id
                END
                
                SET @i = @i + 1;
            END
            
            DECLARE @Total_StGrade INT;
            SELECT @Total_StGrade = SUM(St_Grade) 
            FROM Ex_Qu_St
            WHERE St_ID = @st_id AND Ex_ID = @ExamId;

            select @Total_StGrade as Student_Result
            END
            ELSE
            BEGIN
                    SELECT 'Please Sign in as the student ID is not found'

            END
    END
    ELSE
    BEGIN
        SELECT 'Please create an Exam as the Exam ID is not found.'

    END

END

EXEC CorrectExam 110,10
