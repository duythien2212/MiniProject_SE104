from flask import Flask, request, jsonify
from AccessData import *
import flask_cors
import json

app = Flask(__name__)

@app.route('/api/login', methods=['POST'])
def callLogin():
    data = json.loads(request.data.decode("utf-8"))
    username = data['username']
    password = data['password']
    message = login(username, password)
    response_data = {"message": message[0], 
                     "status" : message[1]}
    return jsonify(response_data)

@app.route('/api/register', methods=['POST'])
def callRegister():
    data = json.loads(request.data.decode("utf-8"))
    lastname = data['lastname']
    firstname = data['firstname']
    username = data['username']
    email = data['email']
    password = data['password']
    cPassword = data['cPassword']
    message = register(lastname, firstname, email, username, password, cPassword)
    respone_data = {"message": message[0],
                    "status" : message[1]}
    return jsonify(respone_data)


if __name__ == '__main__':
    flask_cors.CORS(app, max_age=3600)
    app.run(port=4000)  # Run on all interfaces