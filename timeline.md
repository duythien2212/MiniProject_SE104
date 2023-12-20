# Ngày 02-12-2023

## Nội dung:

- Đề xuất ý tưởng.
- Chốt việc làm tuần sau.
- dự kiến nội dung buổi họp tuần sau

## Đề xuất ý tưởng:

- Mạng xã hội nhỏ (Phước)
- Quản lí bán hàng (Duy Thiên)
- Quản lí mượn cơ sở vật chất (Duy Thắng)
- Simulate gg calender (Nguyên)
- Diễn đàn cuộc thi.
- Phần mềm làm bài tập, kiểm tra.

## Chốt việc tuần sau:

- Nguyên đi mail thầy:
    - hỏi rõ về việc tương tác, down file, up file như nào, quản lí file và xử lí file.
    - hỏi thầy còn mấy buổi
- suy nghĩ về thiết kế của phần mềm làm bài tập kiểm tra.

## Dự kiến nội dung buổi họp sau:

- Chốt đề tài.
- Chốt flatform.
- Chốt thiết kế (giao diện, vẽ diagram, timeline làm việc, chia việc)
- Chốt ngôn ngữ code.

# Ngày 07-12-2023

- Chốt làm app trắc nghiệm quizz (bỏ phần cập nhật thời gian)
- Làm app window
- Flutter
- Chốt chiều thứ 3 họp lại để thiết kế app (vẽ diagram, thiết kế database, giao diện, blabla)
- Duy Thiên tạo GitHub

# Ngày 20-12-2023

- Thiết kế giao diện: https://www.canva.com/design/DAF3elKFbP8/yBA5E9zyFqq8c1jY7g2FiQ/edit?utm_content=DAF3elKFbP8&utm_campaign=designshare&utm_medium=link2&utm_source=sharebutton
- Flowchart
- Database
    - STUDENT_IN_CLASS_TABLE
        
        
        | ID | CLASS_ID | STUDENT_ID | SCORE | IS_DELETED |
        | --- | --- | --- | --- | --- |
    - CLASS_TABLE
        
        
        | CLASS_ID | CLASS_NAME | TEACHER_ID | IS_DELETED |
        | --- | --- | --- | --- |
    - QUIZ_TABLE
        
        
        | QUIZ_ID | CLASS_ID | QUIZ_NAME | START_TIME | END_TIME | LENGTH | WEIGHT | IS_DELETED |
        | --- | --- | --- | --- | --- | --- | --- | --- |
    - QUIZ_QUESTION_TABLE
        
        
        | QUESTION_ID | QUIZ_ID | QUESTION | ANSWER_1 | ANSWER_2 | ANSWER_3 | ANSWER_4 | CORRECT_ANSWER | IS_DELETED |
        | --- | --- | --- | --- | --- | --- | --- | --- | --- |
    - USER_TABLE
        
        
        | ID | USERNAME | EMAIL | NAME | PASSWORD | IS_DELETED | ROLE |
        | --- | --- | --- | --- | --- | --- | --- |
    - PERMISSIONS_TABLE
        
        
        | ROLE |  |  |  |
        | --- | --- | --- | --- |
    - SCORE_TABLE
        
        
        | SCORE_ID | QUIZ_ID | STUDENT_ID | TRY | SCORE | IS_DELETED |
        | --- | --- | --- | --- | --- | --- |
