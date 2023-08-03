/*  BEHAVIOR TRACKER
    Author: Chris Smith

    The purpose of this database is to track student behaviors throughout the day.  Such data can be useful for
    noticing trends based on location, activity, or staff as well as tracking effectiveness of interventions. */



-- TODO:
--   Add ON DELETE clauses to FOREIGN KEYS.  Options: CASCADE, SET NULL, SET DEFAULT
--   Move FOREIGN KEYS to CREATE TABLE statements.




-- TO RESET DATABASE ENTIRELY...
-- Execute while connected to another database.
-- *~*~*~*~* WARNING: WILL DELETE ALL DATA *~*~*~*~*

/* SELECT pg_terminate_backend(pg_stat_activity.pid)
FROM pg_stat_activity
WHERE pg_stat_activity.datname = 'behavior_tracker' AND pid <> pg_backend_pid();

DROP DATABASE IF EXISTS behavior_tracker;
CREATE DATABASE behavior_tracker;

\c behavior_tracker */


-- TABLES

CREATE TABLE students (
    id SERIAL PRIMARY KEY,
    student_id INT UNIQUE,
    first_name TEXT NOT NULL,
    last_name TEXT NOT NULL,
    grade VARCHAR(2) NOT NULL,
    case_manager INT NOT NULL
);


CREATE TABLE staff (
    id SERIAL PRIMARY KEY,
    first_name TEXT NOT NULL,
    last_name TEXT NOT NULL,
    email TEXT UNIQUE
);


CREATE TABLE behaviors (
    id SERIAL PRIMARY KEY,
    student INT NOT NULL,
    antecedent_other TEXT,
    behavior_other TEXT,
    consequence_other TEXT,
    date_of_behavior DATE DEFAULT CURRENT_DATE NOT NULL,
    start_time TIME NOT NULL,
    end_time TIME NOT NULL
);


CREATE TABLE antecedents (
    id SERIAL PRIMARY KEY,
    description TEXT NOT NULL UNIQUE
);


CREATE TABLE behavior_desc (
    id SERIAL PRIMARY KEY,
    description TEXT NOT NULL UNIQUE
);


CREATE TABLE consequences (
    id SERIAL PRIMARY KEY,
    description TEXT NOT NULL UNIQUE
);


CREATE TABLE activities (
    id SERIAL PRIMARY KEY,
    type TEXT NOT NULL UNIQUE
);


CREATE TABLE subjects (
    id SERIAL PRIMARY KEY,
    subject TEXT NOT NULL UNIQUE
);


CREATE TABLE settings (
    id SERIAL PRIMARY KEY,
    location TEXT NOT NULL UNIQUE
);


-- BRIDGE TABLES

CREATE TABLE observing_staff (
    behavior_id INT NOT NULL,
    staff_present INT NOT NULL,
    PRIMARY KEY (behavior_id, staff_present)
);


CREATE TABLE behaviors_antecedents (
    behavior_id INT NOT NULL,
    antecedent_id INT NOT NULL,
    PRIMARY KEY (behavior_id, antecedent_id)
);


CREATE TABLE behaviors_behavior_desc (
    behavior_id INT NOT NULL,
    behavior_desc_id INT NOT NULL,
    PRIMARY KEY (behavior_id, behavior_desc_id)
);


CREATE TABLE behaviors_consequences (
    behavior_id INT NOT NULL,
    consequence_id INT NOT NULL,
    PRIMARY KEY (behavior_id, consequence_id)
);


CREATE TABLE behaviors_activities (
    behavior_id INT NOT NULL,
    activity_id INT NOT NULL,
    PRIMARY KEY (behavior_id, activity_id)
);


CREATE TABLE behaviors_subjects (
    behavior_id INT NOT NULL,
    subject_id INT NOT NULL,
    PRIMARY KEY (behavior_id, subject_id)
);


CREATE TABLE behaviors_settings (
    behavior_id INT NOT NULL,
    setting_id INT NOT NULL,
    PRIMARY KEY (behavior_id, setting_id)
);


-- FOREIGN KEYS

ALTER TABLE students
ADD CONSTRAINT fk_students_staff
FOREIGN KEY (case_manager)
REFERENCES staff (id);


-- Set to NULL on delete.  If a student is deleted, the data is anonymized, but could still
-- point to environmental or staff factors leading to escalations among all students.
ALTER TABLE behaviors
ADD CONSTRAINT fk_behaviors_students
FOREIGN KEY (student)
REFERENCES students (student_id)
ON DELETE SET NULL;


-- FOREIGN KEYS FOR BRIDGE TABLES

ALTER TABLE observing_staff
ADD CONSTRAINT fk_observing_staff_behavior_id
FOREIGN KEY (behavior_id)
REFERENCES behaviors (id);


ALTER TABLE observing_staff
ADD CONSTRAINT fk_observing_staff_staff_present
FOREIGN KEY (staff_present)
REFERENCES staff (id);


ALTER TABLE behaviors_antecedents
ADD CONSTRAINT fk_behaviors_antecedents_behaviors
FOREIGN KEY (behavior_id)
REFERENCES behaviors (id);


ALTER TABLE behaviors_antecedents
ADD CONSTRAINT fk_behaviors_antecedents_antecedents
FOREIGN KEY (antecedent_id)
REFERENCES antecedents (id);


ALTER TABLE behaviors_behavior_desc
ADD CONSTRAINT fk_behaviors_behavior_desc_behaviors
FOREIGN KEY (behavior_id)
REFERENCES behaviors (id);


ALTER TABLE behaviors_behavior_desc
ADD CONSTRAINT fk_behaviors_behavior_desc_behavior_desc
FOREIGN KEY (behavior_desc_id)
REFERENCES behavior_desc (id);


ALTER TABLE behaviors_consequences
ADD CONSTRAINT fk_behaviors_consequences_behaviors
FOREIGN KEY (behavior_id)
REFERENCES behaviors (id);


ALTER TABLE behaviors_consequences
ADD CONSTRAINT fk_behaviors_consequences_consequences
FOREIGN KEY (consequence_id)
REFERENCES consequences (id);


ALTER TABLE behaviors_activities
ADD CONSTRAINT fk_behaviors_activities_behaviors
FOREIGN KEY (behavior_id)
REFERENCES behaviors (id);


ALTER TABLE behaviors_activities
ADD CONSTRAINT fk_behaviors_activities_activities
FOREIGN KEY (activity_id)
REFERENCES activities (id);


ALTER TABLE behaviors_subjects
ADD CONSTRAINT fk_behaviors_subjects_behaviors
FOREIGN KEY (behavior_id)
REFERENCES behaviors (id);


ALTER TABLE behaviors_subjects
ADD CONSTRAINT fk_behaviors_subjects_subjects
FOREIGN KEY (subject_id)
REFERENCES subjects (id);


ALTER TABLE behaviors_settings
ADD CONSTRAINT fk_behaviors_settings_behaviors
FOREIGN KEY (behavior_id)
REFERENCES behaviors (id);


ALTER TABLE behaviors_settings
ADD CONSTRAINT fk_behaviors_settings_settings
FOREIGN KEY (setting_id)
REFERENCES settings (id);


-- POPULATE DEFAULTS


INSERT INTO antecedents (description) VALUES
    ('Work expectations'),
    ('Undesired task/plan'),
    ('Peer conflict'),
    ('Redirection'),
    ('Percieved Unfairness'),
    ('Missed directions'),
    ('Change in routine or adults'),
    ('Not ready for transition'),
    ('Competition'),
    ('Mistake'),
    ('Other')
;

INSERT INTO behavior_desc (description) VALUES
    ('Elopement'),
    ('Aggression - adult'),
    ('Aggression - peer'),
    ('Aggression - items, minor'),
    ('Aggression - items, major'),
    ('Misuse of objects'),
    ('Negative talk - self'),
    ('Negative talk - others'),
    ('Yelling, screaming'),
    ('Refusal, ignoring'),
    ('Threatening'),
    ('Inappropriate use of tech'),
    ('Other')
;

INSERT INTO consequences (description) VALUES
    ('Offer Break'),
    ('Supported calming strategies'),
    ('Task support'),
    ('Task alteration'),
    ('Visual/gestural prompts'),
    ('Questioning/Clarifying thinking'),
    ('Validation ("I hear you")'),
    ('Processing time/space'),
    ('Proximity'),
    ('Modeling task'),
    ('Only restate expectations'),
    ('Clarify expectation'),
    ('"Positive Helper"'),
    ('Staff switch'),
    ('Limited reaction'),
    ('Problem solving'),
    ('Reminder of reinforcement'),
    ('Offer what was desired'),
    ('Snack'),
    ('Isolation/Restraint (CONTACT ADMIN)'),
    ('Other')
;

INSERT INTO activities (type) VALUES
    ('Whole group instruction'),
    ('Practice task'),
    ('Cooperative task'),
    ('Unstructured task'),
    ('Transition'),
    ('Group Time'),
    ('Work out of class')
;

INSERT INTO subjects (subject) VALUES
    ('Reading'),
    ('Math'),
    ('Writing'),
    ('Science'),
    ('Social Studies'),
    ('Art'),
    ('Music'),
    ('PE'),
    ('Library'),
    ('Recess'),
    ('Lunch'),
    ('Group'),
    ('Other')
;

INSERT INTO settings (location) VALUES
    ('GenEd Classroom'),
    ('SpEd Classroom'),
    ('Specialist'),
    ('Hallway'),
    ('Gym'),
    ('Lunchroom'),
    ('Playground'),
    ('Outside - School Grounds'),
    ('Outside - Off Campus')
;
