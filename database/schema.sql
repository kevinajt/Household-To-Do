CREATE TABLE users (
    UserId int GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    Name varchar(255) NOT NULL,
    Email varchar(255) NOT NULL UNIQUE,
    PasswordHash varchar(255) NOT NULL
);

CREATE TABLE households (
    HouseholdId int GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    HouseholdName varchar(255) NOT NULL,
    InviteCode varchar(255) NOT NULL UNIQUE
);

CREATE TABLE household_members (
    HouseholdMemberId int GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    UserId int UNIQUE NOT NULL,
    CONSTRAINT fk_users
    FOREIGN KEY (UserId)
    REFERENCES users(UserId)
    ON DELETE CASCADE,
    Role text NOT NULL,
    CHECK (Role IN ('owner', 'leader', 'member')),
    DisplayName varchar(255) NOT NULL,
    HouseholdId int NOT NULL,
    CONSTRAINT fk_households
    FOREIGN KEY (HouseholdId)
    REFERENCES households(HouseholdId)
    ON DELETE CASCADE,
    UNIQUE (HouseholdId, DisplayName)
);

CREATE TABLE tasks (
    TaskId int GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    Content text NOT NULL,
    HouseholdId int NOT NULL,
    CONSTRAINT fk_households
    FOREIGN KEY (HouseholdId)
    REFERENCES households(HouseholdId)
    ON DELETE CASCADE
);

CREATE TABLE task_assignees (
    TaskId int,
    CONSTRAINT fk_tasks
    FOREIGN KEY (TaskId)
    REFERENCES tasks(TaskId)
    ON DELETE CASCADE,
    HouseholdMemberId int,
    CONSTRAINT fk_household_members
    FOREIGN KEY (HouseholdMemberId)
    REFERENCES household_members(HouseholdMemberId)
    ON DELETE CASCADE,
    PRIMARY KEY (TaskId, HouseholdMemberId)
);