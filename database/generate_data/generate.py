import pandas as pd
import random
import os
user = pd.read_excel('user_table.xlsx')

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

make_user()
os.system('mysql -u root -p < import_user.sql')