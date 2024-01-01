final url = 'http://127.0.0.1:4000';

class Information {
  Information(this.firstName, this.lastName, this.email, this.avatarURL,
      this.userName, this.userID, this.userClasses, this.isTeacher);
  final String firstName;
  final String lastName;
  final String email;
  final String avatarURL;
  final String userName;
  final String userID;
  final List<String> userClasses;
  final bool isTeacher;
}

Information userinfor = Information("Nguyên", 'Lê Bình', 'nguyenle@gmail.com',
    '', '22520969', 'U1', ['KHTN2022'], true);

class loginInformation {
  loginInformation(this.username, this.password);
  final username;
  final password;
}

loginInformation loginInput = loginInformation("", "");
