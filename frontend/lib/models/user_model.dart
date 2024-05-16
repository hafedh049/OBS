class UserModel {
  final String userID;
  final String userName;
  final String userEmail;
  final String userPassword;
  final String userRole;
  final String? bankID;

  UserModel({required this.userID, required this.bankID, required this.userName, required this.userEmail, required this.userPassword, required this.userRole});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(userID: json['userid'], bankID: json['bankid'], userName: json['username'], userEmail: json['email'], userPassword: json['password'], userRole: json['role']);
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{'userid': userID, 'bankid': bankID, 'username': userName, 'email': userEmail, 'password': userPassword, 'role': userRole};
  }
}
