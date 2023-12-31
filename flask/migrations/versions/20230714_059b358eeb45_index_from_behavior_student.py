"""Index from Behavior.student

Revision ID: 059b358eeb45
Revises: d9fea819a191
Create Date: 2023-07-14 17:42:05.617788

"""
from alembic import op
import sqlalchemy as sa


# revision identifiers, used by Alembic.
revision = '059b358eeb45'
down_revision = 'd9fea819a191'
branch_labels = None
depends_on = None


def upgrade():
    # ### commands auto generated by Alembic - please adjust! ###
    op.create_index(op.f('ix_behaviors_student'), 'behaviors', ['student'], unique=False)
    # ### end Alembic commands ###


def downgrade():
    # ### commands auto generated by Alembic - please adjust! ###
    op.drop_index(op.f('ix_behaviors_student'), table_name='behaviors')
    # ### end Alembic commands ###
