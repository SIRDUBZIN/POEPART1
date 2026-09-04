
    CREATE DATABASE RaceDayDB;



/* =============================================
   DROP TABLES IF THEY ALREADY EXIST
   ============================================= */

IF OBJECT_ID('Results', 'U') IS NOT NULL
    DROP TABLE Results;

IF OBJECT_ID('Enrollments', 'U') IS NOT NULL
    DROP TABLE Enrollments;

IF OBJECT_ID('Categories', 'U') IS NOT NULL
    DROP TABLE Categories;

IF OBJECT_ID('Events', 'U') IS NOT NULL
    DROP TABLE Events;

IF OBJECT_ID('Users', 'U') IS NOT NULL
    DROP TABLE Users;

IF OBJECT_ID('Roles', 'U') IS NOT NULL
    DROP TABLE Roles;
GO


/* =============================================
   TABLE: Roles
   ============================================= */

CREATE TABLE Roles
(
    RoleID INT IDENTITY(1,1) PRIMARY KEY,
    RoleName VARCHAR(50) NOT NULL UNIQUE
);
GO


/* =============================================
   TABLE: Users
   ============================================= */

CREATE TABLE Users
(
    UserID INT IDENTITY(1,1) PRIMARY KEY,

    RoleID INT NOT NULL,

    FirstName VARCHAR(100) NOT NULL,

    LastName VARCHAR(100) NOT NULL,

    Email VARCHAR(150) NOT NULL UNIQUE,

    PasswordHash VARCHAR(255) NOT NULL,

    CreatedAt DATETIME NOT NULL DEFAULT GETDATE(),

    CONSTRAINT FK_Users_Roles
        FOREIGN KEY (RoleID)
        REFERENCES Roles(RoleID)
);
GO


/* =============================================
   TABLE: Events
   ============================================= */

CREATE TABLE Events
(
    EventID INT IDENTITY(1,1) PRIMARY KEY,

    OrganiserID INT NOT NULL,

    EventName VARCHAR(150) NOT NULL,

    Description VARCHAR(500) NOT NULL,

    EventDate DATETIME NOT NULL,

    Location VARCHAR(150) NOT NULL,

    Distance DECIMAL(6,2) NOT NULL,

    EventType VARCHAR(50) NOT NULL,

    CONSTRAINT CK_Events_EventType
        CHECK (EventType IN ('Run', 'Walk', 'Cycle')),

    CONSTRAINT CK_Events_Distance
        CHECK (Distance > 0),

    CONSTRAINT FK_Events_Users
        FOREIGN KEY (OrganiserID)
        REFERENCES Users(UserID)
);
GO


/* =============================================
   TABLE: Categories
   ============================================= */

CREATE TABLE Categories
(
    CategoryID INT IDENTITY(1,1) PRIMARY KEY,

    EventID INT NOT NULL,

    CategoryName VARCHAR(100) NOT NULL,

    Description VARCHAR(250) NULL,

    CONSTRAINT FK_Categories_Events
        FOREIGN KEY (EventID)
        REFERENCES Events(EventID)
        ON DELETE CASCADE
);
GO


/* =============================================
   TABLE: Enrollments
   ============================================= */

CREATE TABLE Enrollments
(
    EnrollmentID INT IDENTITY(1,1) PRIMARY KEY,

    ParticipantID INT NOT NULL,

    EventID INT NOT NULL,

    CategoryID INT NOT NULL,

    EnrollmentDate DATETIME NOT NULL
        DEFAULT GETDATE(),

    CONSTRAINT UQ_Enrollment
        UNIQUE (ParticipantID, EventID),

    CONSTRAINT FK_Enrollments_Users
        FOREIGN KEY (ParticipantID)
        REFERENCES Users(UserID),

    CONSTRAINT FK_Enrollments_Events
        FOREIGN KEY (EventID)
        REFERENCES Events(EventID),

    CONSTRAINT FK_Enrollments_Categories
        FOREIGN KEY (CategoryID)
        REFERENCES Categories(CategoryID)
);
GO


/* =============================================
   TABLE: Results
   ============================================= */

CREATE TABLE Results
(
    ResultID INT IDENTITY(1,1) PRIMARY KEY,

    EnrollmentID INT NOT NULL UNIQUE,

    FinishTime TIME NULL,

    FinishingPosition INT NULL,

    CONSTRAINT CK_Results_Position
        CHECK (FinishingPosition > 0),

    CONSTRAINT FK_Results_Enrollments
        FOREIGN KEY (EnrollmentID)
        REFERENCES Enrollments(EnrollmentID)
        ON DELETE CASCADE
);
GO


/* =============================================
   INSERT ROLES
   ============================================= */

INSERT INTO Roles (RoleName)
VALUES
('Organiser'),
('Participant');
GO


/* =============================================
   INSERT USERS
   Two Organisers
   Two Participants
   ============================================= */

INSERT INTO Users
(
    RoleID,
    FirstName,
    LastName,
    Email,
    PasswordHash
)
VALUES
(
    1,
    'John',
    'Smith',
    'john.smith@raceday.com',
    'HASHED_PASSWORD_001'
),
(
    1,
    'Sarah',
    'Mthembu',
    'sarah.mthembu@raceday.com',
    'HASHED_PASSWORD_002'
),
(
    2,
    'Sizwe',
    'Dlamini',
    'sizwe.dlamini@email.com',
    'HASHED_PASSWORD_003'
),
(
    2,
    'Thabo',
    'Nkosi',
    'thabo.nkosi@email.com',
    'HASHED_PASSWORD_004'
);
GO


/* =============================================
   INSERT EVENTS
   Minimum Three Events
   ============================================= */

INSERT INTO Events
(
    OrganiserID,
    EventName,
    Description,
    EventDate,
    Location,
    Distance,
    EventType
)
VALUES
(
    1,
    'Durban City Marathon',
    'A long-distance running event through Durban.',
    '2026-10-15 06:00:00',
    'Durban',
    42.20,
    'Run'
),
(
    1,
    'Umhlanga Fun Walk',
    'A community walking event for all fitness levels.',
    '2026-11-05 08:00:00',
    'Umhlanga',
    5.00,
    'Walk'
),
(
    2,
    'KZN Cycling Challenge',
    'A competitive cycling race across KwaZulu-Natal.',
    '2026-12-01 06:30:00',
    'Richards Bay',
    50.00,
    'Cycle'
);
GO


/* =============================================
   INSERT CATEGORIES
   Categories for Each Event
   ============================================= */

INSERT INTO Categories
(
    EventID,
    CategoryName,
    Description
)
VALUES

-- Event 1
(1, 'Under 20', 'Participants younger than 20 years old'),
(1, 'Senior', 'Adult participants'),
(1, 'Veteran', 'Experienced senior participants'),

-- Event 2
(2, 'Under 20', 'Young participants'),
(2, 'Senior', 'Adult participants'),
(2, 'Open', 'Open category for all participants'),

-- Event 3
(3, 'Junior', 'Young cycling participants'),
(3, 'Senior', 'Adult cycling participants'),
(3, 'Elite', 'Competitive cycling participants');
GO


/* =============================================
   INSERT ENROLLMENTS
   Sample Enrollments
   ============================================= */

INSERT INTO Enrollments
(
    ParticipantID,
    EventID,
    CategoryID
)
VALUES
(
    3,
    1,
    2
),
(
    4,
    2,
    5
),
(
    3,
    3,
    8
);
GO


/* =============================================
   INSERT RESULTS
   ============================================= */

INSERT INTO Results
(
    EnrollmentID,
    FinishTime,
    FinishingPosition
)
VALUES
(
    1,
    '03:45:30',
    15
),
(
    2,
    '00:48:20',
    8
);
GO


/* =============================================
   VIEW ALL DATA
   ============================================= */

SELECT * FROM Roles;
SELECT * FROM Users;
SELECT * FROM Events;
SELECT * FROM Categories;
SELECT * FROM Enrollments;
SELECT * FROM Results;
GO