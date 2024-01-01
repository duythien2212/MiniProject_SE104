final url = 'http://127.0.0.1:4000';

class Information {
  Information(this.firstName, this.lastName, this.email, this.avatarURL, this.userName, this.userID, this.userRole, this.isTeacher);
  final String firstName;
  final String lastName;
  final String email;
  final String avatarURL;
  final String userName;
  final String userID;
  final String userRole;
  final bool isTeacher;
}

Information userinfor = Information("Nguyên", 'Lê Bình', 'nguyenle@gmail.com', '', '22520969', 'U1', 'Teacher', true);

class loginInformation {
  loginInformation(this.username, this.password);
  final username;
  final password;
}

loginInformation loginInput = loginInformation("", "");
