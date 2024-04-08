class AccountModel {
  final String accountBankID;
  final String accountHolderID;
  final String accountNumber;
  final String accountHolderName;
  final double balance;
  final String accountType;
  final String isActive;
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
      accountBankID: json['accountbankid'],
      accountHolderID: json['accountholderid'],
      accountNumber: json['accountnumber'],
      accountHolderName: json['accountholdername'],
      balance: json['balance'],
      accountType: json['accounttype'],
      isActive: json['isactive'] == "true" ? "ACTIVATED" : "DEACTIVATED",
      overdraftLimit: json['overdraftlimit'],
      maxTransLimit: json['maxtranslimit'],
      interestRate: json['interestrate'],
      minimumBalance: json['minimumbalance'],
      withdrawLimit: json['withdrawlimit'],
      createdAt: DateTime.parse(json["createdat"]),
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'accountbankid': accountBankID,
      'accountholderid': accountHolderID,
      'accountnumber': accountNumber,
      'accountholdername': accountHolderName,
      'balance': balance,
      'accounttype': accountType,
      'isactive': isActive,
      'overdraftlimit': overdraftLimit,
      'maxtranslimit': maxTransLimit,
      'interestrate': interestRate,
      'minimumbalance': minimumBalance,
      'withdrawlimit': withdrawLimit,
    };
  }
}
