from flask import Blueprint, jsonify, abort, request
from ..models import Student, db

bp = Blueprint('students', __name__, url_prefix='/students')


@bp.route('', methods=['GET'])
def index():
    students = Student.query.all()
    result = []
    for s in students:
        result.append(s.serialize())
    return jsonify(result)


@bp.route('/<int:id>', methods=['GET'])
def show(id: int):
    s = Student.query.get_or_404(id)
    return jsonify(s.serialize())

@bp.route('', methods=['POST'])
def create():
    required_elements = ['first_name', 'last_name', 'grade', 'case_manager']
    for e in required_elements:
        if e not in request.json:
            return abort(400, description='Missing required element(s).')
    s = Student(
        first_name=request.json['first_name'],
        last_name=request.json['last_name'],
        grade=request.json['grade'],
        case_manager=request.json['case_manager'],
        student_id=request.json['student_id']
    )
    db.session.add(s)
    db.session.commit()
    return jsonify(s.serialize())

@bp.route('/<int:id>', methods=['DELETE'])
def delete(id: int):
    s = Student.query.get_or_404(id)
    try:
        db.session.delete(s)
        db.session.commit()
        return jsonify(True)
    except:
        return jsonify(False)

@bp.route('/<int:id>', methods=['PATCH'])
def update(id: int):
    s = Student.query.get_or_404(id)

    if 'first_name' in request.json:
        s.first_name = request.json['first_name']
    if 'last_name' in request.json:
        s.last_name = request.json['last_name']
    if 'grade' in request.json:
        s.grade = request.json['grade']
    if 'case_manager' in request.json:
        s.case_manager = request.json['case_manager']
    if 'student_id' in request.json:
        s.student_id = request.json['student_id']
    
    db.session.commit()
    return jsonify(s.serialize())

