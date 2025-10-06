-------------------------------------
--Create Viow
-------------------------------------


CREATE VIEW vw_JudgeCurrentCases
AS
SELECT
  jg.judge_id,
  CONCAT(p.first_name, ' ', p.last_name) AS judge_name,
  c.case_id,
  c.case_number,
  c.title,
  c.status
FROM Cases.[Case] c
  JOIN People.Judge jg     ON c.judge_id = jg.judge_id
  JOIN People.Person p     ON jg.person_id = p.person_id
WHERE c.status NOT IN ('Closed','Referred to Higher Court');

----------------------------------------------------------

CREATE VIEW vw_CaseOverview
AS
SELECT
  c.case_id,
  c.case_number,
  c.title,
  c.register_date,
  c.case_type,
  c.status,
  c.priority,
  crt.name     AS court_name,
  CONCAT(jg_person.first_name, ' ', jg_person.last_name) AS judge_name,
  COUNT(s.session_id) AS total_sessions,
  MAX(s.session_date)  AS last_session_date,
  Parties.PartiesList,
  Lawyers.LawyersList
FROM Cases.[Case] c
  JOIN CourtManagement.Court crt 
    ON c.court_id = crt.court_id

  LEFT JOIN People.Judge jg      
    ON c.judge_id = jg.judge_id
  LEFT JOIN People.Person jg_person 
    ON jg.person_id = jg_person.person_id

  LEFT JOIN CourtManagement.[Session] s 
    ON c.case_id = s.case_id
  OUTER APPLY (
    SELECT STRING_AGG(CONCAT(p.first_name, ' ', p.last_name), '; ') 
           WITHIN GROUP (ORDER BY pa.party_id) AS PartiesList
    FROM Cases.Party pa
      JOIN People.Person p 
        ON pa.person_id = p.person_id
    WHERE pa.case_id = c.case_id
  ) AS Parties
  OUTER APPLY (
    SELECT STRING_AGG(CONCAT(lp.first_name, ' ', lp.last_name), '; ')
           WITHIN GROUP (ORDER BY la.assignment_id) AS LawyersList
    FROM Cases.LawyerAssignment la
      JOIN People.Person lp 
        ON la.lawyer_id = lp.person_id 
    WHERE la.case_id = c.case_id
      AND (la.end_date IS NULL OR la.end_date >= CAST(GETDATE() AS DATE))
  ) AS Lawyers
GROUP BY
  c.case_id, c.case_number, c.title, c.register_date,
  c.case_type, c.status, c.priority,
  crt.name, jg_person.first_name, jg_person.last_name,
  Parties.PartiesList,
  Lawyers.LawyersList;

-----------------------------------------------

CREATE VIEW vw_CaseSummary 
AS
SELECT 
    c.case_id,
    c.case_number,
    c.title,
    c.register_date,
    c.case_type,
    c.status,
    c.priority,
    ct.name AS court_name,
    CONCAT(p.first_name, ' ', p.last_name) AS judge_fullname
FROM Cases.[Case] c
JOIN CourtManagement.Court ct
    ON c.court_id = ct.court_id
LEFT JOIN People.Judge j
    ON c.judge_id = j.judge_id
LEFT JOIN People.Person p
    ON j.person_id = p.person_id;
GO

-----------------------------------------------

CREATE VIEW vw_JudgmentSummary
AS
SELECT
  j.judgment_id,
  c.case_number,
  c.title,
  CONCAT(p.first_name, ' ', p.last_name) AS judge_name,
  j.issue_date,
  j.type       AS judgment_type,
  j.status     AS execution_status,
  j.appeal_deadline
FROM Cases.Judgment j
  JOIN Cases.[Case] c     ON j.case_id = c.case_id
  LEFT JOIN People.Judge jg ON j.judge_id = jg.judge_id
  LEFT JOIN People.Person p ON jg.person_id = p.person_id;


  ------------------------------------------------

CREATE VIEW vw_CourtSessions
AS
SELECT
  s.session_id,
  c.case_number,
  c.title,
  crt.name      AS court_name,
  s.session_date,
  s.start_time,
  s.end_time,
  s.is_completed,
  s.notes
FROM CourtManagement.[Session] s
  JOIN Cases.[Case] c       ON s.case_id = c.case_id
  JOIN CourtManagement.Court crt ON s.court_id = crt.court_id;

---------------------------------------------------

CREATE VIEW vw_LawyersWithCases
AS
SELECT
  la.assignment_id,
  c.case_number,
  c.title,
  CONCAT(p.first_name, ' ', p.last_name) AS lawyer_name,
  la.role,
  la.start_date,
  la.end_date
FROM Cases.LawyerAssignment la
  JOIN Cases.[Case] c       ON la.case_id = c.case_id
  JOIN People.Lawyer lw     ON la.lawyer_id = lw.lawyer_id
  JOIN People.Person p      ON lw.person_id = p.person_id;

----------------------------------------------------

CREATE VIEW vw_AppealDetails
AS
SELECT
  a.appeal_id,
  c.case_number,
  c.title,
  a.appeal_date,
  a.appeal_reason,
  a.status    AS appeal_status,
  crt.name    AS appeal_court,
  a.result
FROM Cases.Appeal a
  JOIN Cases.[Case] c        ON a.case_id = c.case_id
  LEFT JOIN CourtManagement.Court crt ON a.court_id = crt.court_id;

--------------------------------------------------------

CREATE VIEW vw_LawyersStatus
AS
SELECT
  lw.lawyer_id,
  CONCAT(p.first_name, ' ', p.last_name) AS lawyer_name,
  lw.license_number,
  lw.issue_date,
  lw.status               AS license_status,
  lw.specializstion       AS specialization,
  ISNULL(C.active_cases, 0) AS active_case_count,
  C.last_assignment_date
FROM People.Lawyer lw
  JOIN People.Person p
    ON lw.person_id = p.person_id
  LEFT JOIN (
    SELECT
      la.lawyer_id,
      COUNT(*) AS active_cases,
      MAX(la.start_date) AS last_assignment_date
    FROM Cases.LawyerAssignment la
    WHERE la.end_date IS NULL OR la.end_date >= CAST(GETDATE() AS DATE)
    GROUP BY la.lawyer_id
  ) AS C
    ON lw.lawyer_id = C.lawyer_id;

---------------------------------------------------------

CREATE VIEW vw_JudgesStatus
AS
SELECT
  jg.judge_id,
  CONCAT(p.first_name, ' ', p.last_name) AS judge_name,
  jg.license_number,
  jg.start_date            AS appointment_date,
  jg.specialization,
  jg.rank,
  jg.is_active,
  ISNULL(A.active_cases, 0) AS active_case_count,
  A.avg_resolution_days
FROM People.Judge jg
  JOIN People.Person p
    ON jg.person_id = p.person_id
  LEFT JOIN (
    SELECT
      c.judge_id,
      COUNT(*) AS active_cases,
      AVG(DATEDIFF(DAY, c.register_date, j.issue_date)) AS avg_resolution_days
    FROM Cases.[Case] c
      JOIN Cases.Judgment j
        ON c.case_id = j.case_id
    WHERE c.judge_id IS NOT NULL
      AND c.status = 'Closed'
      AND j.judge_id = c.judge_id
    GROUP BY c.judge_id
  ) AS A
    ON jg.judge_id = A.judge_id;


-------------------------------------------------------

CREATE OR ALTER VIEW vw_DefendantsOverview
AS
SELECT
  df.defendant_id,
  CONCAT(p.first_name, ' ', p.last_name) AS defendant_name,
  df.status AS defendant_status,
  CASE 
    WHEN df.criminal_record IS NULL 
      OR df.criminal_record = ''
    THEN 0 
    ELSE 1 
  END  AS has_prior_record,
  ISNULL(Summary.case_count, 0) AS total_cases,
  Latest.latest_case_number,
  Latest.latest_case_status

FROM People.Defendant df
JOIN People.Person p
  ON df.person_id = p.person_id
LEFT JOIN (
  SELECT
    pa.person_id,
    COUNT(DISTINCT pa.case_id) AS case_count,
    MAX(c.register_date) AS latest_register_date
  FROM Cases.Party pa
  JOIN Cases.[Case] c
    ON pa.case_id = c.case_id
  WHERE pa.role = 'Defendant'
  GROUP BY pa.person_id
) AS Summary
  ON df.person_id = Summary.person_id
LEFT JOIN (
  SELECT
    pa.person_id,
    c.case_number   AS latest_case_number,
    c.status  AS latest_case_status,
    ROW_NUMBER() OVER (PARTITION BY pa.person_id ORDER BY c.register_date DESC) AS rn
  FROM Cases.Party pa
  JOIN Cases.[Case] c
    ON pa.case_id = c.case_id
  WHERE pa.role = 'Defendant'
) AS Latest
  ON df.person_id = Latest.person_id
  AND Latest.rn = 1
GROUP BY
  df.defendant_id,
  p.first_name, p.last_name,
  df.status, df.criminal_record,
  Summary.case_count,
  Latest.latest_case_number,
  Latest.latest_case_status  
;
--------------------------------------------
CREATE VIEW vw_PendingJudgments
AS
SELECT 
    j.judgment_id,
    c.case_number,
    c.title,
    CONCAT(p.first_name, ' ', p.last_name) AS judge_name,
    j.issue_date,
    j.type AS judgment_type,
    j.status
FROM Cases.Judgment j
JOIN Cases.[Case] c ON j.case_id = c.case_id
JOIN People.Judge jg ON j.judge_id = jg.judge_id
JOIN People.Person p ON jg.person_id = p.person_id
WHERE j.status IN ('Issued', 'Stay of Execution');
----------------------------------------
CREATE VIEW vw_UpcomingSessions
AS
SELECT 
    s.session_id,
    c.case_number,
    c.title,
    crt.name AS court_name,
    s.session_date,
    s.start_time,
    s.end_time
FROM CourtManagement.[Session] s
JOIN Cases.[Case] c ON s.case_id = c.case_id
JOIN CourtManagement.Court crt ON s.court_id = crt.court_id
WHERE s.session_date >= CAST(GETDATE() AS DATE)
ORDER BY s.session_date;
----------------------------------------
CREATE VIEW vw_CourtStatistics
AS
SELECT
    crt.court_id,
    crt.name AS court_name,
    COUNT(DISTINCT c.case_id) AS total_cases,
    SUM(CASE WHEN c.status = 'Closed' THEN 1 ELSE 0 END) AS closed_cases,
    AVG(DATEDIFF(DAY, c.register_date, ISNULL(j.issue_date, GETDATE()))) AS avg_processing_days,
    COUNT(DISTINCT s.session_id) AS total_sessions,
    COUNT(DISTINCT jg.judge_id) AS assigned_judges
FROM CourtManagement.Court crt
LEFT JOIN Cases.[Case] c ON crt.court_id = c.court_id
LEFT JOIN Cases.Judgment j ON c.case_id = j.case_id
LEFT JOIN CourtManagement.[Session] s ON c.case_id = s.case_id
LEFT JOIN People.Judge jg ON crt.court_id = jg.court_id
GROUP BY crt.court_id, crt.name;