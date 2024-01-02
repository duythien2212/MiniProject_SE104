from flask import Flask, request, jsonify
from AccessData import *
import flask_cors
import json
import io
import pandas as pd

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

@app.route('/api/notification', methods=['GET'])
def callNoti():
    listNoti = getAllNoti()
    stoNoti = []
    for noti in listNoti:
        stoNoti.append({"title": noti.title, "content": noti.content, "date": noti.date})
    respone_data = {"notifications": stoNoti}
    return jsonify(respone_data)

@app.route('/api/profile/<username>', methods=['GET'])
def callProfile(username):
    userInstance = findUserName(username)
    respone_data = {"username": userInstance.userName,
                    "name": userInstance.name,
                    "class": userInstance.classes,
                    "email": userInstance.email}
    return jsonify(respone_data)

@app.route('/api/class', methods=['GET'])
def callClass():
    listClass = getClass()
    teacher = getUserName(cl.teacherID)
    stoClass = []
    for cl in listClass:
        stoClass.append({"classID": cl.classID,
                        "className": cl.className,
                        "teacherName": teacher.name})
    respone_data = {"class": stoClass}
    return jsonify(respone_data)

@app.route('/api/infoQuiz/<quizID>', methods=["GET"])
def callInfoQuiz(quizID):
    quizInfo = getInfoQuiz(quizID)
    
@app.route('/api/createClass', methods=['POST'])
def callMakeClass():
    input = json.loads(request.data.decode("utf-8"))
    b = io.BytesIO(input)
    data = pd.read_excel(b.read())

    clss = {'classID': None,'className': None, 'teacherID': None}
    clss['classID'] = data['classID']
    clss['className'] = data['className']
    clss['teacherID'] = data['teacherID']
    response_data = makeClass(clss)

    lst_student = data['student']
    addStudentToDatabase(listStudent=lst_student, classID=data['classID'])

    return jsonify(response_data)

@app.route('/api/createQuiz', methods=['POST'])
def callMakeClass():
    input = json.loads(request.data.decode("utf-8"))
    b = io.BytesIO(input)
    data = pd.read_excel(b.read())

    quiz = {'classID':None, 'quizName':None, 'startTime':None, 'endTime':None, 'length':None, 'weight':None}
    quiz['classID'] = data['classID']
    quiz['quizName'] = data['quizName']
    quiz['startTime'] = data['startTime']
    quiz['endTime'] = data['endTime']
    quiz['length'] = data['length']
    quiz['weight'] = data['weight']
    response_data = makeQuiz(quiz)
    
    lst_question = data['listQuestion']
    addQuestionToDatabase(listQuestion=lst_question, quizID=response_data[1])
    return jsonify(response_data[0])

if __name__ == '__main__':
    flask_cors.CORS(app, max_age=3600)
    app.run(port=4000)  # Run on all interfaces
