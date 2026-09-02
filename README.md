# POEPART1
# RaceDay System

## Database Design and API Planning

### Project Overview

The RaceDay System is designed to manage sporting events such as running races, walking events, and cycling competitions. The system allows organisers to create and manage events, while participants can register for events, select categories, and view their results.

This repository contains the database design and planning documentation for **Part 1** of the RaceDay System project.

The main purpose of this part of the project is to design a properly structured relational database that supports the main functionality of the RaceDay System. The project also includes an Entity Relationship Diagram (ERD), SQL Server database implementation, sample data, and an API endpoint plan.

---

# Project Features

The RaceDay System supports the following functionality:

* User registration and management
* Role-based users
* Organiser accounts
* Participant accounts
* Event creation and management
* Event categories
* Participant enrollment
* Event result management
* Finishing positions
* Finish time recording

---

# Technologies Used

The following technologies are used in this project:

* Microsoft SQL Server
* SQL Server Management Studio (SSMS)
* SQL
* REST API design principles
* Entity Relationship Diagram (ERD)

---

# Database Name

```text
RaceDayDB
```

---

# Database Structure

The database contains the following six main tables:

1. Roles
2. Users
3. Events
4. Categories
5. Enrollments
6. Results

---

# Entity Descriptions

## 1. Roles

The Roles table stores the different types of users in the system.

### Fields

| Field    | Description              |
| -------- | ------------------------ |
| RoleID   | Primary key for the role |
| RoleName | Name of the role         |

### Available Roles

* Organiser
* Participant

---

## 2. Users

The Users table stores information about all users registered in the RaceDay System.

### Fields

| Field        | Description                            |
| ------------ | -------------------------------------- |
| UserID       | Primary key for the user               |
| RoleID       | Foreign key linking the user to a role |
| FirstName    | User's first name                      |
| LastName     | User's last name                       |
| Email        | User's email address                   |
| PasswordHash | User's password hash                   |
| CreatedAt    | Date and time the account was created  |

A user can either be an **Organiser** or a **Participant**.

---

## 3. Events

The Events table stores information about sporting events created by organisers.

### Fields

| Field       | Description                                   |
| ----------- | --------------------------------------------- |
| EventID     | Primary key for the event                     |
| OrganiserID | Foreign key linking the event to an organiser |
| EventName   | Name of the event                             |
| Description | Description of the event                      |
| EventDate   | Date and time of the event                    |
| Location    | Event location                                |
| Distance    | Event distance                                |
| EventType   | Type of sporting event                        |

### Supported Event Types

* Run
* Walk
* Cycle

---

## 4. Categories

The Categories table stores the categories available for each event.

### Fields

| Field        | Description                                  |
| ------------ | -------------------------------------------- |
| CategoryID   | Primary key for the category                 |
| EventID      | Foreign key linking the category to an event |
| CategoryName | Name of the category                         |
| Description  | Category description                         |

### Example Categories

* Under 20
* Senior
* Veteran
* Junior
* Elite
* Open

---

## 5. Enrollments

The Enrollments table stores participant registrations for events.

### Fields

| Field          | Description                                         |
| -------------- | --------------------------------------------------- |
| EnrollmentID   | Primary key for the enrollment                      |
| ParticipantID  | Foreign key linking the enrollment to a participant |
| EventID        | Foreign key linking the enrollment to an event      |
| CategoryID     | Foreign key linking the enrollment to a category    |
| EnrollmentDate | Date the participant enrolled                       |

The database prevents a participant from enrolling in the same event more than once.

---

## 6. Results

The Results table stores the results of participants after an event.

### Fields

| Field             | Description                                     |
| ----------------- | ----------------------------------------------- |
| ResultID          | Primary key for the result                      |
| EnrollmentID      | Foreign key linking the result to an enrollment |
| FinishTime        | Time taken by the participant                   |
| FinishingPosition | Final finishing position                        |

Each enrollment can have a maximum of one result.

---

# Entity Relationship Diagram

The RaceDayDB database uses relationships between the six main entities.

```text
Roles
  |
  | 1
  |
  |------< Many
             |
           Users
             |
             | 1
             |
             |------< Many
                        |
                      Events
                        |
             -------------------
             |                 |
             |                 |
            Many              Many
             |                 |
        Categories        Enrollments
                              |
                              |
                            0 or 1
                              |
                            Results
```

---

# Database Relationships

The following relationships exist in the database:

* One Role can have many Users.
* One User acting as an Organiser can create many Events.
* One Event can have many Categories.
* One User acting as a Participant can have many Enrollments.
* One Event can have many Enrollments.
* One Category can have many Enrollments.
* One Enrollment can have zero or one Result.

---

# SQL Database Setup

## Prerequisites

Before running the project, ensure that the following software is installed:

* Microsoft SQL Server
* SQL Server Management Studio (SSMS)

---

## Installation Instructions

### Step 1: Open SQL Server Management Studio

Open SSMS and connect to your SQL Server instance.

---

### Step 2: Create a New Query

Click:

```text
New Query
```

---

### Step 3: Run the Database Setup Script

Copy the complete SQL script into the query window.

The script will:

1. Remove the old RaceDayDB database if it exists.
2. Create a new RaceDayDB database.
3. Create all required tables.
4. Create primary keys.
5. Create foreign key relationships.
6. Add database constraints.
7. Insert sample data.
8. Display the data from all tables.

---

# Database Reset Script

If the database already exists and needs to be recreated, use the following script:

```sql
USE master;
GO

IF EXISTS (SELECT name FROM sys.databases WHERE name = 'RaceDayDB')
BEGIN
    ALTER DATABASE RaceDayDB
    SET SINGLE_USER
    WITH ROLLBACK IMMEDIATE;

    DROP DATABASE RaceDayDB;
END
GO

CREATE DATABASE RaceDayDB;
GO

USE RaceDayDB;
GO
```

This removes the existing RaceDayDB database and creates a fresh database.

---

# Sample Data

The database contains sample data to demonstrate how the system works.

## Sample Roles

| RoleID | RoleName    |
| ------ | ----------- |
| 1      | Organiser   |
| 2      | Participant |

---

## Sample Users

The system includes sample users such as:

* John Smith – Organiser
* Sarah Mthembu – Organiser
* Sizwe Dlamini – Participant
* Thabo Nkosi – Particip
* ant

---

## Sample Events

The database includes the following sample events:

### Durban City Marathon

* Event Type: Run
* Distance: 42.20 km
* Location: Durban

### Umhlanga Fun Walk

* Event Type: Walk
* Distance: 5 km
* Location: Umhlanga

### KZN Cycling Challenge

* Event Type: Cycle
* Distance: 50 km
* Location: Richards Bay

---

# Database Constraints

The database includes several constraints to maintain data integrity.

## Primary Keys

Every table contains a primary key to uniquely identify each record.

Examples include:

```text
RoleID
UserID
EventID
CategoryID
EnrollmentID
ResultID
```

---

## Foreign Keys

Foreign keys are used to maintain relationships between tables.

Examples include:

```text
Users.RoleID → Roles.RoleID

Events.OrganiserID → Users.UserID

Categories.EventID → Events.EventID

Enrollments.ParticipantID → Users.UserID

Enrollments.EventID → Events.EventID

Enrollments.CategoryID → Categories.CategoryID

Results.EnrollmentID → Enrollments.EnrollmentID
```

---

## Unique Constraints

The database prevents duplicate information where necessary.

Examples include:

* Role names must be unique.
* User email addresses must be unique.
* A participant cannot enroll in the same event more than once.
* An enrollment can only have one result.

---

## Check Constraints

The following validation rules are included:

### Event Type

Only the following event types are allowed:

```text
Run
Walk
Cycle
```

### Distance

Event distance must be greater than zero.

### Finishing Position

The finishing position must be greater than zero.

---

# API Endpoint Plan

The system is planned to use RESTful API endpoints.

## Authentication Endpoints

### Register a User

```text
POST /api/auth/register
```

Registers a new user in the RaceDay System.

---

### Login

```text
POST /api/auth/login
```

Allows a registered user to log into the system.

---

# User Endpoints

### View Profile

```text
GET /api/users/profile
```

Returns the currently logged-in user's profile.

---

### Update Profile

```text
PUT /api/users/profile
```

Allows a user to update their profile information.

---

# Event Endpoints

### View All Events

```text
GET /api/events
```

Returns a list of all available events.

---

### View a Specific Event

```text
GET /api/events/{id}
```

Returns information about a specific event.

---

### Create an Event

```text
POST /api/events
```

Allows an organiser to create a new event.

---

### Update an Event

```text
PUT /api/events/{id}
```

Allows an organiser to update an existing event.

---

### Delete an Event

```text
DELETE /api/events/{id}
```

Allows an organiser to delete an event.

---

# Category Endpoints

### View Event Categories

```text
GET /api/events/{id}/categories
```

Returns all categories belonging to an event.

---

### Create a Category

```text
POST /api/events/{id}/categories
```

Allows an organiser to create a category for an event.

---

### Update a Category

```text
PUT /api/categories/{id}
```

Updates an existing category.

---

### Delete a Category

```text
DELETE /api/categories/{id}
```

Deletes a category.

---

# Enrollment Endpoints

### Enroll in an Event

```text
POST /api/enrollments
```

Allows a participant to register for an event.

---

### View My Enrollments

```text
GET /api/enrollments/my
```

Returns all events that the currently logged-in participant has enrolled in.

---

### View Event Enrollments

```text
GET /api/events/{id}/enrollments
```

Allows an organiser to view participants enrolled in a specific event.

---

# Result Endpoints

### View My Results

```text
GET /api/results/my
```

Allows a participant to view their event results.

---

### Add a Result

```text
POST /api/results
```

Allows an organiser to add a participant's event result.

---

### Update a Result

```text
PUT /api/results/{id}
```

Allows an organiser to update an existing result.

---

### View Event Results

```text
GET /api/events/{id}/results
```

Returns the results for a specific event.

---

# Expected HTTP Response Codes

The API is expected to use standard HTTP response codes.

| Code | Meaning                            |
| ---- | ---------------------------------- |
| 200  | Request successful                 |
| 201  | Resource successfully created      |
| 204  | Request successful with no content |
| 400  | Invalid request                    |
| 401  | User is not authenticated          |
| 403  | User does not have permission      |
| 404  | Resource not found                 |
| 500  | Internal server error              |

---

# Project Folder Structure

The recommended project structure is:

```text
RaceDay-System/
│
├── README.md
│
├── database/
│   └── RaceDayDB.sql
│
└── docs/
    ├── RaceDay_ERD.png
    └── API_Endpoint_Plan.md
```

---

# How to Test the Database

After running the SQL script, use the following queries to check the tables.

```sql
SELECT * FROM Roles;

SELECT * FROM Users;

SELECT * FROM Events;

SELECT * FROM Categories;

SELECT * FROM Enrollments;

SELECT * FROM Results;
```

The queries should display the sample data inserted into the database.

---

# Project Deliverables

The following files are included or required for Part 1:

```text
README.md
RaceDayDB.sql
RaceDay_ERD.png
API_Endpoint_Plan.md
```

---

# Future Development

Future versions of the RaceDay System may include:

* A complete ASP.NET Web API
* User authentication using JWT
* Password hashing and security
* A web-based user interface
* Event search functionality
* Participant dashboards
* Organiser dashboards
* Automated ranking of results
* Email notifications
* Online event registration

---

# Conclusion

The RaceDay System database has been designed to provide a structured and reliable solution for managing sporting events and participants. The database uses primary keys, foreign keys, unique constraints, and validation rules to maintain data integrity.

The Entity Relationship Diagram provides a visual representation of the relationships between the database entities. The SQL script creates the complete RaceDayDB database and inserts sample data for testing. The API endpoint plan provides a foundation for future development of the RaceDay System application.

This Part 1 implementation provides the database and system planning foundation required for the development of the complete RaceDay System.
