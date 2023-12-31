"""Added ON DELETE SET NULL to fk students_staff

Revision ID: d9fea819a191
Revises: 31e6a462088c
Create Date: 2023-07-07 19:17:53.653241

"""
from alembic import op
import sqlalchemy as sa


# revision identifiers, used by Alembic.
revision = 'd9fea819a191'
down_revision = '31e6a462088c'
branch_labels = None
depends_on = None


def upgrade():
    # ### commands auto generated by Alembic - please adjust! ###
    op.drop_constraint('students_case_manager_fkey',
                       'students', type_='foreignkey')
    op.create_foreign_key('students_case_manager_fkey', 'students', 'staff', [
                          'case_manager'], ['id'], ondelete='SET NULL')
    # ### end Alembic commands ###


def downgrade():
    # ### commands auto generated by Alembic - please adjust! ###
    op.drop_constraint('students_case_manager_fkey',
                       'students', type_='foreignkey')
    op.create_foreign_key('students_case_manager_fkey',
                          'students', 'staff', ['case_manager'], ['id'])
    # ### end Alembic commands ###
