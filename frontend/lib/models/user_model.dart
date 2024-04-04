class UserModel {
  final String userID;
  final String userName;
  final String userEmail;
  final String userPassword;
  final String userRole;

  UserModel({required this.userID, required this.userName, required this.userEmail, required this.userPassword, required this.userRole});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(userID: json['uid'], userName: json['username'], userEmail: json['email'], userPassword: json['password'], userRole: json['role']);
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{'uid': userID, 'username': userName, 'email': userEmail, 'password': userPassword, 'role': userRole};
  }
}
