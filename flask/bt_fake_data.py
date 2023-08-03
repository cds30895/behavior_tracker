# db: behavior_tracker
# FIRST: Run seed.py

from sqlalchemy.sql import text
from behavior_tracker.src.models import Antecedent, Behavior_Desc, Consequence, Activity, Subject, Setting, db
from behavior_tracker.src import create_app

app = create_app()
app.app_context().push()

engine = db.get_engine()
conn = engine.connect()
statements = [

    """ INSERT INTO staff (first_name, last_name, email) VALUES
        ('Chris', 'Smith', 'csmith@school.edu'),
        ('William', 'Taft', 'wtaft@school.edu'),
        ('John', 'Madison', 'jmadison@school.edu'),
        ('Diana', 'Prince', 'dprince@themyscira.az')
    ; """,


    """ INSERT INTO students (student_id, first_name, last_name, grade, case_manager) VALUES 
        (12345, 'Johnny', 'Appleseed', 2, 2),
        (34012, 'Steve', 'Rogers', 5, 3),
        (68392, 'Anung', 'Un Rama', 'K', 4)
    ; """,


    """ INSERT INTO behaviors (student, date_of_behavior, start_time, end_time) VALUES
        (1, '2023-09-14', '9:00', '14:00'),
        (2, '2023-09-13', '10:28', '10:30')
    ; """,


    """ INSERT INTO observing_staff (behavior_id, staff_present) VALUES
        (1, 1),
        (2, 4),
        (2, 3)
    ; """,


    """ INSERT INTO behaviors_antecedents (behavior_id, antecedent_id) VALUES
        (1, 2),
        (2, 3),
        (2, 5)
    ; """,


    """ INSERT INTO behaviors_behavior_desc (behavior_id, behavior_desc_id) VALUES
        (1, 1),
        (1, 10),
        (2, 3),
        (2, 9)
    ; """,


    """ INSERT INTO behaviors_consequences (behavior_id, consequence_id) VALUES
        (1, 6),
        (1, 9),
        (1, 12),
        (1, 13),
        (2, 2),
        (2, 16),
        (2, 19)
    ; """,


    """ INSERT INTO behaviors_activities (behavior_id, activity_id) VALUES
        (1, 5),
        (2, 4)
    ;
    """,


    """ INSERT INTO behaviors_subjects (behavior_id, subject_id) VALUES
        (2, 10)
    ; """,


    """ INSERT INTO behaviors_settings (behavior_id, setting_id) VALUES
        (1, 4),
        (1, 7),
        (1, 8),
        (1, 9),
        (2, 7)
    ; """]

for statement in statements:
    conn.execute(text(statement))
