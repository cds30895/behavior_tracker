from flask import Blueprint, jsonify, abort, request
from ..models import *

bp = Blueprint('behaviors', __name__, url_prefix='/behaviors')



# Retrieves all info on a given behavior incident grouped by behavior_id
def retrieve_behavior_info(b):
    b_dict = b.serialize()
        
    antecedent = Antecedent.query.join(Behavior_Antecedent).filter(Behavior_Antecedent.behavior_id == b_dict['id'])
    aresult = []
    for a in antecedent:
        aresult.append(a.serialize()['description'])
    b_dict['antecedent'] = aresult[0] if len(aresult) == 1 else aresult if len(aresult) > 1 else None

    behavior_desc = Behavior_Desc.query.join(Behavior_Behavior_Desc).filter(Behavior_Behavior_Desc.behavior_id == b_dict['id'])
    aresult = []
    for b in behavior_desc:
        aresult.append(b.serialize()['description'])
    b_dict['behavior_desc'] = aresult[0] if len(aresult) == 1 else aresult if len(aresult) > 1 else None

    consequence = Consequence.query.join(Behavior_Consequence).filter(Behavior_Consequence.behavior_id == b_dict['id'])
    aresult = []
    for c in consequence:
        aresult.append(c.serialize()['description'])
    b_dict['consequence'] = aresult[0] if len(aresult) == 1 else aresult if len(aresult) > 1 else None

    activity = Activity.query.join(Behavior_Activity).filter(Behavior_Activity.behavior_id == b_dict['id'])
    aresult = []
    for ac in activity:
        aresult.append(ac.serialize()['description'])
    b_dict['activity'] = aresult[0] if len(aresult) == 1 else aresult if len(aresult) > 1 else None

    subject = Subject.query.join(Behavior_Subject).filter(Behavior_Subject.behavior_id == b_dict['id'])
    aresult = []
    for su in subject:
        aresult.append(su.serialize()['description'])
    b_dict['subject'] = aresult[0] if len(aresult) == 1 else aresult if len(aresult) > 1 else None

    setting = Setting.query.join(Behavior_Setting).filter(Behavior_Setting.behavior_id == b_dict['id'])
    aresult = []
    for se in setting:
        aresult.append(se.serialize()['description'])
    b_dict['setting'] = aresult[0] if len(aresult) == 1 else aresult if len(aresult) > 1 else None

    student_name = Student.query.join(Behavior).filter(Student.id == b_dict['student'])
    aresult = []
    for s in student_name:
        sns = s.serialize()
        name = sns['first_name'] + ' ' + sns['last_name']
        aresult.append(name)
    b_dict['student_name'] = aresult[0]
    
    observing_staff = Staff.query.join(Observing_Staff).filter(Observing_Staff.behavior_id == b_dict['id'])
    aresult = []
    for o in observing_staff:
        os = o.serialize()
        name = os['first_name'] + ' ' + os['last_name']
        aresult.append(name)
    b_dict['observing_staff'] = aresult[0] if len(aresult) == 1 else aresult if len(aresult) > 1 else None

    return(b_dict)


@bp.route('', methods=['GET'])
def index():
    behaviors = Behavior.query.all()
    result = []
    for b in behaviors:
        result.append(retrieve_behavior_info(b))
    return jsonify(result)

@bp.route('/<int:id>', methods=['GET'])
def show(id: int):
    b = Behavior.query.get_or_404(id)
    return jsonify(retrieve_behavior_info(b))

@bp.route('/by_student/<int:id>', methods=['GET'])
def show_by_student(id: int):
    s = Student.query.get_or_404(id)
    behaviors = Behavior.query.filter(Behavior.student == s.id)
    result = []
    for b in behaviors:
        result.append(retrieve_behavior_info(b))
    return jsonify(result)

@bp.route('', methods=['POST'])
def create():
    required_elements = ['student', 'date_of_behavior', 'start_time', 'end_time', 'antecedent', 'behavior_desc', 'consequence', 'observing_staff']
    for e in required_elements:
        if e not in request.json:
            return abort(400, description='Missing required element(s)')

    b = Behavior(
        student=int(request.json['student']),
        date_of_behavior=request.json['date_of_behavior'],
        start_time=request.json['start_time'],
        end_time=request.json['end_time']
    )
    
    if 'antecedent_other' in request.json:
        b.antecedent_other = request.json['antecedent_other']
    else:
        b.antecedent_other = None
    if 'behavior_other' in request.json:
        b.behavior_other = request.json['behavior_other']
    else:
        b.behavior_other = None
    if 'consequence_other' in request.json:
        b.consequence_other = request.json['consequence_other']
    else:
        b.consequence_other = None
    db.session.add(b)
    db.session.commit()

    if type(request.json['antecedent']) == int:
        bant = Behavior_Antecedent(
            behavior_id=b.id,
            antecedent_id=int(request.json['antecedent'])
        )
        db.session.add(bant)
    elif type(request.json['antecedent']) == list:
        for i in request.json['antecedent']:
            bant = Behavior_Antecedent(
                behavior_id=b.id,
                antecedent_id=int(i)
            )
            db.session.add(bant)
        
    if type(request.json['behavior_desc']) == int:
        bdesc = Behavior_Behavior_Desc(
            behavior_id=b.id,
            behavior_desc_id=int(request.json['behavior_desc'])
        )
        db.session.add(bdesc)
    elif type(request.json['behavior_desc']) == list:
        for i in request.json['behavior_desc']:
            bdesc = Behavior_Behavior_Desc(
                behavior_id=b.id,
                behavior_desc_id=int(i)
            )
            db.session.add(bdesc)

    if type(request.json['consequence']) == int:
        bcon = Behavior_Consequence(
            behavior_id=b.id,
            consequence_id=int(request.json['consequence'])
        )
        db.session.add(bcon)
    elif type(request.json['consequence']) == list:
        for i in request.json['consequence']:
            bcon = Behavior_Consequence(
                behavior_id=b.id,
                consequence_id=int(i)
            )
            db.session.add(bcon)

    if type(request.json['observing_staff']) == int:
        obs = Observing_Staff(
            behavior_id=b.id,
            staff_present=int(request.json['observing_staff'])
        )
        db.session.add(obs)
    elif type(request.json['observing_staff']) == list:
        for i in request.json['observing_staff']:
            obs = Observing_Staff(
                behavior_id=b.id,
                staff_present=int(i)
            )
            db.session.add(obs)

    if 'activity' in request.json:
        if type(request.json['activity']) == int:
            bact = Behavior_Activity(
                behavior_id=b.id,
                activity_id=int(request.json['activity'])
            )
            db.session.add(bact)
        elif type(request.json['activity']) == list:
            for i in request.json['activity']:
                bact = Behavior_Activity(
                    behavior_id=b.id,
                    activity_id=int(i)
                )
                db.session.add(bact)

    if 'subject' in request.json:
        if type(request.json['subject']) == int:
            bsub = Behavior_Subject(
                behavior_id=b.id,
                subject_id=int(request.json['subject'])
            )
            db.session.add(bsub)
        elif type(request.json['subject']) == list:
            for i in request.json['subject']:
                bsub = Behavior_Subject(
                    behavior_id=b.id,
                    subject_id=int(i)
                )
                db.session.add(bsub)

    if 'setting' in request.json:
        if type(request.json['setting']) == int:
            bset = Behavior_Setting(
                behavior_id=b.id,
                setting_id=int(request.json['setting'])
            )
            db.session.add(bset)
        elif type(request.json['setting']) == list:
            for i in request.json['setting']:
                bset = Behavior_Setting(
                    behavior_id=b.id,
                    setting_id=int(i)
                )
                db.session.add(bset)
    
    db.session.commit()
    return jsonify(retrieve_behavior_info(b))


@bp.route('/<int:id>', methods=['DELETE'])
def delete(id: int):
    b = Behavior.query.get_or_404(id)
    try:
        db.session.delete(b)
        db.session.commit()
        return jsonify(True)
    except:
        return jsonify(False)


@bp.route('/<int:id>', methods=['PATCH'])
def update(id: int):
    b = Behavior.query.get_or_404(id)

    if 'student' in request.json:
        b.student = request.json['student']
    if 'antecedent_other' in request.json:
        b.antecedent_other = request.json['antecedent_other']
    if 'behavior_other' in request.json:
        b.behavior_other = request.json['behavior_other']
    if 'consequence_other' in request.json:
        b.consequence_other = request.json['consequence_other']
    if 'date_of_behavior' in request.json:
        b.date_of_behavior = request.json['date_of_behavior']
    if 'start_time' in request.json:
        b.start_time = request.json['start_time']
    if 'end_time' in request.json:
        b.end_time = request.json['end_time']

    if 'antecedent' in request.json:
        ants = Behavior_Antecedent.query.filter(Behavior_Antecedent.behavior_id == id)
        for row in ants:
            db.session.delete(row)
        if type(request.json['antecedent']) == int:
            bant = Behavior_Antecedent(
                behavior_id=b.id,
                antecedent_id=int(request.json['antecedent'])
            )
            db.session.add(bant)
        elif type(request.json['antecedent']) == list:
            for i in request.json['antecedent']:
                bant = Behavior_Antecedent(
                    behavior_id=b.id,
                    antecedent_id=int(i)
                )
                db.session.add(bant)

    if 'behavior_desc' in request.json:
        descs = Behavior_Behavior_Desc.query.filter(Behavior_Behavior_Desc.behavior_id == id)
        for row in descs:
            db.session.delete(row)
        if type(request.json['behavior_desc']) == int:
            bdesc = Behavior_Behavior_Desc(
                behavior_id=b.id,
                behavior_desc_id=int(request.json['behavior_desc'])
            )
            db.session.add(bdesc)
        elif type(request.json['behavior_desc']) == list:
            for i in request.json['behavior_desc']:
                bdesc = Behavior_Behavior_Desc(
                    behavior_id=b.id,
                    behavior_desc_id=int(i)
                )
                db.session.add(bdesc)

    if 'consequence' in request.json:
        cons = Behavior_Consequence.query.filter(Behavior_Consequence.behavior_id == id)
        for row in cons:
            db.session.delete(row)
        if type(request.json['consequence']) == int:
            bcon = Behavior_Consequence(
                behavior_id=b.id,
                consequence_id=int(request.json['consequence'])
            )
            db.session.add(bcon)
        elif type(request.json['consequence']) == list:
            for i in request.json['consequence']:
                bcon = Behavior_Consequence(
                    behavior_id=b.id,
                    consequence_id=int(i)
                )
                db.session.add(bcon)

    if 'observing_staff' in request.json:
        observe = Observing_Staff.query.filter(Observing_Staff.behavior_id == id)
        for row in observe:
            db.session.delete(row)
        if type(request.json['observing_staff']) == int:
            obs = Observing_Staff(
                behavior_id=b.id,
                observing_staff=int(request.json['observing_staff'])
            )
            db.session.add(obs)
        elif type(request.json['observing_staff']) == list:
            for i in request.json['observing_staff']:
                obs = Observing_Staff(
                    behavior_id=b.id,
                    staff_present=int(i)
                )
                db.session.add(obs)

    if 'activity' in request.json:
        acts = Behavior_Activity.query.filter(Behavior_Activity.behavior_id == id)
        for row in acts:
            db.session.delete(row)
        if type(request.json['activity']) == int:
            bact = Behavior_Activity(
                behavior_id=b.id,
                activity_id=int(request.json['activity'])
            )
            db.session.add(bact)
        elif type(request.json['activity']) == list:
            for i in request.json['activity']:
                bact = Behavior_Activity(
                    behavior_id=b.id,
                    activity_id=int(i)
                )
                db.session.add(bact)

    if 'subject' in request.json:
        subs = Behavior_Subject.query.filter(Behavior_Subject.behavior_id == id)
        for row in subs:
            db.session.delete(row)
        if type(request.json['subject']) == int:
            bsub = Behavior_Subject(
                behavior_id=b.id,
                subject_id=int(request.json['subject'])
            )
            db.session.add(bsub)
        elif type(request.json['subject']) == list:
            for i in request.json['subject']:
                bsub = Behavior_Subject(
                    behavior_id=b.id,
                    subject_id=int(i)
                )
                db.session.add(bsub)

    if 'setting' in request.json:
        sett = Behavior_Setting.query.filter(Behavior_Setting.behavior_id == id)
        for row in sett:
            db.session.delete(row)
        if type(request.json['setting']) == int:
            bset = Behavior_Setting(
                behavior_id=b.id,
                setting_id=int(request.json['setting'])
            )
            db.session.add(bset)
        elif type(request.json['setting']) == list:
            for i in request.json['setting']:
                bset = Behavior_Setting(
                    behavior_id=b.id,
                    setting_id=int(i)
                )
                db.session.add(bset)

    db.session.commit()
    return jsonify(retrieve_behavior_info(b))
