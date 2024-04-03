class UserModel {
  final String userID;
  final String userName;
  final String userEmail;
  final String userPassword;
  final String userRole;

  UserModel({required this.userID, required this.userName, required this.userEmail, required this.userPassword, required this.userRole});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(userID: json['userID'], userName: json['userName'], userEmail: json['userEmail'], userPassword: json['userPassword'], userRole: json['userRole']);
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{'userID': userID, 'userName': userName, 'userEmail': userEmail, 'userPassword': userPassword, 'userRole': userRole};
  }
}
