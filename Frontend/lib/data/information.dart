import 'dart:convert';
import 'package:http/http.dart' as http;

const url = 'http://127.0.0.1:4000';

class Information {
  Information(this.firstName, this.lastName, this.email, this.avatarURL,
      this.userName, this.userID, this.userClasses, this.isTeacher);
  String firstName;
  String lastName;
  String email;
  String avatarURL;
  String userName;
  String userID;
  List<String> userClasses;
  bool isTeacher;
}

Information userinfor = Information("Nguyên", 'Lê Bình', 'nguyenle@gmail.com',
    '', '27520010', 'U1', ['IT001'], true);

class loginInformation {
  loginInformation(this.username, this.password);
  final username;
  final password;
}

Future<void> getInformation(username) async {
  final response = await http
      .post(Uri.parse(url + '/api/getInfor'),
          body: json.encode({
            'username': username,
          }))
      .then((value) => value);
  var userInfor = jsonDecode(response.body);
  userinfor = Information(
    userInfor['firstName'],
    userInfor['lastName'],
    userInfor['email'],
    userInfor['avatarURL'],
    userInfor['userName'],
    userInfor['userID'],
    userInfor['userClasses'],
    userInfor['isTeacher'],
  );
}

loginInformation loginInput = loginInformation("", "");
