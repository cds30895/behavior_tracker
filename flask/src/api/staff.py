from flask import Blueprint, jsonify, abort, request
from ..models import Staff, db

bp = Blueprint('staff', __name__, url_prefix='/staff')

@bp.route('', methods=['GET'])
def index():
    staff = Staff.query.all()
    result = []
    for s in staff:
        result.append(s.serialize())
    return jsonify(result)

@bp.route('/<int:id>', methods=['GET'])
def show(id: int):
    s = Staff.query.get_or_404(id)
    return jsonify(s.serialize())

@bp.route('', methods=['POST'])
def create():
    required_elements = ['first_name', 'last_name']
    for e in required_elements:
        if e not in request.json:
            return abort(400, description='Missing required element(s)')
    if 'email' in request.json:
        s = Staff(
            first_name=request.json['first_name'],
            last_name=request.json['last_name'],
            email=request.json['email']
        )
    else:
        s = Staff(
            first_name=request.json['first_name'],
            last_name=request.json['last_name'],
            email=None
        )
    db.session.add(s)
    db.session.commit()
    return jsonify(s.serialize())

@bp.route('/<int:id>', methods=['DELETE'])
def delete(id: int):
    s = Staff.query.get_or_404(id)
    try:
        db.session.delete(s)
        db.session.commit()
        return jsonify(True)
    except:
        return jsonify(False)

@bp.route('/<int:id>', methods=['PATCH'])
def update(id: int):
    s = Staff.query.get_or_404(id)

    if 'first_name' in request.json:
        s.first_name = request.json['first_name']
    if 'last_name' in request.json:
        s.last_name = request.json['last_name']
    if 'email' in request.json:
        s.email = request.json['email']

    db.session.commit()
    return jsonify(s.serialize())
