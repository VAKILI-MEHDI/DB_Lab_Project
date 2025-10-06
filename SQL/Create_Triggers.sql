-------------------------------------
--Create Trigger
-------------------------------------


CREATE OR ALTER TRIGGER trg_Case_Creation
ON Cases.[Case]
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO Cases.CaseHistory(case_id, action_type, new_value)
    SELECT
        i.case_id,
        'Case_Creation',
        i.case_number 
    FROM inserted i;
END;

----------------------------------------

CREATE OR ALTER TRIGGER trg_Case_StatusChange
ON Cases.[Case]
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO Cases.CaseHistory(case_id, action_type, old_value, new_value)
    SELECT
        i.case_id,
        'Status_Change',
        d.status,
        i.status
    FROM inserted i
    JOIN deleted  d ON i.case_id = d.case_id
    WHERE ISNULL(i.status,'') <> ISNULL(d.status,'');
END;

-----------------------------------------

CREATE OR ALTER TRIGGER trg_Case_JudgeAssignment
ON Cases.[Case]
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO Cases.CaseHistory(case_id, action_type, old_value, new_value)
    SELECT
        i.case_id,
        'Judge_Assignment',
        CAST(d.judge_id AS NVARCHAR(100)),
        CAST(i.judge_id AS NVARCHAR(100))
    FROM inserted i
    JOIN deleted  d ON i.case_id = d.case_id
    WHERE ISNULL(i.judge_id,-1) <> ISNULL(d.judge_id,-1);
END;

----------------------------------------

CREATE OR ALTER TRIGGER trg_Document_Upload
ON Cases.Document
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO Cases.CaseHistory(case_id, action_type, new_value)
    SELECT
        i.case_id,
        'Document_Upload',
        i.document_type
    FROM inserted i;
END;

---------------------------------------

CREATE OR ALTER TRIGGER trg_Verdict_Issued
ON Cases.Judgment
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO Cases.CaseHistory(case_id, action_type, new_value)
    SELECT
        i.case_id,
        'Verdict_Issued',
        i.type
    FROM inserted i;
END;

------------------------------------------

CREATE OR ALTER TRIGGER trg_Appeal_Filed
ON Cases.Appeal
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO Cases.CaseHistory(case_id, action_type, new_value)
    SELECT
        i.case_id,
        'Appeal_Filed',
        i.appeal_reason
    FROM inserted i;
END;

-----------------------------------------

CREATE OR ALTER TRIGGER trg_Party_Added
ON Cases.Party
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO Cases.CaseHistory(case_id, action_type, new_value)
    SELECT
        i.case_id,
        'Party_Added',
        i.role
    FROM inserted i;
END;

----------------------------------------

CREATE OR ALTER TRIGGER trg_Session_NoOverlap
ON CourtManagement.[Session]
AFTER INSERT, UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    IF EXISTS (
      SELECT 1
      FROM inserted i
      CROSS APPLY (
        SELECT
          i.session_id,
          i.court_id,
          i.case_id,
          i.session_date,
          i.start_time,
          i.end_time
      ) AS NewSession
      WHERE EXISTS (
        SELECT 1
        FROM CourtManagement.[Session] s
        WHERE s.session_id <> NewSession.session_id
          AND s.court_id = NewSession.court_id
          AND s.session_date = NewSession.session_date
          AND NOT (s.end_time <= NewSession.start_time OR s.start_time >= NewSession.end_time)
      )
      OR
      EXISTS (
        SELECT 1
        FROM Cases.[Case] c
        JOIN CourtManagement.[Session] s2
          ON c.case_id = s2.case_id
        WHERE c.judge_id = (
            SELECT judge_id FROM Cases.[Case] WHERE case_id = NewSession.case_id
          )
          AND s2.session_id <> NewSession.session_id
          AND s2.session_date = NewSession.session_date
          AND NOT (s2.end_time <= NewSession.start_time OR s2.start_time >= NewSession.end_time)
      )
      OR
      EXISTS (
        SELECT 1
        FROM Cases.LawyerAssignment la
        JOIN CourtManagement.[Session] s3
          ON la.case_id = s3.case_id
        WHERE la.case_id = NewSession.case_id
          AND la.lawyer_id IS NOT NULL
          AND s3.session_id <> NewSession.session_id
          AND s3.session_date = NewSession.session_date
          AND NOT (s3.end_time <= NewSession.start_time OR s3.start_time >= NewSession.end_time)
      )
      OR
      EXISTS (
        SELECT 1
        FROM Cases.Party pa
        JOIN CourtManagement.[Session] s4
          ON pa.case_id = s4.case_id
        WHERE pa.case_id = NewSession.case_id
          AND pa.person_id IS NOT NULL
          AND s4.session_id <> NewSession.session_id
          AND s4.session_date = NewSession.session_date
          AND NOT (s4.end_time <= NewSession.start_time OR s4.start_time >= NewSession.end_time)
      )
    )
    BEGIN
        RAISERROR('Session time conflict detected: overlaps with existing session for court, judge, lawyer or party.', 16, 1);
        ROLLBACK TRANSACTION;
        RETURN;
    END
END;
GO

----------------------------------------

CREATE OR ALTER TRIGGER trg_Judgment_AfterInsert_UpdateCaseStatus
ON Cases.Judgment
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;
    DECLARE @tmp TABLE (
        case_id INT,
        old_status NVARCHAR(30),
        new_status NVARCHAR(30)
    );

    UPDATE c
    SET
        c.status = CASE 
                      WHEN i.type IN ('Acquittal','Dismissal') THEN 'Closed'
                      ELSE 'Verdict Pending'
                   END
    OUTPUT
        inserted.case_id,
        deleted.status    AS old_status,
        inserted.status   AS new_status
    INTO @tmp(case_id, old_status, new_status)
    FROM Cases.[Case] AS c
    JOIN inserted AS i
      ON c.case_id = i.case_id;
END;
GO

----------------------------------------

CREATE OR ALTER TRIGGER trg_Session_NoteUpdated
ON CourtManagement.[Session]
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO Cases.CaseHistory(case_id, action_type, old_value, new_value)
    SELECT
        i.case_id,
        'Note_Added', 
        LEFT(d.notes, 100),
        LEFT(i.notes, 100)
    FROM inserted i
    JOIN deleted  d 
      ON i.session_id = d.session_id
    WHERE 
      ISNULL(i.notes, '') <> ISNULL(d.notes, '')  
      AND i.case_id IS NOT NULL;
END;
GO

-------------------------------------------

CREATE OR ALTER TRIGGER trg_Appeal_ValidateAndUpdateCase
ON Cases.Appeal
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;
    IF EXISTS (
      SELECT 1
      FROM inserted a
      JOIN Cases.Judgment j
        ON a.case_id = j.case_id
      WHERE a.appeal_date > j.appeal_deadline
    )
    BEGIN
        RAISERROR(
          'Cannot file appeal after the appeal_deadline specified in the judgment.', 
          16, 1
        );
        ROLLBACK TRANSACTION;
        RETURN;
    END
    UPDATE c
    SET c.status = 'Under Appeal'
    FROM Cases.[Case] c
    JOIN inserted a 
      ON c.case_id = a.case_id
    WHERE c.status <> 'Under Appeal';
END;
GO

---------------------------------------------
CREATE OR ALTER TRIGGER trg_LawyerAssignment_ValidateLawyerStatus
ON Cases.LawyerAssignment
AFTER INSERT, UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    IF EXISTS (
        SELECT 1
        FROM inserted la
        JOIN People.Lawyer l
          ON la.lawyer_id = l.lawyer_id
        WHERE l.status IN ('Suspended', 'License Revoked', 'On Leave', 'Retired')
    )
    BEGIN
        RAISERROR(
            'Cannot assign lawyer: the lawyer is not in Active status.',
            16, 1
        );
        ROLLBACK TRANSACTION;
    END
END;
GO

--------------------------------------------

CREATE OR ALTER TRIGGER trg_Case_ValidateJudgeActive
ON Cases.[Case]
AFTER INSERT, UPDATE
AS
BEGIN
    SET NOCOUNT ON;
    IF EXISTS (
        SELECT 1
        FROM inserted i
        JOIN People.Judge j
          ON i.judge_id = j.judge_id
        WHERE j.is_active <> 1  
          AND i.judge_id IS NOT NULL
    )
    BEGIN
        RAISERROR(
            'Cannot assign an inactive judge to a case. Please select an active judge.', 
            16, 1
        );
        ROLLBACK TRANSACTION;
        RETURN;
    END
END;
GO
-------------------------------------------------------
CREATE OR ALTER TRIGGER trg_PreventDelete_OpenCase
ON Cases.[Case]
INSTEAD OF DELETE
AS
BEGIN
  IF EXISTS (
    SELECT 1
    FROM deleted d
    WHERE d.status <> 'Closed'
  )
  BEGIN
    RAISERROR('Cannot delete a case unless its status is Closed.', 16, 1);
    RETURN;
  END;

  DELETE FROM Cases.[Case] WHERE case_id IN (SELECT case_id FROM deleted);
END;
-------------------------------------------
CREATE TRIGGER trg_ValidateCaseProgress
ON Cases.[Case]
AFTER UPDATE
AS
BEGIN
    IF EXISTS (
        SELECT 1
        FROM inserted i
        WHERE i.status = 'In Progress' AND i.judge_id IS NULL
    )
    BEGIN
        RAISERROR('Cannot set case to "In Progress" without assigning a judge.', 16, 1);
        ROLLBACK TRANSACTION;
    END
END;
-------------------------------------------
CREATE OR ALTER TRIGGER trg_Judge_Deactivation_ClearCases
ON People.Judge
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @Deactivated TABLE (judge_id INT);

    INSERT INTO @Deactivated(judge_id)
    SELECT i.judge_id
    FROM inserted i
    JOIN deleted d 
      ON i.judge_id = d.judge_id
    WHERE d.is_active = 1
      AND i.is_active = 0;

    UPDATE c
    SET 
      c.status   = 'Pending Assignment',
      c.judge_id = NULL
    FROM Cases.[Case] AS c
    JOIN @Deactivated AS d
      ON c.judge_id = d.judge_id
    WHERE c.status NOT IN ('Closed', 'Referred to Higher Court');
END;
GO
---------------------------------------
CREATE OR ALTER TRIGGER trg_LawyerStatus_EndAssignments
ON People.Lawyer
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @Changed TABLE (lawyer_id INT);

    INSERT INTO @Changed(lawyer_id)
    SELECT i.lawyer_id
    FROM inserted i
    JOIN deleted d 
      ON i.lawyer_id = d.lawyer_id
    WHERE 
      ISNULL(i.status,'') <> ISNULL(d.status,'')
      AND i.status IN ('Suspended', 'License Revoked', 'Retired');

    UPDATE la
    SET 
      la.end_date = CAST(GETDATE() AS DATE)
    FROM Cases.LawyerAssignment la
    JOIN @Changed c 
      ON la.lawyer_id = c.lawyer_id
    WHERE 
      la.end_date IS NULL 
      OR la.end_date > CAST(GETDATE() AS DATE);
END;
GO