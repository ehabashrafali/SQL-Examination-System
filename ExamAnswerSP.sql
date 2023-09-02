Alter PROCEDURE ExamAnswer
    @ExamId INT,
    @st_id INT,
    @ques_id INT,
    @St_answer VARCHAR(10)
AS
BEGIN
    IF EXISTS (SELECT ID FROM Student WHERE ID = @st_id)
    BEGIN
        IF EXISTS (SELECT Ex_ID FROM Exam WHERE Ex_ID = @ExamId)
        BEGIN
            IF EXISTS (SELECT Que_ID FROM Question WHERE Que_ID = @ques_id)
            BEGIN

            UPDATE Ex_Qu_St
            SET St_ID = @st_id, St_Answer = @St_answer
            WHERE Ex_ID=@ExamId and Qu_ID= @ques_id;
            END
            ELSE
            BEGIN
                SELECT 'Question ID not found'
            END
        END
        ELSE
        BEGIN
            SELECT 'Please generate an Exam.'
        END
    END
    ELSE
    BEGIN
        SELECT 'Please Sign in as the student ID is not found'
    END

                select Ex_ID , Que_ID , Body , Ques_Mark 
                from Exam, Question  
                where Que_ID = @ques_id 
                and Ex_ID = @ExamId
END

 EXEC ExamAnswer 1222,10,17,'d'
