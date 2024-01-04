from flask import Flask, request, jsonify
from AccessData import *
import flask_cors
import json
import random
import datetime

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

@app.route('/api/notification/<username>', methods=['GET'])
def callNoti(username):
    listNoti = getAllNotiinClass(username)
    stoNoti = []
    for noti in listNoti:
        stoNoti.append({"title": noti.title, "content": noti.content, "date": str(noti.date), "classID": noti.classID})
    response_data = {"notifications": stoNoti}
    return jsonify(response_data)

@app.route('/api/notification', methods=['GET'])
def callgetAllNoti():
    listNoti = getAllNoti()
    stoNoti = []
    for noti in listNoti:
        print(noti)
        stoNoti.append({"title": noti.title, "content": noti.content, "date": str(noti.date), "classID": noti.classID})
    response_data = {"notifications": stoNoti}
    return jsonify(response_data)


@app.route('/api/profile/<username>', methods=['GET'])
def callProfile(username):
    userInstance = getUserName(username)
    response_data = {"username": userInstance.userName,
                    "name": userInstance.name,
                    "class": userInstance.classes,
                    "email": userInstance.email,
                    "isTeacher": userInstance.isTeacher}
    return jsonify(response_data)

@app.route('/api/createNoti', methods=['POST'])
def callCreateNoti():
    data = json.loads(request.data.decode("utf-8"))
    title = data['title']
    content = data['content']
    classID = data['classID']
    date = data['date']
    message = createNoti(title, content, classID, date)
    response_data = {"message": message[0],
                     "status": message[1]}
    return jsonify(response_data)

@app.route('/api/class/<username>', methods=['GET'])
def callClassofUser(username):
    listClass = getClassofUser(username)
    stoClass = []
    for cl in listClass:
        teacher = getUserName(cl.teacherID)
        stoClass.append({"classID": cl.classID,
                        "className": cl.className,
                        "teacherName": teacher.name})
    response_data = {"class": stoClass}
    return jsonify(response_data)

@app.route('/api/class', methods=['GET'])
def callClass():
    listClass = getClass()
    stoClass = []
    for cl in listClass:
        teacher = getUserName(cl.teacherID)
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
        response_data = {"quizID"  : quizInfo[0].quizID,
                        "quizName" : quizInfo[0].quizName, 
                        "startTime": quizInfo[0].startTime,
                        "endTime"  : quizInfo[0].endTime,
                        "length"   : quizInfo[0].length,
                        "weight"   : quizInfo[0].weight,
                        "status"   : quizInfo[1]}
        return jsonify(response_data)

@app.route('/api/quizList/<classID>', methods=["GET"])
def callgetQuizinClass(classID):
    quizList = getQuizinClass(classID)
    stoQuiz = []
    for quiz in quizList:
        stoQuiz.append({"quizID": quiz.quizID,
                        "name": quiz.quizName,
                        "startTime": quiz.startTime,
                        "endTime": quiz.endTime,
                        "length": quiz.length,
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

@app.route('/api/score/<username>', methods=['GET'])
def callgetAllScore(username):
    respone = getAllScoreofUser(username)
    return jsonify(respone)

@app.route('/api/createClass/<username>', methods=['POST'])
def callCreateClass(username):
    data = json.loads(request.data.decode("utf-8"))
    classID = data['classID']
    className = data['className']
    stoStudent = data['stoStudent']
    message = createClass(username, classID, className, stoStudent)
    response_data = {"message": message[0],
                  "status": message[1]}
    return jsonify(response_data)

@app.route('/api/createQuiz/<classID>', methods=['POST'])
def callCreateQuiz(classID):
    data = json.loads(request.data.decode("utf-8"))
    quizName = data['quizName']
    length = data['length']
    weight = data['weight']
    startTime = data['startTime']
    endTime = data['endTime']
    listQuestion = data['listQuestion']
    createQuiz(classID, quizName, startTime, endTime, length, weight, listQuestion)

@app.route('/api/getQuestionQuiz/<quizID>', methods=['GET'])
def callgetQuestioninQuiz(quizID):
    listQuestion = getQuestionInQuiz(quizID)
    stoQuestion = []
    if len(listQuestion) != 0:
        for question in listQuestion:
            correctAnswer = question.listAnswer[question.correctAnswer]
            stoQuestion.append({"question": question.question,
                            "listAnswer": question.shuffleAnswer(),
                            "correctAnswer": correctAnswer})
    response_data = {"message": stoQuestion}
    return jsonify(response_data)

@app.route('/api/stoScore/<username>', methods=['POST'])
def callStoScore(username):
    data = json.loads(request.data.decode("utf-8"))
    quizID = data['quizID']
    numberofCorrect = data['numberofCorrect']
    date = data['date']
    message = stoScore(quizID, username, numberofCorrect, date)
    response_data = {"message": message[0],
                     "status" : message[1]}
    return jsonify(response_data)

@app.route('api/deleteAccount/<username>', methods=['POST'])
def calldeleteAccount(username):
    message = deleteAccount(username)
    response_data = {"message": message[0],
                     "status" : message[1]}
    return response_data

@app.route('api/deleteClass/<username>', methods=['POST'])
def calldeleteClass(username):
    data = json.loads(request.data.decode("utf-8"))
    classID = data['classID']
    message = deleteClass(username, classID)
    response_data = {"message": message[0],
                     "status" : message[1]}
    return response_data

@app.route('api/deleteQuiz/<username>', methods=['POST'])
def calldeleteClass(username):
    data = json.loads(request.data.decode("utf-8"))
    quizID = data['quizID']
    message = deleteClass(username, quizID)
    response_data = {"message": message[0],
                     "status" : message[1]}
    return response_data

if __name__ == '__main__':
    flask_cors.CORS(app, max_age=3600)
    app.run(port=4000)