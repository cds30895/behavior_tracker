"""
Populate behavior_tracker database with default options
"""

from src.models import Antecedent, Behavior_Desc, Consequence, Activity, Subject, Setting, db
from src import create_app

antecedents = ['Work expectations', 'Undesired task/plan', 'Peer conflict', 'Redirection', 'Percieved Unfairness', 'Missed directions', 'Change in routine or adults', 'Not ready for transition', 'Competition', 'Mistake', 'Other']
behavior_desc = ['Elopement', 'Aggression - adult', 'Aggression - peer', 'Aggression - items, minor', 'Aggression - items, major', 'Misuse of objects', 'Negative talk - self', 'Negative talk - others', 'Yelling, screaming', 'Refusal, ignoring', 'Threatening', 'Inappropriate use of tech', 'Other']
consequences = ['Offer Break', 'Supported calming strategies', 'Task support', 'Task alteration', 'Visual/gestural prompts', 'Questioning/Clarifying thinking', 'Validation ("I hear you")', 'Processing time/space', 'Proximity', 'Modeling task', 'Only restate expectations', 'Clarify expectation', '"Positive Helper"', 'Staff switch', 'Limited reaction', 'Problem solving', 'Reminder of reinforcement', 'Offer what was desired', 'Snack', 'Isolation/Restraint (CONTACT ADMIN)', 'Other']
activities = ['Whole group instruction', 'Practice task', 'Cooperative task', 'Unstructured task', 'Transition', 'Group Time', 'Work out of class']
subjects = ['Reading', 'Math', 'Writing', 'Science', 'Social Studies', 'Art', 'Music', 'PE', 'Library', 'Recess', 'Lunch', 'Group', 'Other']
settings = ['GenEd Classroom', 'SpEd Classroom', 'Specialist', 'Hallway', 'Gym', 'Lunchroom', 'Playground', 'Outside - School Grounds', 'Outside - Off Campus']

def main():
    """Main driver function"""
    app = create_app()
    app.app_context().push()
    
    for item in antecedents:
        newrow = Antecedent(description = item)
        db.session.add(newrow)

    # insert antecedents
    db.session.commit()

    for item in behavior_desc:
        newrow = Behavior_Desc(description = item)
        db.session.add(newrow)

    # insert behavior_desc
    db.session.commit()

    for item in consequences:
        newrow = Consequence(description = item)
        db.session.add(newrow)

    # insert consequences
    db.session.commit()

    for item in activities:
        newrow = Activity(description = item)
        db.session.add(newrow)

    # insert activities
    db.session.commit()

    for item in subjects:
        newrow = Subject(description = item)
        db.session.add(newrow)

    # insert subjects
    db.session.commit()

    for item in settings:
        newrow = Setting(description = item)
        db.session.add(newrow)

    # insert settings
    db.session.commit()

# run script
ant = Antecedent.query.all()
if len(ant) == 0:
    main()
