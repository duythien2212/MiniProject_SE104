from flask import Flask, request, jsonify
from AccessData import *

app = Flask(__name__)

@app.route('/api/login', methods=['POST'])
def callLogin():
    data = request.get_json()

    username = data.get('username')
    password = data.get('password')
    message = login(username, password)
    response_data = {"message": message[0], 
                     "status" : message[1]}
    return jsonify(response_data)
