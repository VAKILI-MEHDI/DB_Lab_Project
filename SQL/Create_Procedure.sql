-------------------------------------
--Create Procedure
-------------------------------------

CREATE OR ALTER PROCEDURE People.sp_InsertPerson
  @first_name NVARCHAR(20),
  @last_name  NVARCHAR(20),
  @birth_date DATE         = NULL,
  @gender     NVARCHAR(8),
  @national_id NVARCHAR(10),
  @phone      NVARCHAR(15) = NULL,
  @email      NVARCHAR(30) = NULL,
  @address    NVARCHAR(200)= NULL,
  @new_person_id INT       OUTPUT
AS
BEGIN
  INSERT INTO People.Person (first_name, last_name, birth_date, gender, national_id, phone, email, address)
  VALUES (@first_name, @last_name, @birth_date, @gender, @national_id, @phone, @email, @address);

  SET @new_person_id = SCOPE_IDENTITY();
END;
GO

-----------------------------------------

CREATE OR ALTER PROCEDURE CourtManagement.sp_InsertCourt
  @name     NVARCHAR(30),
  @location NVARCHAR(200)=NULL,
  @phone    NVARCHAR(15) =NULL
AS
BEGIN
  INSERT INTO CourtManagement.Court (name, location, phone)
  VALUES (@name, @location, @phone);

END;
GO

-----------------------------------------

-- CREATE OR ALTER PROCEDURE People.sp_InsertUser
--   @person_id    INT,
--   @username     NVARCHAR(30),
--   @password_hash NVARCHAR(255),
--   @role         NVARCHAR(50),
--   @is_active    BIT       = 1,
--   @new_user_id  INT       OUTPUT
-- AS
-- BEGIN
--   INSERT INTO People.Users (person_id, username, password_hash, role, is_active)
--   VALUES (@person_id, @username, @password_hash, @role, @is_active);

--   SET @new_user_id = SCOPE_IDENTITY();
-- END;
-- GO

-----------------------------------------

CREATE OR ALTER PROCEDURE People.sp_InsertJudge
  @person_id      INT,
  @license_number NVARCHAR(20),
  @start_date     DATE,
  @specialization NVARCHAR(50)=NULL,
  @rank           NVARCHAR(30)=NULL,
  @court_id       INT        =NULL,
  @is_active      BIT        = 1
AS
BEGIN
  INSERT INTO People.Judge (person_id, license_number, start_date, specialization, rank, court_id, is_active)
  VALUES (@person_id, @license_number, @start_date, @specialization, @rank, @court_id, @is_active);

END;
GO

-------------------------------------------

CREATE OR ALTER PROCEDURE People.sp_InsertLawyer
  @person_id       INT,
  @license_number  NVARCHAR(50),
  @issue_date      DATE,
  @status          NVARCHAR(20),
  @specializstion  NVARCHAR(50)=NULL
AS
BEGIN
  INSERT INTO People.Lawyer (person_id, license_number, issue_date, status, specializstion)
  VALUES (@person_id, @license_number, @issue_date, @status, @specializstion);

END;
GO

-------------------------------------------

CREATE OR ALTER PROCEDURE People.sp_InsertDefendant
  @person_id       INT,
  @criminal_record NVARCHAR(MAX)=NULL,
  @status          NVARCHAR(25)
AS
BEGIN
  INSERT INTO People.Defendant (person_id, criminal_record, status)
  VALUES (@person_id, @criminal_record, @status);

END;
GO

----------------------------------------

CREATE OR ALTER PROCEDURE Cases.sp_InsertCase
  @case_number   NVARCHAR(30),
  @title         NVARCHAR(200),
  @register_date DATE,
  @case_type     NVARCHAR(50),
  @status        NVARCHAR(30),
  @court_id      INT,
  @judge_id      INT    = NULL,
  @description   NVARCHAR(MAX)=NULL,
  @priority      NVARCHAR(20)  ='Normal'
AS
BEGIN
  INSERT INTO Cases.[Case]
    (case_number, title, register_date, case_type, status, court_id, judge_id, description, priority)
  VALUES
    (@case_number, @title, @register_date, @case_type, @status, @court_id, @judge_id, @description, @priority);
END;
GO

----------------------------------------

CREATE OR ALTER PROCEDURE Cases.sp_InsertParty
  @case_id   INT,
  @person_id INT,
  @role      NVARCHAR(20)
AS
BEGIN
  INSERT INTO Cases.Party (case_id, person_id, role)
  VALUES (@case_id, @person_id, @role);
END;
GO

-----------------------------------------

CREATE OR ALTER PROCEDURE CourtManagement.sp_InsertSession
  @case_id      INT,
  @court_id     INT,
  @session_date DATE,
  @start_time   TIME,
  @end_time     TIME      = NULL,
  @notes        NVARCHAR(MAX)=NULL,
  @is_completed BIT         = 0
AS
BEGIN
  INSERT INTO CourtManagement.[Session]
    (case_id, court_id, session_date, start_time, end_time, notes, is_completed)
  VALUES
    (@case_id, @court_id, @session_date, @start_time, @end_time, @notes, @is_completed);
END;
GO

-----------------------------------------

CREATE OR ALTER PROCEDURE Cases.sp_InsertLawyerAssignment
  @case_id    INT,
  @lawyer_id  INT,
  @client_id  INT,
  @start_date DATE,
  @end_date   DATE    = NULL,
  @role       NVARCHAR(20)
AS
BEGIN
  INSERT INTO Cases.LawyerAssignment (case_id, lawyer_id, client_id, start_date, end_date, role)
  VALUES (@case_id, @lawyer_id, @client_id, @start_date, @end_date, @role);  
END;
GO

-----------------------------------------

CREATE OR ALTER PROCEDURE Cases.sp_InsertJudgment
  @case_id       INT,
  @judge_id      INT       = NULL,
  @issue_date    DATE,
  @verdict_text  NVARCHAR(MAX),
  @type          NVARCHAR(50),
  @status        NVARCHAR(20),
  @appeal_deadline DATE    = NULL
AS
BEGIN
  INSERT INTO Cases.Judgment
    (case_id, judge_id, issue_date, verdict_text, type, status, appeal_deadline)
  VALUES
    (@case_id, @judge_id, @issue_date, @verdict_text, @type, @status, @appeal_deadline);
END;
GO

---------------------------------------------

CREATE OR ALTER PROCEDURE Cases.sp_InsertDocument
  @case_id       INT,
  @document_type NVARCHAR(50),
  @file_path     NVARCHAR(200),
  @uploaded_at   DATETIME = NULL,
  @description   NVARCHAR(MAX)=NULL
AS
BEGIN
  INSERT INTO Cases.Document
    (case_id, document_type, file_path, uploaded_at, description)
  VALUES
    (@case_id, @document_type, @file_path, ISNULL(@uploaded_at, GETDATE()), @description);
END;
GO

---------------------------------------------

CREATE OR ALTER PROCEDURE Cases.sp_InsertAppeal
  @case_id       INT,
  @appeal_date   DATE,
  @appeal_reason NVARCHAR(MAX),
  @status        NVARCHAR(20) = 'Pending',
  @court_id      INT         = NULL,
  @result        NVARCHAR(MAX)=NULL
AS
BEGIN
  INSERT INTO Cases.Appeal
    (case_id, appeal_date, appeal_reason, status, court_id, result)
  VALUES
    (@case_id, @appeal_date, @appeal_reason, @status, @court_id, @result);
END;
GO
--------------------------------------------------------
CREATE OR ALTER PROCEDURE People.sp_SetJudgeActiveStatus
  @judge_id   INT,
  @is_active  BIT
AS
BEGIN
  SET NOCOUNT ON;

  DECLARE @old_active BIT;
  SELECT @old_active = is_active
    FROM People.Judge
   WHERE judge_id = @judge_id;

  IF @old_active IS NULL
  BEGIN
    RAISERROR('Judge ID %d not found.', 16, 1, @judge_id);
    RETURN;
  END

  IF @old_active = @is_active
  BEGIN
    RETURN;
  END

  UPDATE People.Judge
  SET is_active = @is_active
  WHERE judge_id = @judge_id;

END;
GO


------------------------------------------------------
CREATE OR ALTER PROCEDURE People.sp_UpdateLawyerStatus
  @lawyer_id  INT,
  @new_status NVARCHAR(20),
  @reason     NVARCHAR(200) = NULL
AS
BEGIN
  SET NOCOUNT ON;

  DECLARE @old_status NVARCHAR(20);
  SELECT @old_status = status
    FROM People.Lawyer
   WHERE lawyer_id = @lawyer_id;

  IF @old_status IS NULL
  BEGIN
    RAISERROR('Lawyer ID %d not found.', 16, 1, @lawyer_id);
    RETURN;
  END

  IF @old_status = @new_status
  BEGIN
    RETURN;
  END

  UPDATE People.Lawyer
  SET status = @new_status
  WHERE lawyer_id = @lawyer_id;
END;
GO
------------------------------------------------------
CREATE OR ALTER PROCEDURE People.sp_AddPersonPhone
(
    @person_id INT,
    @phone     NVARCHAR(15),
    @phone_type NVARCHAR(20) = 'Mobile'
)
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO People.PersonPhone (person_id, phone, phone_type)
    VALUES (@person_id, @phone, @phone_type);
END;
GO
--------------------------------------------------
CREATE OR ALTER PROCEDURE People.sp_AddPersonEmail
(
    @person_id INT,
    @email     NVARCHAR(100),
    @email_type NVARCHAR(20) = 'Personal'
)
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO People.PersonEmail (person_id, email, email_type)
    VALUES (@person_id, @email, @email_type);
END;
GO