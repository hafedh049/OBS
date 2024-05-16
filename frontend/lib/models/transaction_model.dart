class TransactionModel {
  final String transactionID;
  final String senderID;
  final String receiverID;
  final double amount;
  final DateTime timestamp;
  final String description;
  final String transactionState;

  TransactionModel({
    required this.transactionID,
    required this.senderID,
    required this.receiverID,
    required this.amount,
    required this.timestamp,
    required this.description,
    required this.transactionState,
  });

  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    return TransactionModel(
      transactionID: json['transactionid'],
      senderID: json['senderid'],
      receiverID: json['receiverid'],
      amount: json['amount'],
      timestamp: DateTime.parse(json['timestamp']),
      description: json['description'],
      transactionState: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'transactionid': transactionID,
      'senderid': senderID,
      'receiverid': receiverID,
      'amount': amount,
      'timestamp': timestamp.toIso8601String(),
      'description': description,
      'status': transactionState,
    };
  }
}
