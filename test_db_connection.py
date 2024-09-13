from flask import Flask
from flask_sqlalchemy import SQLAlchemy
import config

app = Flask(__name__)
app.config.from_object(config.Config)

db = SQLAlchemy(app)

class User(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(80))

@app.route('/')
def test_db_connection():
    try:
        # Cek koneksi ke database dengan melakukan query
        User.query.first()
        return "Connection to database is successful!"
    except Exception as e:
        return f"Error connecting to database: {str(e)}"

if __name__ == '__main__':
    app.run(debug=True)
