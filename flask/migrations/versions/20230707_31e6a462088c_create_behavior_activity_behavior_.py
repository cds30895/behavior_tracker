"""create behavior_activity, behavior_subject, behavior_setting tables

Revision ID: 31e6a462088c
Revises: 9f211bf6d33b
Create Date: 2023-07-07 13:59:11.189239

"""
from alembic import op
import sqlalchemy as sa


# revision identifiers, used by Alembic.
revision = '31e6a462088c'
down_revision = '9f211bf6d33b'
branch_labels = None
depends_on = None


def upgrade():
    # ### commands auto generated by Alembic - please adjust! ###
    op.create_table('behaviors_activities',
    sa.Column('behavior_id', sa.Integer(), nullable=False),
    sa.Column('activity_id', sa.Integer(), nullable=False),
    sa.ForeignKeyConstraint(['activity_id'], ['activities.id'], ),
    sa.ForeignKeyConstraint(['behavior_id'], ['behaviors.id'], ),
    sa.PrimaryKeyConstraint('behavior_id', 'activity_id')
    )
    op.create_table('behaviors_settings',
    sa.Column('behavior_id', sa.Integer(), nullable=False),
    sa.Column('setting_id', sa.Integer(), nullable=False),
    sa.ForeignKeyConstraint(['behavior_id'], ['behaviors.id'], ),
    sa.ForeignKeyConstraint(['setting_id'], ['settings.id'], ),
    sa.PrimaryKeyConstraint('behavior_id', 'setting_id')
    )
    op.create_table('behaviors_subjects',
    sa.Column('behavior_id', sa.Integer(), nullable=False),
    sa.Column('subject_id', sa.Integer(), nullable=False),
    sa.ForeignKeyConstraint(['behavior_id'], ['behaviors.id'], ),
    sa.ForeignKeyConstraint(['subject_id'], ['subjects.id'], ),
    sa.PrimaryKeyConstraint('behavior_id', 'subject_id')
    )
    # ### end Alembic commands ###


def downgrade():
    # ### commands auto generated by Alembic - please adjust! ###
    op.drop_table('behaviors_subjects')
    op.drop_table('behaviors_settings')
    op.drop_table('behaviors_activities')
    # ### end Alembic commands ###
