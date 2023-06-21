class Method {
  Method({
    required this.name,
    required this.accountNumber,
  });

  late final String name;
  late final String accountNumber;

  Method.fromJson(dynamic json) {
    name = json['name'];
    accountNumber = json['account_number'];
  }


  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['account_number'] = accountNumber;
    return map;
  }

}

class Payment {
  Payment({
    required this.id,
    required this.wcr,
    required this.method,
    required this.amount,
    required this.transactionId,
    required this.status,
    required this.createdAt
  });

  late final String id;
  late final String wcr;
  late final Method method;
  late final String amount;
  late final String transactionId;
  late final int status;
  late final String createdAt;

  Payment.fromJson(dynamic json) {
    id = json['id'];
    wcr = json['wcr'];
    method = (json['method'] != null ? Method.fromJson(json['method']) : null)!;
    amount = json['amount'];
    transactionId = json['transaction_id'];
    status = json['status'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['wcr'] = wcr;
    map['method'] = method.toJson();
    map['amount'] = amount;
    map['transaction_id'] = transactionId;
    map['status'] = status;
    map['created_at'] = createdAt;
    return map;
  }
}