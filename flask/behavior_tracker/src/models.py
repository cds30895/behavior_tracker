import datetime
from flask_sqlalchemy import SQLAlchemy

db = SQLAlchemy()


class Student(db.Model):
    __tablename__ = 'students'
    id = db.Column(db.Integer, primary_key=True, autoincrement=True)
    student_id = db.Column(db.Integer, unique=True)
    first_name = db.Column(db.Text, nullable=False)
    last_name = db.Column(db.Text, nullable=False)
    grade = db.Column(db.String(2), nullable=False)
    case_manager = db.Column(
        db.Integer, db.ForeignKey('staff.id', ondelete='SET NULL'), nullable=False)

    def __init__(self, first_name: str, last_name: str, grade: int, case_manager: int, student_id=None):
        self.student_id = student_id
        self.first_name = first_name
        self.last_name = last_name
        self.grade = grade
        self.case_manager = case_manager

    def serialize(self):
        return {
            'id': self.id,
            'student_id': self.student_id,
            'first_name': self.first_name,
            'last_name': self.last_name,
            'grade': self.grade,
            'case_manager': self.case_manager
        }


class Staff(db.Model):
    __tablename__ = 'staff'
    id = db.Column(db.Integer, primary_key=True, autoincrement=True)
    first_name = db.Column(db.Text, nullable=False)
    last_name = db.Column(db.Text, nullable=False)
    email = db.Column(db.Text, unique=True)

    def __init__(self, first_name, last_name, email):
        self.first_name = first_name
        self.last_name = last_name
        self.email = email

    def serialize(self):
        return {
            'id': self.id,
            'first_name': self.first_name,
            'last_name': self.last_name,
            'email': self.email
        }


class Behavior(db.Model):
    __tablename__ = 'behaviors'
    id = db.Column(db.Integer, primary_key=True, autoincrement=True)
    student = db.Column(db.Integer, db.ForeignKey(
        'students.id', ondelete='SET NULL'), nullable=False, index=True)
    antecedent_other = db.Column(db.Text)
    behavior_other = db.Column(db.Text)
    consequence_other = db.Column(db.Text)
    date_of_behavior = db.Column(
        db.Date, default=datetime.datetime.utcnow, nullable=False)
    start_time = db.Column(db.Time, nullable=False)
    end_time = db.Column(db.Time, nullable=False)

    def __init__(self, student, date_of_behavior, start_time, end_time):
        self.student = student
        self.antecedent_other = None
        self.behavior_other = None
        self.consequence_other = None
        self.date_of_behavior = date_of_behavior
        self.start_time = start_time
        self.end_time = end_time

    def serialize(self):
        return {
            'id': self.id,
            'student': self.student,
            'date_of_behavior': self.date_of_behavior,
            'start_time': self.start_time.isoformat(),
            'end_time': self.end_time.isoformat(),
            'antecedent_other': self.antecedent_other,
            'behavior_other': self.behavior_other,
            'consequence_other': self.consequence_other,
        }


class Antecedent(db.Model):
    __tablename__ = 'antecedents'
    id = db.Column(db.Integer, primary_key=True, autoincrement=True)
    description = db.Column(db.Text, unique=True, nullable=False)

    def __init__(self, description):
        self.description = description

    def serialize(self):
        return {
            'id': self.id,
            'description': self.description
        }


class Behavior_Desc(db.Model):
    __tablename__ = 'behavior_desc'
    id = db.Column(db.Integer, primary_key=True, autoincrement=True)
    description = db.Column(db.Text, unique=True, nullable=False)

    def __init__(self, description):
        self.description = description

    def serialize(self):
        return {
            'id': self.id,
            'description': self.description
        }


class Consequence(db.Model):
    __tablename__ = 'consequences'
    id = db.Column(db.Integer, primary_key=True, autoincrement=True)
    description = db.Column(db.Text, unique=True, nullable=False)

    def __init__(self, description):
        self.description = description

    def serialize(self):
        return {
            'id': self.id,
            'description': self.description
        }


class Activity(db.Model):
    __tablename__ = 'activities'
    id = db.Column(db.Integer, primary_key=True, autoincrement=True)
    description = db.Column(db.Text, unique=True, nullable=False)

    def __init__(self, description):
        self.description = description

    def serialize(self):
        return {
            'id': self.id,
            'description': self.description
        }


class Subject(db.Model):
    __tablename__ = 'subjects'
    id = db.Column(db.Integer, primary_key=True, autoincrement=True)
    description = db.Column(db.Text, unique=True, nullable=False)

    def __init__(self, description):
        self.description = description

    def serialize(self):
        return {
            'id': self.id,
            'description': self.description
        }


class Setting(db.Model):
    __tablename__ = 'settings'
    id = db.Column(db.Integer, primary_key=True, autoincrement=True)
    description = db.Column(db.Text, unique=True, nullable=False)

    def __init__(self, description):
        self.description = description

    def serialize(self):
        return {
            'id': self.id,
            'description': self.description
        }


class Observing_Staff(db.Model):
    __tablename__ = 'observing_staff'
    behavior_id = db.Column(
        db.Integer,
        db.ForeignKey('behaviors.id', ondelete='CASCADE'),
        primary_key=True,
        nullable=False
    )
    staff_present = db.Column(
        db.Integer,
        db.ForeignKey('staff.id'),
        primary_key=True,
        nullable=False
    )

    def __init__(self, behavior_id, staff_present):
        self.behavior_id = behavior_id
        self.staff_present = staff_present

    def serialize(self):
        return {
            'behavior_id': self.behavior_id,
            'staff_present': self.staff_present
        }


class Behavior_Antecedent(db.Model):
    __tablename__ = 'behaviors_antecedents'
    behavior_id = db.Column(
        db.Integer,
        db.ForeignKey('behaviors.id', ondelete='CASCADE'),
        primary_key=True,
        nullable=False
    )
    antecedent_id = db.Column(
        db.Integer,
        db.ForeignKey('antecedents.id'),
        primary_key=True,
        nullable=False
    )

    def __init__(self, behavior_id, antecedent_id):
        self.behavior_id = behavior_id
        self.antecedent_id = antecedent_id

    def serialize(self):
        return {
            'behavior_id': self.behavior_id,
            'antecedent_id': self.antecedent_id
        }


class Behavior_Behavior_Desc(db.Model):
    __tablename__ = 'behaviors_behavior_desc'
    behavior_id = db.Column(
        db.Integer,
        db.ForeignKey('behaviors.id', ondelete='CASCADE'),
        primary_key=True,
        nullable=False
    )
    behavior_desc_id = db.Column(
        db.Integer,
        db.ForeignKey('behavior_desc.id'),
        primary_key=True,
        nullable=False
    )

    def __init__(self, behavior_id, behavior_desc_id):
        self.behavior_id = behavior_id
        self.behavior_desc_id = behavior_desc_id

    def serialize(self):
        return {
            'behavior_id': self.behavior_id,
            'behavior_desc_id': self.behavior_desc_id
        }


class Behavior_Consequence(db.Model):
    __tablename__ = 'behaviors_consequences'
    behavior_id = db.Column(
        db.Integer,
        db.ForeignKey('behaviors.id', ondelete='CASCADE'),
        primary_key=True,
        nullable=False
    )
    consequence_id = db.Column(
        db.Integer,
        db.ForeignKey('consequences.id'),
        primary_key=True,
        nullable=False
    )

    def __init__(self, behavior_id, consequence_id):
        self.behavior_id = behavior_id
        self.consequence_id = consequence_id

    def serialize(self):
        return {
            'behavior_id': self.behavior_id,
            'consequence_id': self.consequence_id
        }


class Behavior_Activity(db.Model):
    __tablename__ = 'behaviors_activities'
    behavior_id = db.Column(
        db.Integer,
        db.ForeignKey('behaviors.id', ondelete='CASCADE'),
        primary_key=True,
        nullable=False
    )
    activity_id = db.Column(
        db.Integer,
        db.ForeignKey('activities.id'),
        primary_key=True,
        nullable=False
    )

    def __init__(self, behavior_id, activity_id):
        self.behavior_id = behavior_id
        self.activity_id = activity_id

    def serialize(self):
        return {
            'behavior_id': self.behavior_id,
            'activity_id': self.activity_id
        }


class Behavior_Subject(db.Model):
    __tablename__ = 'behaviors_subjects'
    behavior_id = db.Column(
        db.Integer,
        db.ForeignKey('behaviors.id', ondelete='CASCADE'),
        primary_key=True,
        nullable=False
    )
    subject_id = db.Column(
        db.Integer,
        db.ForeignKey('subjects.id'),
        primary_key=True,
        nullable=False
    )

    def __init__(self, behavior_id, subject_id):
        self.behavior_id = behavior_id
        self.subject_id = subject_id

    def serialize(self):
        return {
            'behavior_id': self.behavior_id,
            'subject_id': self.subject_id
        }


class Behavior_Setting(db.Model):
    __tablename__ = 'behaviors_settings'
    behavior_id = db.Column(
        db.Integer,
        db.ForeignKey('behaviors.id', ondelete='CASCADE'),
        primary_key=True,
        nullable=False
    )
    setting_id = db.Column(
        db.Integer,
        db.ForeignKey('settings.id'),
        primary_key=True,
        nullable=False
    )

    def __init__(self, behavior_id, setting_id):
        self.behavior_id = behavior_id
        self.setting_id = setting_id

    def serialize(self):
        return {
            'behavior_id': self.behavior_id,
            'setting_id': self.setting_id
        }
