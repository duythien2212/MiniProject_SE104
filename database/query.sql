USE quizapp;
--
-- Get password from user_name, input: user_name
--
-- SELECT password FROM user WHERE user.USER_NAME="27520001";
--

-- Get notification about deadline, input: user_id
-- Remove comment below to select quiz have deadline > now.
-- SELECT DISTINCT q.QUIZ_NAME ,q.END_TIME as DEADLINE FROM QUIZ q,  STUDENT_IN_CLASS sic WHERE sic.STUDENT_ID = "27520008" AND sic.CLASS_ID = q.CLASS_ID -- AND q.END_TIME > NOW();
-- 

-- Get information about user, input: user_name
--
-- SELECT user_name, name, email FROM user WHERE user_name="27520001";
--

-- Get class of student, input: student_id
--
-- SELECT DISTINCT cl.CLASS_NAME, user.NAME as Teacher_Name FROM class cl, student_in_class sic, user WHERE sic.STUDENT_ID="27520012" AND sic.CLASS_ID = cl.CLASS_ID AND cl.TEACHER_ID = user.ID
--

-- Get class of teacher, input: teacher_id
--
-- SELECT cl.CLASS_NAME, COUNT(DISTINCT sic.STUDENT_ID) as Number_Of_Student FROM class cl, student_in_class sic WHERE cl.CLASS_ID = sic.CLASS_ID GROUP BY sic.CLASS_ID;
--

-- Get quiz, input: class_id
--
-- SELECT QUIZ_NAME as NAME, START_TIME as START, END_TIME as END, LENGTH, WEIGHT FROM quiz WHERE CLASS_ID="IT002";
--

-- Get question, input: quiz_id
--
-- SELECT question, answer_1 as A, answer_2 as B, answer_3 as C, answer_4 as D, correct_answer FROM quiz_question WHERE quiz_id="73002";
--

-- Student get score, input: student_id, quiz_id
-- 
-- SELECT number_of_correct, try FROM score WHERE student_id="27520014" AND quiz_id="73007";
--