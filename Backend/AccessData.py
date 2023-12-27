import mysql.connector
from Object import *

mydb = mysql.connector.connect(
  host="localhost",
  user="root",
  password="09062004pP@"
)
mycursor = mydb.cursor()
mycursor.execute("use quizapp")

# Parameter: usernamee
# Function: find a row that have same username in database
def findUserName(username):
    query = f"select * from user WHERE user_name = '{username}'"
    mycursor.execute(query)
    selected_row = mycursor.fetchone()
    if selected_row:
        return selected_row
    else:
        return False


# Parameter: username, password
# Function: check if username in database. If yes then check if password is match to the password of that username
def login(username, password):

    selected_row = findUserName(username)
    if selected_row:
        userInstance = USER(*selected_row)
        if password == userInstance.getPassword():
            print("Đăng nhập thành công !")
            return userInstance
        else:
            print("Sai mật khẩu !")
    else:
        print("Không tìm thấy Username trong Database !")
    
    return False

# Parameter: username, password
# Function: check if username in database. if not yet then add into database
def register(lastname, firstname, email, username, password, cPassword):
    if password != cPassword:
        return "Password Unmatching !"
    if firstname == "" or lastname == "" or email == "" or username == "" or password == "":
        return "Kiểm tra lại thông tin !"

    selected_row = findUserName(username)
    if selected_row:
        print("Tồn tại username !")
    else:
        fullname = lastname + " " + firstname
        query = f"insert into user values (\'{123}\', \'{username}\', \'{email}\', \'{fullname}\', \'{password}\', '0', '1')"
        mycursor.execute(query)
        mydb.commit()
        selected_row = findUserName(username)
        userInstance = USER(*selected_row)
        return userInstance

def getInfoAllQuiz():
    query = f"select quiz_name, end_time from quiz"
    mycursor.execute(query)
    selected_row = mycursor.fetchall()
    if selected_row:
        return list(*selected_row)
    else:
        return []

def createQuiz(classID, nameQuiz, startTime, endTime, length, weight):
    if weight < 0 or weight > 100:
        return False
    quizID = None
    query = "insert into quiz values (%s, %s, %s, %s, %s, %s, %s, %s)"
    values = (quizID, classID, nameQuiz, startTime, endTime, length, weight, 0)
    mycursor.execute(query, values)
    query = f"select * from quiz where quizID = {quizID}"
    mycursor.execute(query)
    row = mycursor.fetchone()
    return Quiz(*row)

def getClass():
    query = f"select * from class"
    mycursor.execute(query)
    selected_row = mycursor.fetchall()
    if selected_row:
        return list(Class(*selected_row))
    else:
        return list()

def getInfoQuiz(quizID):
    query = f"select * from quiz where quiz_id = {quizID}"
    mycursor.execute(query)
    selected_row = mycursor.fetchone()
    if selected_row:
        return list(Quiz(*selected_row))
    else:
        return list()

def getInfoQuestion(questionID):
    query = f"select quiz_question where question_id = {questionID}"
    mycursor.execute(query)
    selected_row = mycursor.fetchone()
    if selected_row:
        return list(Question(*selected_row))
    else:
        return list()
#user = register("Lê", "Bình Nguyên", "2252xxxx@gm.uit.edu.vn", "hahaha", "123", "123")