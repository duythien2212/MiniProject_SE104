import mysql.connector
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
        query = f"select * from user WHERE user_name = '{username}' and is_deleted = 0"
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
        query = f"select * from user WHERE user_name = '{username}' and is_deleted = 0"
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
            query = f"insert into user values ('{username}', '{email}', '{fullname}', '{password}', '0', '1')"
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
def createQuestion(quizID, content, listAnswer, correctAnswer):
    query = f"select count(*) from quiz_question"
    mycursor.execute(query)
    selected_row = mycursor.fetchone()
    cnt = int(selected_row[0])
    query = f"insert into quiz_question values ({cnt}, '{quizID}', '{content}', '{listAnswer[0]}', '{listAnswer[1]}', '{listAnswer[2]}', '{listAnswer[3]}', '{correctAnswer}', 0)"
    mycursor.execute(query)

def createQuiz(classID, nameQuiz, startTime, endTime, length, weight, listQuestion):
    try:
        query = "select count(*) from quiz"
        mycursor.execute(query)
        selected_row = mycursor.fetchone()
        quizID = int(selected_row[0])
        query = "insert into quiz values (%s, %s, %s, %s, %s, %s, %s, %s)"
        values = (quizID, classID, nameQuiz, startTime, endTime, length, weight, 0)
        mycursor.execute(query, values)
        for question in listQuestion:
            content = question['content']
            listAnswer = question['listAnswer']
            correctAnswer = question['correctAnswer']
            if correctAnswer < 0 or correctAnswer > 3:
                return {"Đáp án đúng phải nằm trong khoảng từ 1 đến 4", 0}
            createQuestion(quizID, content, listAnswer, correctAnswer)
        mydb.commit()
        return {"Tạo quiz thành công !", 0}
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

def getClassofUser(username):
    try:
        query = f"select distinct class_id from student_in_class where student_id = {username} and is_deleted = 0"
        mycursor.execute(query)
        selected_row = mycursor.fetchall()
        if selected_row:
            stoClass = []
            for row in selected_row:
                query = f"select * from class where is_deleted = 0 and class_id = '{row[0]}'"
                mycursor.execute(query)
                selected = mycursor.fetchone()
                stoClass.append(Class(*selected))
            return stoClass
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

def getQuestion(selected_row):
    infoQuestion = []
    for i in range(3, 7):
        infoQuestion.append(selected_row[i])
    return Question(selected_row[0], selected_row[1], selected_row[2], infoQuestion, selected_row[7], selected_row[8])

# Function: get all information of a question
def getInfoQuestion(questionID):
    try:
        query = f"select * from quiz_question where question_id = {questionID} and is_deleted = 0"
        mycursor.execute(query)
        selected_row = mycursor.fetchone()
        if selected_row:
            return (getQuestion(selected_row), 1)
        else:
            return ("Không tìm thấy câu hỏi !", 0)
    except Exception as e:
        return (error(e), 0)

def getQuestionInQuiz(quiz_id):
    try:
        print(quiz_id)
        query = f"select * from quiz_question where quiz_id = {quiz_id} and is_deleted = 0"
        print(query)
        mycursor.execute(query)
        selected_row = mycursor.fetchall()
        listQuestion = []
        if selected_row:
            listQuestion = [getQuestion(row) for row in selected_row]
        return listQuestion
        
    except Exception as e:
        print(error(e))
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
        query = f"select * from notification where is_deleted = 0"
        mycursor.execute(query)
        selected_row = mycursor.fetchall()
        listNoti = []
        if selected_row:
            listNoti = [Notification(*row) for row in selected_row]
        return listNoti
    except Exception as e:
        return (error(e), 0)    

def getAllNotiinClass(username):
    try:
        stoClass = getClassofUser(username)
        if len(stoClass) == 0:
            return []
        stoClassID = [cl.classID for cl in stoClass]
        query = "select * from notification where class_id in ('{}')".format("','".join(map(str, stoClassID)))
        mycursor.execute(query)
        selected_row = mycursor.fetchall()
        listNoti = []
        if selected_row:
            listNoti = [Notification(*row) for row in selected_row]
        return listNoti
    except Exception as e:
        return (error(e), 0)

print(getAllNotiinClass("27520010"))
    
def createNoti(title, content, classID, date):
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
        values = (notiID, title, content, classID, date, 0)
        mycursor.execute(query, values)
        mydb.commit()
        return ("Tạo thành công !", 1)
    except Exception as e:
        return (error(e), 0)

def updateProfile(username, firstname, lastname, email):
    try:
        userInstance = getUserName(username)
        if userInstance == False:
            return ("Không tồn tại username !", 0)
        if firstname == "":
            firstname = " ".join(userInstance.name.split()[1:])
        if lastname == "":
            lastname = userInstance.name.split()[0]
        newName = lastname + " " + firstname
        if email == "":
            email = userInstance.email
        query = f"update user set name = '{newName}', email = '{email}' where user_name = '{username}' and is_deleted = 0"
        mycursor.execute(query)
        mydb.commit()
        return ("Thay đổi thành công !", 1)
    except Exception as e:
        return (error(e), 0)
    
def updatePassword(username, oldPassword, newPassword, cPassword):
    try:
        userInstance = getUserName(username)
        if userInstance == False:
            return ("Không tồn tại username !", 0)
        if oldPassword != userInstance.password:
            return ("Mật khẩu hiện tại không khớp với mật khẩu đã nhập !", 0)
        if newPassword == "":
            return ("Mật khẩu mới không được trống !", 0)
        if cPassword != newPassword:
            return ("Mật khẩu mới không đúng với mật khẩu xác nhận !", 0)
        query = f"update user set password = '{newPassword}' where user_name = '{username}' and is_deleted = 0"
        mycursor.execute(query)
        mydb.commit()
        return ("Thay đổi thành công !", 1)
    except Exception as e:
        return (error(e), 0)
    
def getAllScoreofUser(username):
    try:
        query = f"select * from score where student_id = '{username}' and is_deleted = 0"
        mycursor.execute(query)
        selected_row = mycursor.fetchall()
        listScore = []
        if selected_row:
            listScore = [Score(*row) for row in selected_row]
        stoScore = []
        for score in listScore:
            query = f"select quiz_name, length from quiz where quiz_id = {score.quizID}"
            mycursor.execute(query)
            selected_row = mycursor.fetchone()
            name = selected_row[0]
            cnt = int(selected_row[1])
            sc = score.numberofCorrect / cnt
            stoScore.append({"quizName": name,
                             "score": sc,
                             "date": score.date})
        response = {"message": stoScore,
                    "status": 1}
        return response
    
    except Exception as e:
        return (error(e), 0)

def createClass(username, classID, className, stoStudent):
    try:
        if findUserName(username) == False:
            return ("Không tồn tại username !", 0)
        query = f"select count(*) from class where class_id = '{classID}'"
        mycursor.execute(query)
        selected_row = mycursor.fetchone()
        cnt = int(selected_row[0])
        if cnt != 0:
            return ("Tồn tại mã lớp !", 0)
        query = f"insert into class values ('{classID}', '{className}', '{username}', 0)"
        mycursor.execute(query)
        for studentID in stoStudent:
            query = f"select count(*) from user where user_name = '{studentID}' and is_deleted = 0"
            mycursor.execute(query)
            selected_row = mycursor.fetchone()
            cnt = int(selected_row[0])
            if cnt == 0:
                return ("Không tồn tại username !", 0)
            query = f"select count(*) from student_in_class"
            mycursor.execute(query)
            selected_row = mycursor.fetchone()
            studnetInClassID = int(selected_row[0])
            query = f"insert into student_in_class values({studnetInClassID}, '{classID}', '{studentID}', NULL,0)"
            mycursor.execute(query)

        mydb.commit()
        return ("Tạo thành công !", 1)
    except Exception as e:
        return (error(e), 0)

def stoScore(quizID, username, numberofCorrect):
    try:
        query = f"select count(*) from score"
        mycursor.execute(query)
        selected_row = mycursor.fetchone()
        cnt = int(selected_row[0])
        query = f"insert into score values ({cnt}, {quizID}, '{username}', '{numberofCorrect}', 0)"
        mycursor.execute(query)
        selected_row = mycursor.fetchone()
        return ("Lưu thành công !", 1)
    except Exception as e:
        return (error(e), 0)
