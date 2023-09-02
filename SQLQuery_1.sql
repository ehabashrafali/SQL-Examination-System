-- Create Instructor table
CREATE TABLE Instructor (
    SSN INT PRIMARY KEY,
    Email VARCHAR(100),
    Ins_Lname VARCHAR(50),
    Ins_Fname VARCHAR(50),
    Phone_no VARCHAR(20)
);
-- Create track table
CREATE TABLE track (
    ID INT PRIMARY KEY,
    Name VARCHAR(50),
    SSN INT,
    FOREIGN KEY (SSN) REFERENCES Instructor(SSN)
);
-- Create Student table
CREATE TABLE Student (
    ID INT PRIMARY KEY,
    Password VARCHAR(100),
    St_Lname VARCHAR(50),
    St_Fname VARCHAR(50),
    Address VARCHAR(100),
    Phone_no VARCHAR(20),
    UserName VARCHAR(50),
    Tr_ID INT,
    FOREIGN KEY (Tr_ID) REFERENCES track(ID)
);

-- Insert sample data into Student table
INSERT INTO Student (ID, Password, St_Lname, St_Fname, Address, Phone_no, UserName, Tr_ID)
VALUES
    (1, 'password1', 'Doe', 'John', '123 Main St', '1234567890', 'johndoe', 1),
    (2, 'password2', 'Smith', 'Jane', '456 Elm St', '9876543210', 'janesmith', 2),
    (3, 'password3', 'Johnson', 'David', '789 Oak St', '5555555555', 'davidjohnson', 1);



-- Insert sample data into track table
INSERT INTO track (ID, Name, SSN)
VALUES
    (1, 'Computer Science', 12345),
    (2, 'Mathematics', 67890),
    (3, 'Physics', 54321);



-- Insert sample data into Instructor table
INSERT INTO Instructor (SSN, Email, Ins_Lname, Ins_Fname, Phone_no)
VALUES
    (12345, 'john.doe@example.com', 'Doe', 'John', '1234567890'),
    (67890, 'jane.smith@example.com', 'Smith', 'Jane', '9876543210'),
    (54321, 'david.johnson@example.com', 'Johnson', 'David', '5555555555');
-- Create topic table
CREATE TABLE topic (
    Top_ID INT PRIMARY KEY,
    Name VARCHAR(50)
);

-- Insert sample data into topic table
INSERT INTO topic (Top_ID, Name)
VALUES
    (1, 'Computer Science'),
    (2, 'Mathematics'),
    (3, 'Physics');

-- Create Course table
CREATE TABLE Course (
    Cr_ID INT PRIMARY KEY,
    Name VARCHAR(50),
    Duration INT,
    Top_ID INT,
    FOREIGN KEY (Top_ID) REFERENCES topic(Top_ID)
);

-- Insert sample data into Course table
INSERT INTO Course (Cr_ID, Name, Duration, Top_ID)
VALUES
    (1, 'Introduction to Programming', 12, 1),
    (2, 'Calculus I', 16, 2),
    (3, 'Mechanics', 10, 3);
-- Create Cr_Ins table
CREATE TABLE Cr_Ins (
    SSN INT,
    Cr_ID INT,
    PRIMARY KEY (SSN, Cr_ID),
    FOREIGN KEY (SSN) REFERENCES Instructor(SSN),
    FOREIGN KEY (Cr_ID) REFERENCES Course(Cr_ID)
);

-- Insert sample data into Cr_Ins table
INSERT INTO Cr_Ins (SSN, Cr_ID)
VALUES
    (12345, 1),
    (67890, 2),
    (54321, 3);

-- Create Exam table
CREATE TABLE Exam (
    Ex_ID INT PRIMARY KEY,
    Duration INT,
    Name VARCHAR(50),
    Cr_ID INT,
    FOREIGN KEY (Cr_ID) REFERENCES Course(Cr_ID)
);

-- Insert sample data into Exam table
INSERT INTO Exam (Ex_ID, Duration, Name, Cr_ID)
VALUES
    (1, 120, 'Midterm Exam', 1),
    (2, 90, 'Final Exam', 2),
    (3, 60, 'Quiz', 3);

-- Create Question table
CREATE TABLE Question (
    Que_ID INT PRIMARY KEY,
    Body VARCHAR(500),
    Type VARCHAR(50),
    Ques_Mark INT,
    Ques_Answer VARCHAR(500)
);

-- Insert sample data into Question table
INSERT INTO Question (Que_ID, Body, Type, Ques_Mark, Ques_Answer)
VALUES
    (1, 'What is the capital of France?', 'Multiple Choice', 5, 'Paris'),
    (2, 'Solve the equation x^2 - 9 = 0.', 'Short Answer', 10, 'x = ±3'),
    (3, 'State Newton''s first law of motion.', 'Essay', 15, 'An object at rest stays at rest, and an object in motion stays in motion with the same speed and in the same direction unless acted upon by an unbalanced force.');

-- Create Ex_Qu_St table
CREATE TABLE Ex_Qu_St (
    St_Answe VARCHAR(500),
    St_Grade INT,
    Qu_ID INT,
    Ex_ID INT,
    St_ID INT,
    PRIMARY KEY (Qu_ID, Ex_ID, St_ID),
    FOREIGN KEY (Qu_ID) REFERENCES Question(Que_ID),
    FOREIGN KEY (Ex_ID) REFERENCES Exam(Ex_ID),
    FOREIGN KEY (St_ID) REFERENCES Student(ID)
);

-- Insert sample data into Ex_Qu_St table
INSERT INTO Ex_Qu_St (St_Answe, St_Grade, Qu_ID, Ex_ID, St_ID)
VALUES
    ('Paris', 5, 1, 1, 1),
    ('London', 0, 1, 1, 2),
    ('Rome', 0, 1, 1, 3);

-- Create Student_Course table
CREATE TABLE Student_Course (
    St_ID INT,
    Cr_ID INT,
    PRIMARY KEY (St_ID, Cr_ID),
    FOREIGN KEY (St_ID) REFERENCES Student(ID),
    FOREIGN KEY (Cr_ID) REFERENCES Course(Cr_ID)
);

-- Insert sample data into Student_Course table
INSERT INTO Student_Course (St_ID, Cr_ID)
VALUES
    (1, 1),
    (2, 2),
    (3, 3);

-- Create Track_table
CREATE TABLE Track_table (
    Tr_ID INT,
    Cr_ID INT,
    PRIMARY KEY (Tr_ID, Cr_ID),
    FOREIGN KEY (Tr_ID) REFERENCES track(ID),
    FOREIGN KEY (Cr_ID) REFERENCES Course(Cr_ID)
);

-- Insert sample data into Track_table
INSERT INTO Track_table (Tr_ID, Cr_ID)
VALUES
    (1, 1),
    (2, 2),
    (3, 3);
