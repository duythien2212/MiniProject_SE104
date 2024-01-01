import mysql.connector
import datetime
from Object import *

mydb = mysql.connector.connect(
  host="localhost",
  user="root",
  password="09062004pP@"
)
mycursor = mydb.cursor()
mycursor.execute("use quizapp")

def error(e):
    return f"Error: {e} !"

# Function: find a row that have same username in database
def findUserName(username):
    try:
        query = f"select * from user WHERE user_name = '{username}'"
        mycursor.execute(query)
        selected_row = mycursor.fetchone()
        if selected_row:
            return selected_row
        else:
            return False
    except Exception as e:
        return (error(e), 0)
    
def getUserName(username):
    try:
        query = f"select * from user WHERE user_name = '{username}'"
        mycursor.execute(query)
        selected_row = mycursor.fetchone()
        if selected_row:
            return USER(*selected_row)
        else:
            return False
    except Exception as e:
        return (error(e), 0)

# Function: check if username in database. If yes then check if password is match to the password of that username
def login(username, password):
    try:
        selected_row = findUserName(username)
        if selected_row:
            userInstance = USER(*selected_row)
            if password == userInstance.getPassword():
                return ("Đăng nhập thành công !", 1)
            else:
                return ("Sai mật khẩu !", 0)
        else:
            return ("Không tìm thấy Username trong database !", 0)
    except Exception as e:
        return (error(e), 0)

# Function: check if username in database. if not yet then add into database
def register(lastname, firstname, email, username, password, cPassword):
    if password != cPassword:
        return ("Password Unmatching !", 0)
    if firstname == "" or lastname == "" or email == "" or username == "" or password == "":
        return ("Kiểm tra lại thông tin !", 0)
    try:
        selected_row = findUserName(username)
        if selected_row:
            return ("Tồn tại username !", 0)
        else:
            fullname = lastname + " " + firstname
            query = f"insert into user values (\'{123}\', \'{username}\', \'{email}\', \'{fullname}\', \'{password}\', '0', '1')"
            mycursor.execute(query)
            mydb.commit()
            return ("Đăng ký thành công !", 1)
    except Exception as e:
        return (error(e), 0)

# Function: return all information of all quiz
def getInfoAllQuiz():
    try:
        query = f"select * from quiz where is_deleted = 0"
        mycursor.execute(query)
        selected_row = mycursor.fetchall()
        if selected_row:
            return [Quiz(*row) for row in selected_row]
        else:
            return []
    except Exception as e:
        return (error(e), 0)

# Function: create a new quiz and return it
def createQuiz(classID, nameQuiz, startTime, endTime, length, weight):
    try:
        quizID = None
        query = "insert into quiz values (%s, %s, %s, %s, %s, %s, %s, %s)"
        values = (quizID, classID, nameQuiz, startTime, endTime, length, weight, 0)
        mycursor.execute(query, values)
        query = f"select * from quiz where quizID = {quizID}"
        mycursor.execute(query)
        row = mycursor.fetchone()
        mydb.commit()
        return Quiz(*row)
    except Exception as e:
        return (error(e), 0)

# Function: get all information of all class
def getClass():
    try:
        query = f"select * from class where is_deleted = 0"
        mycursor.execute(query)
        selected_row = mycursor.fetchall()
        if selected_row:
            return [Class(*row) for row in selected_row]
        else:
            return list()
    except Exception as e:
        return (error(e), 0)

def getClassofUser(studentID):
    try:
        query = f"select class_id from student_in_class where student_id = {studentID}"
        mycursor.execute(query)
        selected_row = mycursor.fetchall()
        if selected_row:
            return [row[0] for row in selected_row]
        else:
            return list()
    except Exception as e:
        return (error(e), 0)

# Function: get all information of a quiz
def getInfoQuiz(quizID):
    try:
        query = f"select * from quiz where quiz_id = {quizID} and is_deleted = 0"
        mycursor.execute(query)
        selected_row = mycursor.fetchone()
        if selected_row:
            return (Quiz(*selected_row), 1)
        else:
            return ("Không tồn tại quiz !", 0)
    except Exception as e:
        return (error(e), 0)

# Function: get all information of a question
def getInfoQuestion(questionID):
    try:
        query = f"select * from quiz_question where question_id = {questionID}"
        mycursor.execute(query)
        selected_row = mycursor.fetchone()
        infoQuestion = []
        for i in range(3, 7):
            infoQuestion.append(selected_row[i])
        return Question(selected_row[0], selected_row[1], selected_row[2], infoQuestion, selected_row[7], selected_row[8])
    except Exception as e:
        return (error(e), 0)

def getQuestionInQuiz(quiz_id):
    try:
        query = f"select question_id from quiz_question where quiz_id = '{quiz_id}' and is_deleted = 0"
        mycursor.execute(query)
        selected_row = mycursor.fetchall()
        listQuestion = []
        if selected_row:
            listQuestion.extend(row[0] for row in selected_row)
        return listQuestion
    except Exception as e:
        return (error(e), 0)

def getQuizinClass(classID):
    try:
        query = f"select * from quiz where class_id = '{classID}' and is_deleted = 0"
        mycursor.execute(query)
        selected_row = mycursor.fetchall()
        listQuiz = []
        if selected_row:
            listQuiz = [Quiz(*row) for row in selected_row]
        return listQuiz
    except Exception as e:
        return error(e)
    
# Function: get info of all notification.
def getAllNoti():
    try:
        query = f"select * from notification where isDeleted = 0"
        mycursor.execute(query)
        selected_row = mycursor.fetchall()
        listNoti = []
        if selected_row:
            listNoti = [Notification(*row) for row in selected_row]
        return listNoti
    except Exception as e:
        return (error(e), 0)
    
def createNoti(title, content, classID):
    try:
        query = f"select count(*) from class where class_id = '{classID}' and is_deleted = 0"
        mycursor.execute(query)
        selected_row = mycursor.fetchone()
        count = int(selected_row[0])
        if count == 0:
            return ("Không tồn tại lớp có mã ID phù hợp !", 0)
        query = "select count(*) from notification"
        mycursor.execute(query)
        selected_row = mycursor.fetchone()
        notiID = int(selected_row[0])
        query = "insert into notification values (%s, %s, %s, %s, %s, %s)"
        values = (notiID, title, content, classID, datetime.datetime.now(), 0)
        mycursor.execute(query, values)
        mydb.commit()
        return ("Tạo thành công !", 1)
    except Exception as e:
        return (error(e), 0)

#user = register("Lê", "Bình Nguyên", "2252xxxx@gm.uit.edu.vn", "hahaha", "123", "123")