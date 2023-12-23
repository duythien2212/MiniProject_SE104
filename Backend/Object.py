import random
import mysql.connector

class Class:
    def __init__(self, classID, className, teacherID, isDeleted):
        self.classID = classID
        self.className = className
        self.teacherID = teacherID
        self.isDeleted = isDeleted

    def delete(self):
        self.isDeleted = 1
    

class Quiz:
    def __init__(self, quizID, classID, quizName, startTime, endTime, length, weight, isDeleted, listQuestion=""):
        self.quizID = quizID
        self.classID = classID
        self.quizName = quizName
        self.startTime = startTime
        self.endTime = endTime
        self.length = length
        self.weight = weight
        self.isDeleted = isDeleted
        self.listQuestion = listQuestion
    
    def addQuestion(self, question):
        list.append(question)

    def deleteQuestion(self):
        self.isDeleted = 1

    def getStartTime(self):
        return self.startTime

    def getEndTime(self):
        return self.endTime
    
    def setStartTime(self, startTime):
        self.startTime = startTime
    
    def setEndTime(self, endTime):
        self.endTime = endTime
    
    def getWeight(self):
        return self.weight

    def setWeight(self, weight):
        self.weight = weight
    
    def setLenght(self, length):
        self.length = length
    
    def getLenght(self):
        return self.length
    
class Question:
    def __init__(self, questionID, question, listAnswer, correctAnswer):
        self.questionID = questionID
        self.question = question
        self.listAnswer = listAnswer
        self.correctAnswer = correctAnswer
    
    def changeQuesttion(self, question):
        self.question = question
    
    def changeAnswer(self, id, answer):
        self.listAnswer[id] = answer
    
    def changeCorrectAnswer(self, trueID):
        self.correctAnswer = trueID
    
    def shuffleAnswer(self):
        shuffledList = random.sample(self.listAnswer, len(self.listAnswer))
        return shuffledList


class USER:
    def __init__(self, ID, userName, email, name, password, isTeacher, isDeleted, classes=""):
        self.ID = ID
        self.userName = userName
        self.password = password
        self.email = email
        self.name = name
        self.classes = classes
        self.isDeleted = isDeleted
        self.isTeacher = isTeacher
    
    def getPassword(self):
        return self.password
    
    def changePassword(self, oldPassword, newPassword):
        if oldPassword == self.password:
            self.password = newPassword
            return True
        else:
            return False
    
    def getID(self):
        return self.ID
    
    def getUserName(self):
        return self.userName

    def attemptQuizz(self):
        pass

    def getScoreBoard(self):
        pass

class Teacher(USER):
    def getScoreBoard(self):
        pass
    
    def addQuiz(self, quiz):
        pass

    def deleteQuiz(self, quiz):
        quiz.isDeleted = 1
    
    def deleteQuestion(self):
        pass

class Student(USER):
    def getClass(self):
        return self.classes
    
    def getScoreBoard(self):
        pass