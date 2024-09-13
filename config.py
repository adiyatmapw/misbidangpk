import os

class Config:
    SECRET_KEY = os.environ.get('FLASK_SECRET_KEY', 'telkomuniv')
    SQLALCHEMY_DATABASE_URI = 'mysql://root:@localhost/spkbidangpk_db'
    SQLALCHEMY_TRACK_MODIFICATIONS = False
