-------------------------------------
--JudicalDB
-------------------------------------


-------------------------------------
--Create Schemas
-------------------------------------
CREATE SCHEMA People
CREATE SCHEMA Cases
CREATE SCHEMA CourtManagement

-------------------------------------
--Create Tables
-------------------------------------

CREATE TABLE People.Person (
    person_id INT PRIMARY KEY IDENTITY(1,1),
    first_name NVARCHAR(20) NOT NULL,
    last_name NVARCHAR(20) NOT NULL,
    birth_date DATE,
    gender NVARCHAR(8) CHECK (gender IN ('Male', 'Female', 'Other')),
    national_id NVARCHAR(10) UNIQUE NOT NULL,
    phone NVARCHAR(15),
    email NVARCHAR(30),
    address NVARCHAR(200)
);

-------------------------------------

CREATE TABLE CourtManagement.Court (
    court_id INT PRIMARY KEY IDENTITY(1,1),
    name NVARCHAR(30) NOT NULL,
    location NVARCHAR(200),
    phone NVARCHAR(15)
);

-------------------------------------

CREATE TABLE People.Users (
    user_id INT PRIMARY KEY IDENTITY(1,1),
    person_id INT NOT NULL,
    username NVARCHAR(30) UNIQUE NOT NULL,
    password_hash NVARCHAR(255) NOT NULL,
    role NVARCHAR(50) CHECK (role IN ('Admin', 'Judge', 'Court_Staff', 'Clerk', 'IT_Admin', 'Prosecutor', 'Archivist')), --  ...
    is_active BIT DEFAULT 1,
    FOREIGN KEY (person_id) REFERENCES People.Person(person_id)
);

-------------------------------------

CREATE TABLE People.Judge (
    judge_id INT PRIMARY KEY IDENTITY(1,1),
    person_id INT NOT NULL,
    license_number NVARCHAR(20) UNIQUE NOT NULL,
    start_date DATE NOT NULL,
    specialization NVARCHAR(50),
    rank NVARCHAR(30),
    court_id INT,
    is_active BIT DEFAULT 1,
    FOREIGN KEY (person_id) REFERENCES People.Person(person_id),
    FOREIGN KEY (court_id) REFERENCES CourtManagement.Court(court_id)
);

--------------------------------------

CREATE TABLE People.Lawyer (
    lawyer_id INT PRIMARY KEY IDENTITY(1,1),
    person_id INT NOT NULL,
    license_number NVARCHAR(50) UNIQUE,
    issue_date DATE,
    status NVARCHAR(20) CHECK (status IN ('Active', 'Suspended', 'License Revoked', 'On Leave', 'Retired')),
    specializstion NVARCHAR(50),
    FOREIGN KEY (person_id) REFERENCES People.Person(person_id)
);

--------------------------------------

CREATE TABLE People.Defendant (
    defendant_id INT PRIMARY KEY IDENTITY(1,1),
    person_id INT NOT NULL,
    criminal_record NVARCHAR(MAX),
    status NVARCHAR(25) CHECK (status IN ('Under Investigation', 'Temporarily Released', 'Incarcerated', 'Fugitive', 'Free')),
    FOREIGN KEY (person_id) REFERENCES People.Person(person_id)
);

----------------------------------------

CREATE TABLE Cases.[Case] (
    case_id INT PRIMARY KEY IDENTITY(1,1),
    case_number NVARCHAR(30) UNIQUE NOT NULL,
    title NVARCHAR(200) NOT NULL,
    register_date DATE NOT NULL,
    case_type NVARCHAR(50) CHECK (case_type IN ('Criminal', 'Civil', 'Family', 'Financial', 'Administrative', 'Commercial', 'Constitutional')),
    status NVARCHAR(30) CHECK (status IN ('Under Review', 'In Progress', 'Suspended', 'Verdict Pending', 'Closed', 'Under Appeal', 'Referred to Higher Court')) ,
    court_id INT NOT NULL,
    judge_id INT,
    description NVARCHAR(MAX),
    priority NVARCHAR(20) CHECK (priority IN ('Normal', 'Urgent', 'Emergency', 'Sensitive')) DEFAULT 'Normal',
    FOREIGN KEY (court_id) REFERENCES CourtManagement.Court(court_id),
    FOREIGN KEY (judge_id) REFERENCES People.Judge(judge_id)
);

--------------------------------------

CREATE TABLE Cases.Party (
    party_id INT PRIMARY KEY IDENTITY(1,1),
    case_id INT NOT NULL,
    person_id INT,
    role NVARCHAR(20) CHECK (role IN ('Plaintiff', 'Defendant', 'Victim', 'Witness','Legal_Guardian', 'Representative', 'Expert')),
    FOREIGN KEY (case_id) REFERENCES Cases.[Case](case_id),
    FOREIGN KEY (person_id) REFERENCES People.Person(person_id)
);

---------------------------------------

CREATE TABLE CourtManagement.[Session] (
    session_id INT PRIMARY KEY IDENTITY(1,1),
    case_id INT NOT NULL,
    court_id INT NOT NULL,
    session_date DATE NOT NULL,
    start_time TIME NOT NULL,
    end_time TIME,
    notes NVARCHAR(MAX),
    is_completed BIT DEFAULT 0,
    FOREIGN KEY (case_id) REFERENCES Cases.[Case](case_id),
    FOREIGN KEY (court_id) REFERENCES CourtManagement.Court(court_id)
);

---------------------------------------

CREATE TABLE Cases.LawyerAssignment (
    assignment_id INT PRIMARY KEY IDENTITY(1,1),
    case_id INT NOT NULL,
    lawyer_id INT NOT NULL,
    client_id INT NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE,
    role NVARCHAR(20) CHECK (role IN ('Plaintiff_Lawyer', 'Defendant_Lawyer')),
    FOREIGN KEY (case_id) REFERENCES Cases.[Case](case_id),
    FOREIGN KEY (lawyer_id) REFERENCES People.Lawyer(lawyer_id),
    FOREIGN KEY (client_id) REFERENCES People.Person(person_id)
);

----------------------------------------

CREATE TABLE Cases.Judgment (
    judgment_id INT PRIMARY KEY IDENTITY(1,1),
    case_id INT NOT NULL,
    judge_id INT,
    issue_date DATE NOT NULL,
    verdict_text NVARCHAR(MAX) NOT NULL,
    type NVARCHAR(50) CHECK (type IN ('Acquittal', 'Settlement', 'Dismissal', 'Fine', 'Community_Service', 'Probation', 'Custodial_Sentence', 'Death_Penalty')),
    status NVARCHAR(20) CHECK (status IN ('Issued', 'Stay of Execution', 'Executed', 'Overturned', 'Under Appeal')),
    appeal_deadline DATE,
    FOREIGN KEY (case_id) REFERENCES Cases.[Case](case_id),
    FOREIGN KEY (judge_id) REFERENCES People.Judge(judge_id)
);

-----------------------------------------

CREATE TABLE Cases.Document (
    document_id INT PRIMARY KEY IDENTITY(1,1),
    case_id INT NOT NULL,
    document_type NVARCHAR(50) NOT NULL,
    file_path NVARCHAR(200) NOT NULL,
    uploaded_at DATETIME DEFAULT GETDATE(),
    description NVARCHAR(MAX),
    FOREIGN KEY (case_id) REFERENCES Cases.[Case](case_id)
);

-----------------------------------------

CREATE TABLE Cases.CaseHistory (
    history_id INT PRIMARY KEY IDENTITY(1,1),
    case_id INT NOT NULL,
    action_type NVARCHAR(20) CHECK (action_type IN ('Case_Creation', 'Status_Change', 'Judge_Assignment', 'Document_Upload', 'Verdict_Issued', 'Appeal_Filed', 'Party_Added', 'Note_Added')),
    action_date DATETIME DEFAULT GETDATE(),
    old_value NVARCHAR(100),
    new_value NVARCHAR(100),
    FOREIGN KEY (case_id) REFERENCES Cases.[Case](case_id)
);

------------------------------------------

CREATE TABLE Cases.Appeal (
    appeal_id INT PRIMARY KEY IDENTITY(1,1),
    case_id INT NOT NULL,
    appeal_date DATE NOT NULL,
    appeal_reason NVARCHAR(MAX) NOT NULL,
    status NVARCHAR(20) CHECK (status IN ('Pending', 'Under Review', 'Accepted',  'Rejected', 'Withdrawn', 'Closed')) DEFAULT 'Pending',
    court_id INT,
    result NVARCHAR(MAX),
    FOREIGN KEY (case_id) REFERENCES Cases.[Case](case_id),
    FOREIGN KEY (court_id) REFERENCES CourtManagement.Court(court_id)
);
