class BankModel {
  String bankID;
  String bankName;
  String bankAddress;

  BankModel({required this.bankID, required this.bankName, required this.bankAddress});

  factory BankModel.fromJson(Map<String, dynamic> json) => BankModel(bankID: json['bankid'], bankName: json['bankname'], bankAddress: json['bankaddress']);

  Map<String, dynamic> toJson() => <String, dynamic>{'bankid': bankID, 'bankname': bankName, 'bankaddress': bankAddress};
}
