import pandas as pd
import random
import os 

user = pd.read_excel(r'D:\UIT\HOC KI 3\Nhập môn SE\Thực hành\import_data\user_table.xlsx')
classes = pd.read_excel(r'D:\UIT\HOC KI 3\Nhập môn SE\Thực hành\import_data\class_table.xlsx')
quiz = pd.read_excel(r'D:\UIT\HOC KI 3\Nhập môn SE\Thực hành\import_data\quiz_table.xlsx')
question = pd.read_excel(r'D:\UIT\HOC KI 3\Nhập môn SE\Thực hành\import_data\quiz_question.xlsx')
## Fill nan
user = user.fillna('')
classes = classes.fillna('')
quiz = quiz.fillna('')
question = question.fillna('')
##
##  Make user example
##
def make_user():
    n = len(user['ID'])
    print(n)
    file = open('import_user.sql', mode='w', encoding="utf-8")
    file.write('USE `QuizApp`;\n')
    file.write('LOCK TABLES `USER` WRITE;\n')

    for i in range(n):
        cmd = f'''INSERT INTO `USER` VALUES (\'{user['ID'][i]}\',
                                            \'{user['USER_NAME'][i]}\',
                                            \'{user['EMAIL'][i]}\',
                                            \'{user['NAME'][i]}\',
                                            \'{user['PASSWORD'][i]}\',
                                            \'{user['IS_TEACHER'][i]}\',
                                            \'{user['IS_DELETED'][i]}\');\n'''
        file.write(cmd)
    file.write('UNLOCK TABLES;\n')
    file.close()
##
##  Make class example
##
def make_class():
    n = len(classes['CLASS_ID'])
    print(n)
    file = open('import_class.sql', mode='w', encoding="utf-8")
    file.write('USE `QuizApp`;\n')
    file.write('LOCK TABLES `CLASS` WRITE;\n')

    for i in range(n):
        cmd = f'''INSERT INTO `CLASS` VALUES (\'{classes['CLASS_ID'][i]}\',
                                            \'{classes['CLASS_NAME'][i]}\',
                                            \'{classes['TEACHER_ID'][i]}\',
                                            \'{classes['IS_DELETED'][i]}\');\n'''
        file.write(cmd)
    file.write('UNLOCK TABLES;\n')
    file.close()
##
##  Make student_in_class example
##
def make_student_in_class():
    n = len(classes['CLASS_ID'])*len(user['ID'])//2
    print(n)
    root_ID = 240001
    file = open('import_student_in_class.sql', mode='w', encoding="utf-8")
    file.write('USE `QuizApp`;\n')
    file.write('LOCK TABLES `STUDENT_IN_CLASS` WRITE;\n')

    for i in range(n):
        cmd = f'''INSERT INTO `STUDENT_IN_CLASS` VALUES (\'{root_ID + i}\',
                                                        \'{classes['CLASS_ID'][i % len(classes['CLASS_ID'])]}\',
                                                        \'{user['ID'][i % (len(user['ID'])-7) + 7]}\',
                                                        \'{round(random.random()*5 + 5, 2)}\',
                                                        \'0\');\n'''
        file.write(cmd)
    file.write('UNLOCK TABLES;\n')
    file.close()
##
##  Make quiz example
##
def make_quiz():
    n = len(quiz['QUIZ_ID'])
    print(n)

    file = open('import_quiz.sql', mode='w', encoding="utf-8")
    file.write('USE `QuizApp`;\n')
    file.write('LOCK TABLES `QUIZ` WRITE;\n')

    for i in range(n):
        cmd = f'''INSERT INTO `QUIZ` VALUES (\'{quiz['QUIZ_ID'][i]}\',
                                            \'{quiz['CLASS_ID'][i]}\',
                                            \'{quiz['QUIZ_NAME'][i]}\',
                                            \'{quiz['START_TIME'][i]}\',
                                            \'{quiz['END_TIME'][i]}\',
                                            \'{quiz['LENGTH'][i]}\',
                                            \'{quiz['WEIGHT'][i]}\',
                                            \'{quiz['IS_DELETED'][i]}\');\n'''
        file.write(cmd)
    file.write('UNLOCK TABLES;\n')
    file.close()
##
##  Make quiz question example
##
def make_question():
    n = len(question['QUESTION_ID'])
    print(n)

    file = open('import_question.sql', mode='w', encoding="utf-8")
    file.write('USE `QuizApp`;\n')
    file.write('LOCK TABLES `QUIZ_QUESTION` WRITE;\n')

    for i in range(n):
        cmd = f'''INSERT INTO `QUIZ_QUESTION` VALUES (\'{question['QUESTION_ID'][i]}\',
                                            \'{question['QUIZ_ID'][i]}\',
                                            \'{question['QUESTION'][i]}\',
                                            \'{question['ANSWER_1'][i]}\',
                                            \'{question['ANSWER_2'][i]}\',
                                            \'{question['ANSWER_3'][i]}\',
                                            \'{question['ANSWER_4'][i]}\',
                                            \'{question['CORRECT_ANSWER'][i]}\',
                                            \'{question['IS_DELETED'][i]}\');\n'''
        file.write(cmd)
    file.write('UNLOCK TABLES;\n')
    file.close()
##
##  Make score example
##
def make_score():
    n = len(quiz['QUIZ_ID'])*len(user['ID'])//2
    print(n)

    root_ID = 120001

    file = open('import_score.sql', mode='w', encoding="utf-8")
    file.write('USE `QuizApp`;\n')
    file.write('LOCK TABLES `SCORE` WRITE;\n')

    for i in range(n):
        cmd = f'''INSERT INTO `SCORE` VALUES (\'{root_ID + i}\',
                                            \'{quiz['QUIZ_ID'][i % len(quiz['QUIZ_ID'])]}\',
                                            \'{user['ID'][i % (len(user['ID'])-7) + 7]}\',
                                            \'{random.randint(0,3)}\',
                                            \'{random.randint(0,3)}\',
                                            \'0\');\n'''
        file.write(cmd)
    file.write('UNLOCK TABLES;\n')
    file.close()

make_user()
make_class()
make_student_in_class()
make_quiz()
make_question()
make_score()
os.system('mysql -u root -p < import_user.sql')
os.system('mysql -u root -p < import_class.sql')
os.system('mysql -u root -p < import_student_in_class.sql')
os.system('mysql -u root -p < import_quiz.sql')
os.system('mysql -u root -p < import_question.sql')
os.system('mysql -u root -p < import_score.sql')