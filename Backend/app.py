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
    response_data = {"message": message[0],
                    "status" : message[1]}
    return jsonify(response_data)

@app.route('/api/notification', methods=['GET'])
def callNoti():
    listNoti = getAllNoti()
    stoNoti = []
    for noti in listNoti:
        print(noti)
        stoNoti.append({"title": noti.title, "content": noti.content, "date": noti.date})
    response_data = {"notifications": stoNoti}
    return jsonify(response_data)

@app.route('/api/profile/<username>', methods=['GET'])
def callProfile(username):
    userInstance = findUserName(username)
    response_data = {"username": userInstance.userName,
                    "name": userInstance.name,
                    "class": userInstance.classes,
                    "email": userInstance.email}
    return jsonify(response_data)

@app.route('/api/createNoti', methods=['POST'])
def callCreateNoti():
    data = json.loads(request.data.decode("utf-8"))
    title = data['title']
    content = data['content']
    classID = data['classID']
    message = createNoti(title, content, classID)
    response_data = {"message": message[0],
                     "status": message[1]}
    return jsonify(response_data)

@app.route('/api/class', methods=['GET'])
def callClass():
    listClass = getClass()
    teacher = getUserName(cl.teacherID)
    stoClass = []
    for cl in listClass:
        stoClass.append({"classID": cl.classID,
                        "className": cl.className,
                        "teacherName": teacher.name})
    response_data = {"class": stoClass}
    return jsonify(response_data)

@app.route('/api/infoQuiz/<quizID>', methods=["GET"])
def callInfofQuiz(quizID):
    quizInfo = getInfoQuiz(quizID)
    if quizInfo[1] == 0:
        return jsonify({"message": quizInfo[0],
                        "status": quizInfo[1]})
    else:
        response_data = {"quizName": quizInfo.quizName, 
                        "startTime": quizInfo.startTime,
                        "endTime"  : quizInfo.endTime,
                        "length"   : quizInfo.length,
                        "weight"   : quizInfo.weight}
        return jsonify(response_data)

@app.route('/api/quizList/<classID>', methods=["GET"])
def callgetQuizinClass(classID):
    quizList = getQuizinClass(classID)
    stoQuiz = []
    for quiz in quizList[0]:
        stoQuiz.append({"name": quiz.quizName,
                        "endTime": quiz.endTime,
                        "weight": quiz.weight})
    response_data = {"quiz": stoQuiz}
    return jsonify(response_data)

@app.route('/api/updateProfile/<username>', methods=['POST'])
def callUpdateProfile(username):
    data = json.loads(request.data.decode("utf-8"))
    firstname = data['firstname']
    lastname = data['lastname']
    email = data['email']
    message = updateProfile(username, firstname, lastname, email)
    response_data = {"message": message[0],
                     "status": message[1]}
    return jsonify(response_data)

@app.route('/api/updatePassword/<username>', methods=['POST'])
def callUpdatePassword(username):
    data = json.loads(request.data.decode("utf-8"))
    oldPassword = data['oldPassword']
    newPassword = data['newPassword']
    cPassword = data['cPassword']
    message = updatePassword(username, oldPassword, newPassword, cPassword)
    response_data = {"message": message[0],
                     "status": message[1]}
    return jsonify(response_data)

if __name__ == '__main__':
    flask_cors.CORS(app, max_age=3600)
    app.run(port=4000)