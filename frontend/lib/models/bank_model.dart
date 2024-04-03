class BankModel {
  String bankID;
  String bankName;
  String bankAddress;

  BankModel({required this.bankID, required this.bankName, required this.bankAddress});

  factory BankModel.fromJson(Map<String, dynamic> json) => BankModel(bankID: json['bankID'], bankName: json['bankName'], bankAddress: json['bankAddress']);

  Map<String, dynamic> toJson() => <String, dynamic>{'bankID': bankID, 'bankName': bankName, 'bankAddress': bankAddress};
}
