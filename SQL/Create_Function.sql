-------------------------------------
--Create Function
-------------------------------------

CREATE FUNCTION Cases.fn_GetPersonSessions
(
  @person_id INT,
  @FromDate  DATE = NULL
)
RETURNS TABLE
AS
RETURN
(
  SELECT
    s.session_id,
    c.case_id,
    c.case_number,
    c.title AS case_title,
    crt.name AS court_name,
    s.session_date,
    s.start_time,
    s.end_time,
    s.is_completed,
    s.notes,
    pa.role AS person_role
  FROM CourtManagement.[Session] s
  JOIN Cases.[Case] c 
    ON s.case_id = c.case_id
  JOIN CourtManagement.Court crt 
    ON s.court_id = crt.court_id
  JOIN Cases.Party pa
    ON pa.case_id = s.case_id
   AND pa.person_id = @person_id
   AND pa.role IN ('Plaintiff','Defendant')
  WHERE (@FromDate IS NULL OR s.session_date >= @FromDate)
);

-----------------------------------------

CREATE FUNCTION Cases.fn_GetJudgeSchedule
(
  @judge_id INT,
  @FromDate  DATE = NULL
)
RETURNS TABLE
AS
RETURN
(
  SELECT
    s.session_id,
    c.case_id,
    c.case_number,
    c.title AS case_title,
    crt.name AS court_name,
    s.session_date,
    s.start_time,
    s.end_time,
    s.is_completed,
    s.notes
  FROM CourtManagement.[Session] s
  JOIN Cases.[Case] c 
    ON s.case_id = c.case_id
  JOIN CourtManagement.Court crt 
    ON s.court_id = crt.court_id
  WHERE c.judge_id = @judge_id AND
  (@FromDate IS NULL OR s.session_date >= @FromDate)
);

---------------------------------------

CREATE FUNCTION Cases.fn_GetLawyerSchedule
(
  @lawyer_id INT,
  @FromDate  DATE = NULL
)
RETURNS TABLE
AS
RETURN
(
  SELECT DISTINCT
    s.session_id,
    c.case_id,
    c.case_number,
    c.title AS case_title,
    crt.name AS court_name,
    s.session_date,
    s.start_time,
    s.end_time,
    s.is_completed,
    s.notes,
    la.role AS lawyer_role
  FROM Cases.LawyerAssignment la
  JOIN CourtManagement.[Session] s 
    ON la.case_id = s.case_id
  JOIN Cases.[Case] c 
    ON s.case_id = c.case_id
  JOIN CourtManagement.Court crt 
    ON s.court_id = crt.court_id
  WHERE la.lawyer_id = @lawyer_id
    AND (la.end_date IS NULL OR la.end_date >= CAST(GETDATE() AS DATE)) AND
    (@FromDate IS NULL OR s.session_date >= @FromDate)
);


---------------------------------------------

CREATE FUNCTION CourtManagement.fn_GetCourtSchedule
(
  @court_id  INT,
  @from_date DATE,
  @to_date   DATE
)
RETURNS TABLE
AS
RETURN
(
  SELECT
    s.session_id,
    c.case_id,
    c.case_number,
    c.title  AS case_title,
    CONCAT(jg_p.first_name, ' ', jg_p.last_name) AS judge_name,
    s.session_date,
    s.start_time,
    s.end_time,
    s.is_completed,
    s.notes
  FROM CourtManagement.[Session] s
  JOIN Cases.[Case] c 
    ON s.case_id = c.case_id
  JOIN People.Judge jg 
    ON c.judge_id = jg.judge_id
  JOIN People.Person jg_p 
    ON jg.person_id = jg_p.person_id
  WHERE s.court_id = @court_id
    AND s.session_date BETWEEN @from_date AND @to_date
);

----------------------------------------------

CREATE FUNCTION Cases.fn_GetCaseSessionHistory
(
  @case_id INT
)
RETURNS TABLE
AS
RETURN
(
  SELECT
    s.session_id,
    s.session_date,
    s.start_time,
    s.end_time,
    s.is_completed,
    s.notes
  FROM CourtManagement.[Session] s
  WHERE s.case_id = @case_id
);

---------------------------------------------

CREATE FUNCTION Cases.fn_GetCaseHistory
(
  @case_id INT
)
RETURNS TABLE
AS
RETURN
(
  SELECT
    history_id,
    action_type,
    action_date,
    old_value,
    new_value
  FROM Cases.CaseHistory
  WHERE case_id = @case_id
);

---------------------------------------------

CREATE FUNCTION Cases.fn_GetCaseLawyers
(
  @case_id INT
)
RETURNS TABLE
AS
RETURN
(
  SELECT
    la.assignment_id,
    la.lawyer_id,
    CONCAT(p.first_name, ' ', p.last_name) AS lawyer_name,
    la.role,
    la.start_date,
    la.end_date
  FROM Cases.LawyerAssignment la
  JOIN People.Lawyer lw ON la.lawyer_id = lw.lawyer_id
  JOIN People.Person p ON lw.person_id = p.person_id
  WHERE la.case_id = @case_id
);

---------------------------------------------

CREATE FUNCTION Cases.fn_GetActiveCasesForLawyer
(
  @lawyer_id INT
)
RETURNS TABLE
AS
RETURN
(
  SELECT
    c.case_id,
    c.case_number,
    c.title,
    c.register_date,
    c.status
  FROM Cases.LawyerAssignment la
  JOIN Cases.[Case] c 
    ON la.case_id = c.case_id
  WHERE la.lawyer_id = @lawyer_id
    AND (la.end_date IS NULL OR la.end_date >= CAST(GETDATE() AS DATE))
    AND c.status NOT IN ('Closed','Referred to Higher Court')
  GROUP BY
    c.case_id, c.case_number, c.title, c.register_date, c.status
);

-----------------------------------------------------

CREATE OR ALTER FUNCTION Cases.fn_GetActiveCasesForJudge
(
  @judge_id INT
)
RETURNS TABLE
AS
RETURN
(
  SELECT
    c.case_id,
    c.case_number,
    c.title,
    c.register_date,
    c.status
  FROM Cases.[Case] c
  WHERE c.judge_id = @judge_id
    AND c.status NOT IN ('Closed','Referred to Higher Court')
);

---------------------------------------------------------
CREATE OR ALTER FUNCTION People.fn_GetCriminalHistory
(
    @person_id INT
)
RETURNS TABLE
AS
RETURN
(
    SELECT
        MAX(d.defendant_id) AS defendant_id,
        MAX(p.first_name + ' ' + p.last_name) AS full_name,
        MAX(d.status) AS current_defendant_status,
        MAX(d.criminal_record) AS criminal_record,
        COUNT(DISTINCT pt.case_id) AS total_cases,
        COUNT(DISTINCT j.case_id) AS total_judged_cases,
        MAX(j.issue_date) AS last_judgment_date,
        MAX(j.type) AS last_judgment_type,
        MAX(j.status) AS last_judgment_status
    FROM People.Defendant d
    JOIN People.Person p ON d.person_id = p.person_id
    LEFT JOIN Cases.Party pt ON pt.person_id = d.person_id AND pt.role = 'Defendant'
    LEFT JOIN Cases.Judgment j ON pt.case_id = j.case_id
    WHERE d.person_id = @person_id
);

----------------------------------------------------------

CREATE OR ALTER FUNCTION People.fn_GetActiveLawyers()
RETURNS TABLE
AS
RETURN (
    SELECT
        l.lawyer_id,
        p.first_name + ' ' + p.last_name AS full_name,
        l.license_number,
        l.issue_date,
        l.status,
        l.specializstion,
        COUNT(DISTINCT la.case_id) AS active_case_count
    FROM People.Lawyer l
    JOIN People.Person p ON l.person_id = p.person_id
    LEFT JOIN Cases.LawyerAssignment la
        ON la.lawyer_id = l.lawyer_id
        AND (la.end_date IS NULL OR la.end_date >= CAST(GETDATE() AS DATE))
        AND la.start_date <= CAST(GETDATE() AS DATE)
    WHERE l.status = 'Active'
    GROUP BY
        l.lawyer_id,
        p.first_name,
        p.last_name,
        l.license_number,
        l.issue_date,
        l.status,
        l.specializstion
);

--------------------------------------------------

CREATE OR ALTER FUNCTION Cases.fn_GetCaseProcessingTime
(
    @case_id INT
)
RETURNS TABLE
AS
RETURN
(
    SELECT
        c.case_id,
        c.case_number,
        c.register_date,
        ISNULL(j.issue_date, CAST(GETDATE() AS DATE)) AS end_date,
        DATEDIFF(DAY, c.register_date, ISNULL(j.issue_date, GETDATE())) AS processing_days
    FROM Cases.[Case] c
    LEFT JOIN Cases.Judgment j ON c.case_id = j.case_id
    WHERE c.case_id = @case_id
);

-----------------------------------------------------

CREATE OR ALTER FUNCTION Cases.fn_GetCaseStatus
(
    @case_id INT
)
RETURNS TABLE
AS
RETURN
(
    SELECT
        c.case_id,
        c.case_number,
        c.title,
        c.register_date,
        c.status,
        c.priority,
        crt.name AS court_name,
        CONCAT(p.first_name, ' ', p.last_name) AS judge_name,
        MAX(s.session_date) AS last_session_date,
        j.issue_date AS judgment_date,
        j.status AS judgment_status
    FROM Cases.[Case] c
    LEFT JOIN CourtManagement.Court crt ON c.court_id = crt.court_id
    LEFT JOIN People.Judge jg ON c.judge_id = jg.judge_id
    LEFT JOIN People.Person p ON jg.person_id = p.person_id
    LEFT JOIN CourtManagement.[Session] s ON s.case_id = c.case_id
    LEFT JOIN Cases.Judgment j ON j.case_id = c.case_id
    WHERE c.case_id = @case_id
    GROUP BY
        c.case_id, c.case_number, c.title, c.register_date,
        c.status, c.priority, crt.name,
        p.first_name, p.last_name,
        j.issue_date, j.status
);
----------------------------------------------------
CREATE FUNCTION Cases.fn_SearchCases (
    @search_term NVARCHAR(100)
)
RETURNS TABLE
AS
RETURN (
    SELECT 
        case_id, case_number, title, register_date, status
    FROM Cases.[Case]
    WHERE case_number LIKE '%' + @search_term + '%'
       OR title LIKE '%' + @search_term + '%'
       OR status LIKE '%' + @search_term + '%'
);
---------------------------------------
CREATE FUNCTION People.fn_CalculateJudgePerformance(
    @judge_id INT,
    @from_date DATE,
    @to_date DATE
)
RETURNS TABLE
AS
RETURN (
    SELECT 
        j.judge_id,
        CONCAT(p.first_name, ' ', p.last_name) AS judge_name,
        COUNT(DISTINCT c.case_id) AS total_cases,
        SUM(CASE WHEN c.status = 'Closed' THEN 1 ELSE 0 END) AS closed_cases,
        AVG(DATEDIFF(DAY, c.register_date, jd.issue_date)) AS avg_resolution_days,
        SUM(CASE WHEN jd.type = 'Acquittal' THEN 1 ELSE 0 END) AS acquittals,
        SUM(CASE WHEN jd.type = 'Custodial_Sentence' THEN 1 ELSE 0 END) AS custodial_sentences,
        SUM(CASE WHEN a.appeal_id IS NOT NULL AND a.status = 'Accepted' THEN 1 ELSE 0 END) AS successful_appeals
    FROM People.Judge j
    JOIN People.Person p ON j.person_id = p.person_id
    LEFT JOIN Cases.[Case] c ON j.judge_id = c.judge_id
    LEFT JOIN Cases.Judgment jd ON c.case_id = jd.case_id
    LEFT JOIN Cases.Appeal a ON c.case_id = a.case_id AND a.status = 'Accepted'
    WHERE j.judge_id = @judge_id
    AND c.register_date BETWEEN @from_date AND @to_date
    GROUP BY j.judge_id, p.first_name, p.last_name
);
------------------------------------------
CREATE FUNCTION Cases.fn_GetCaseTimeline
(
    @case_id INT
)
RETURNS TABLE
AS
RETURN
(
    SELECT event_date, event_type, event_description
    FROM (
        SELECT 
            s.session_date AS event_date,
            'Court Session' AS event_type,
            CONCAT('Session: Start ', CONVERT(VARCHAR(5), s.start_time), 
                   ' to ', CONVERT(VARCHAR(5), s.end_time),
                   '. Notes: ', ISNULL(s.notes, 'No notes')) AS event_description
        FROM CourtManagement.[Session] s
        WHERE s.case_id = @case_id

        UNION ALL

        SELECT 
            ch.action_date AS event_date,
            'Case Update' AS event_type,
            CONCAT('Updated ', ch.action_type, ' from ', ISNULL(ch.old_value, 'Unknown'),
                   ' to ', ISNULL(ch.new_value, 'Unknown')) AS event_description
        FROM Cases.CaseHistory ch
        WHERE ch.case_id = @case_id

        UNION ALL

        SELECT 
            j.issue_date AS event_date,
            'Judgment Issuance' AS event_type,
            CONCAT('Judgment: ', j.type, '. Status: ', j.status) AS event_description
        FROM Cases.Judgment j
        WHERE j.case_id = @case_id

        UNION ALL

        SELECT 
            a.appeal_date AS event_date,
            'Appeal' AS event_type,
            CONCAT('Appeal Reason: ', a.appeal_reason, '. Status: ', a.status) AS event_description
        FROM Cases.Appeal a
        WHERE a.case_id = @case_id
    ) AS Timeline
);
------------------------------------------
CREATE FUNCTION Cases.fn_GetCaseAppealDeadlines
(
  @DaysAhead INT = 7  
)
RETURNS TABLE
AS
RETURN
(
  SELECT
    c.case_id,
    c.case_number,
    c.title,
    j.issue_date      AS judgment_date,
    j.appeal_deadline,
    DATEDIFF(DAY, CAST(GETDATE() AS DATE), j.appeal_deadline) AS days_until_deadline
  FROM Cases.Judgment j
  JOIN Cases.[Case] c 
    ON j.case_id = c.case_id
  WHERE j.appeal_deadline IS NOT NULL
    AND DATEDIFF(DAY, CAST(GETDATE() AS DATE), j.appeal_deadline) BETWEEN CASE WHEN @DaysAhead < 0 THEN @DaysAhead ELSE 0 END AND
        CASE WHEN @DaysAhead < 0 THEN 0 ELSE @DaysAhead END
);