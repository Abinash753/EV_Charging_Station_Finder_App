class UserModel {
  final String? uid;
  final String userName;
  final String userEmail;
  final String userContact;
  final String password;

  UserModel({
    this.uid,
    required this.userName,
    required this.userEmail,
    required this.userContact,
    required this.password,
  });

  toJson() {
    return {
      "username": userName,
      "userEmail": userEmail,
      "Password": password,
      "userContact": userContact,
    };
  }
}
