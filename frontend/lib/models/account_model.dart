class AccountModel {
  final String accountBankID;
  final String accountHolderID;
  final String accountNumber;
  final String accountHolderName;
  final double balance;
  final String accountType;
  final bool isActive;
  final double? overdraftLimit;
  final double? maxTransLimit;
  final double? interestRate;
  final double? minimumBalance;
  final double? withdrawLimit;
  final DateTime createdAt;

  AccountModel({
    required this.accountBankID,
    required this.accountHolderID,
    required this.accountNumber,
    required this.accountHolderName,
    required this.balance,
    required this.accountType,
    required this.isActive,
    required this.overdraftLimit,
    required this.maxTransLimit,
    required this.interestRate,
    required this.minimumBalance,
    required this.withdrawLimit,
    required this.createdAt,
  });

  factory AccountModel.fromJson(Map<String, dynamic> json) {
    return AccountModel(
      accountBankID: json['accountBankID'],
      accountHolderID: json['accountHolderID'],
      accountNumber: json['accountNumber'],
      accountHolderName: json['accountHolderName'],
      balance: json['balance'],
      accountType: json['accountType'],
      isActive: json['isActive'],
      overdraftLimit: json['overdraftLimit'],
      maxTransLimit: json['maxTransLimit'],
      interestRate: json['interestRate'],
      minimumBalance: json['minimumBalance'],
      withdrawLimit: json['withdrawLimit'],
      createdAt: DateTime.parse(json["createdAt"]),
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'accountBankID': accountBankID,
      'accountHolderID': accountHolderID,
      'accountNumber': accountNumber,
      'accountHolderName': accountHolderName,
      'balance': balance,
      'accountType': accountType,
      'isActive': isActive,
      'overdraftLimit': overdraftLimit,
      'maxTransLimit': maxTransLimit,
      'interestRate': interestRate,
      'minimumBalance': minimumBalance,
      'withdrawLimit': withdrawLimit,
    };
  }
}
