import os
from flask import Flask, jsonify, request
from flask_jwt_extended import JWTManager, jwt_required, create_access_token
from flask_sqlalchemy import SQLAlchemy
from dotenv import load_dotenv
from pyghmi.ipmi import command as ipmi_command
import pynvml

load_dotenv()

app = Flask(__name__)
app.config['SQLALCHEMY_DATABASE_URI'] = os.getenv('DATABASE_URL')
app.config['JWT_SECRET_KEY'] = os.getenv('JWT_SECRET_KEY')
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False

db = SQLAlchemy(app)
jwt = JWTManager(app)

class User(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    username = db.Column(db.String(80), unique=True, nullable=False)
    password = db.Column(db.String(120), nullable=False)

@app.route('/login', methods=['POST'])
def login():
    username = request.json.get('username', None)
    password = request.json.get('password', None)
    user = User.query.filter_by(username=username).first()
    if user and user.password == password:
        access_token = create_access_token(identity=username)
        return jsonify(access_token=access_token), 200
    return jsonify({"msg": "Bad username or password"}), 401

@app.route('/ipmi', methods=['GET'])
@jwt_required()
def get_ipmi_data():
    # Placeholder for IPMI functionality
    # In a real-world scenario, you would use pyghmi to interact with IPMI
    return jsonify({"msg": "IPMI data placeholder"}), 200

@app.route('/nvidia_smi', methods=['GET'])
@jwt_required()
def get_nvidia_smi_data():
    try:
        pynvml.nvmlInit()
        device_count = pynvml.nvmlDeviceGetCount()
        devices = []
        for i in range(device_count):
            handle = pynvml.nvmlDeviceGetHandleByIndex(i)
            name = pynvml.nvmlDeviceGetName(handle).decode('utf-8')
            memory = pynvml.nvmlDeviceGetMemoryInfo(handle)
            devices.append({
                "name": name,
                "total_memory": memory.total,
                "free_memory": memory.free,
                "used_memory": memory.used
            })
        pynvml.nvmlShutdown()
        return jsonify(devices), 200
    except Exception as e:
        return jsonify({"error": str(e)}), 500

if __name__ == '__main__':
    db.create_all()
    app.run(debug=True, host='0.0.0.0')
