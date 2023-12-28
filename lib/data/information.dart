class Information {
  Information(this.firstName, this.lastName, this.email, this.avatarURL,
      this.userName, this.userClass, this.isTeacher);
  final String firstName;
  final String lastName;
  final String email;
  final String avatarURL;
  final String userName;
  final String userClass;
  final bool isTeacher;
}

Information userinfor = Information("Nguyên", 'Lê Bình', 'nguyenle@gmail.com',
    '', '22520969', 'KHTN2022', true);
