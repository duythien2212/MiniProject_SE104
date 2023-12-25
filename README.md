# Đồ án môn học Nhập môn Công Nghệ Phần Mềm
- Tên đề tài: Phần mềm quản lý các bài kiểm tra trực tuyến.
- Thành viên:
  - 22521392 - Nguyễn Trần Duy Thiên
  - 22521333 - Nguyễn Duy Thắng
  - 22521156 - Phan Hoàng Phước
  - 22520969 - Lê Bình Nguyên
- Mã nguồn: https://github.com/duythien2212/MiniProject_SE104/
## 1. Tổng quan:
- Khảo sát hiện trạng:
- Yêu cầu hệ thống:
## 2. Quy trình, kế hoạch, hệ thống
- Quy trình Agile:
  - ![image](https://github.com/duythien2212/MiniProject_SE104/assets/112065049/1ef39b02-88e8-4835-8fe5-f0d3da270cf0)
  - Trong quy trình Agile: quy trình lấy yêu cầu, thiết kế, triển khai và kiểm tra được thực hiện xen kẽ nhau và đầu ra của quá trình phát triển phần mềm được quyết định thông qua quá trình đàm phán trong suốt quá trình phát triển phần mềm.
- Kế hoạch:
  - Tìm các chức năng cơ bản mà phần mềm cần có.
  - Thiết kế giao diện và cơ sở dữ liệu cho phần mềm
  - Phát triển các tính năng cơ bản của phần mềm
  - Kiểm tra và sửa lỗi
  - Tìm thêm các chức năng khác để nâng cấp phần mềm
  - Phát triển phần mềm dựa trên các tính năng đó
  - Kiểm tra và sửa lỗi
- Công cụ:
  - Database: MySQL
  - Backend: Python
  - Frontend: Flutter
  - Code Repositories: Github
## 3. Thiết kế dữ liệu
### 3.1 Sơ đồ quan hệ
![diagram](https://github.com/duythien2212/MiniProject_SE104/assets/112065049/9703aa2a-1ca2-41bf-9637-6c51955ab425)
### 3.2 Cơ sở dữ liệu
#### 3.2.1 Sơ đồ lược đồ CSDL
- STUDENT_IN_CLASS
    
    
    | ID | CLASS_ID | STUDENT_ID | SCORE | IS_DELETED |
    | --- | --- | --- | --- | --- |
- CLASS
    
    
    | CLASS_ID | CLASS_NAME | TEACHER_ID | IS_DELETED |
    | --- | --- | --- | --- |
- QUIZ
    
    
    | QUIZ_ID | CLASS_ID | QUIZ_NAME | START_TIME | END_TIME | LENGTH | WEIGHT | IS_DELETED |
    | --- | --- | --- | --- | --- | --- | --- | --- |
- QUIZ_QUESTION
    
    
    | QUESTION_ID | QUIZ_ID | QUESTION | ANSWER_1 | ANSWER_2 | ANSWER_3 | ANSWER_4 | CORRECT_ANSWER | IS_DELETED |
    | --- | --- | --- | --- | --- | --- | --- | --- | --- |
- USER
    
    
    | ID | USERNAME | EMAIL | NAME | PASSWORD | IS_TEACHER | IS_DELETED |
    | --- | --- | --- | --- | --- | --- | --- |
- PERMISSIONS
    
    
    | ROLE |  |  |  |
    | --- | --- | --- | --- |
- SCORE
    
    
    | SCORE_ID | QUIZ_ID | STUDENT_ID | TRY | NUMBER_OF_CORRECT | IS_DELETED |
    | --- | --- | --- | --- | --- | --- |
- NOTIFICATION
    
    
    | NOTIFY_ID | TITLE | CONTENT | CLASS_ID | DATE | IS_DELETED |
    | --- | --- | --- | --- | --- | --- |

#### 3.2.2 Mô tả chi tiết các kiểu dữ liệu trong sơ đồ lược đồ
STUDENT_IN_CLASS

| Tên thuộc tính | Kiểu  | Ràng buộc | Ý nghĩa/Ghi chú |
| --- | --- | --- | --- |
| ID | varchar | not null | Phân biệt các lớp của học sinh |
| CLASS_ID | varchar | not null | Phân biệt các lớp |
| STUDENT_ID | varchar | not null | Phân biệt các học sinh |
| SCORE | double | 0 ≤ score ≤ 10 | Điểm trung bình của học sinh trong lớp |
| IS_DELETED | tinyint | not null, 0 hoặc 1 | 0: chưa xóa, 1: đã xóa |

CLASS

| Tên thuộc tính | Kiểu | Ràng buộc | Ý nghĩa/Ghi chú |
| --- | --- | --- | --- |
| CLASS_ID | varchar | not null | Phân biệt các lớp |
| CLASS_NAME | varchar | not null | Tên lớp |
| TEACHER_ID | varchar | not null | Mã số của giáo viên dạy lớp đó |
| IS_DELETED | tinyint | not null, 0 hoặc 1 | 0: chưa xóa, 1: đã xóa |

QUIZ

| Tên thuộc tính | Kiểu | Ràng buộc | Ý nghĩa/Ghi chú |
| --- | --- | --- | --- |
| QUIZ_ID | varchar | not null | Phân biệt các bài quiz |
| CLASS_ID | varchar | not null | Phân biệt các lớp |
| QUIZ_NAME | varchar | not null | Tên bài quiz |
| START_TIME | datetime | not null | Thời gian mở bài quiz |
| END_TIME | datetime | not null | Thời gian đóng bài quiz |
| LENGTH | int | not null | Thời gian làm bài quiz (phút) |
| WEIGHT | decimal | not null, WEIGHT ≥ 0 | Trọng số của bài quiz |
| IS_DELETED | tinyint | not null, 0 hoặc 1 | 0: chưa xóa, 1: đã xóa |

QUIZ_QUESTION

| Tên thuộc tính | Kiểu | Ràng buộc | Ý nghĩa/Ghi chú |
| --- | --- | --- | --- |
| QUESTION_ID | varchar | not null | Phân biệt các câu hỏi |
| QUIZ_ID | varchar | not null | Phân biệt các bài quiz |
| QUESTION | varchar | not null | Câu hỏi |
| ANSWER_1 | varchar | not null | Câu trả lời |
| ANSWER_2 | varchar |  | Câu trả lời |
| ANSWER_3 | varchar |  | Câu trả lời |
| ANSWER_4 | varchar |  | Câu trả lời |
| CORRECT_ANSWER | int | not null, 0≤CORRECT_ANSWER≤3 | Chỉ số của đáp án đúng |
| IS_DELETED | tinyint | not null, 0 hoặc 1 | 0: chưa xóa, 1: đã xóa |

USER

| Tên thuộc tính | Kiểu | Ràng buộc | Ý nghĩa/Ghi chú |
| --- | --- | --- | --- |
| ID | varchar | not null | Phân biệt các user |
| USER_NAME | varchar | not null | Tên đăng nhập của user |
| EMAIL | varchar | not null | Email của user |
| NAME | varchar | not null | Tên của user |
| PASSWORD | varchar | not null | Mật khẩu của user |
| IS_TEACHER | tinyint | not null, 0 hoặc 1 | 0: học sinh, 1: giáo viên |
| IS_DELETED | tinyint | not null, 0 hoặc 1 | 0: chưa xóa, 1: đã xóa |

SCORE

| Tên thuộc tính | Kiểu | Ràng buộc | Ý nghĩa/Ghi chú |
| --- | --- | --- | --- |
| SCORE_ID | varchar | not null | Phân biệt các điểm của bài quiz |
| QUIZ_ID | varchar | not null | Phân biệt các bài quiz |
| STUDENT_ID | varchar | not null | Phân biệt các học sinh |
| TRY | int | not null | Số lần thử |
| NUMBER_OF_CORRECT | int | not null | Số câu trả lời đúng |
| IS_DELETED | tinyint | not null, 0 hoặc 1 | 0: chưa xóa, 1: đã xóa |

NOTIFICATION

| Tên thuộc tính | Kiểu | Ràng buộc | Ý nghĩa/Ghi chú |
| --- | --- | --- | --- |
| NOTIFY_ID | varchar | not null | Phân biệt các thông báo |
| TITLE | varchar | not null | Tiêu đề của thông báo |
| CONTENT | varchar | not null | Nội dung của thông báo |
| CLASS_ID | varchar | not null | Lớp được thông báo |
| DATE | datetime | not null | Thời gian gửi thông báo |
| IS_DELETED | tinyint | not null, 0 hoặc 1 | 0: chưa xóa, 1: đã xóa |

## 4. Thiết kế giao diện
## 5. Thiết kế kiến trúc
## 6. Kết quả
