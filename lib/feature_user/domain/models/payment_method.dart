class PaymentMethod {
  late final String id;
  late final String type;
  late final String name;
  late final String accountNumber;
  late final String? expiryDate;
  late final String? nameOnCard;
  late final String? securityCode;
  late final String? zipCode;

  PaymentMethod({
    required this.id,
    required this.type,
    required this.name,
    required this.accountNumber,
    this.expiryDate,
    this.nameOnCard,
    this.securityCode,
    this.zipCode,
  });

  PaymentMethod.fromJson(dynamic json) {
    id = json['id'];
    type = json['type'];
    name = json['name'];
    accountNumber = json['account_number'];
    expiryDate = json['expiry_date'];
    nameOnCard = json['name_on_card'];
    securityCode = json['security_code'];
    zipCode = json['zip_code'];
  }


  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['type'] = type;
    map['name'] = name;
    map['account_number'] = accountNumber;
    map['expiry_date'] = expiryDate;
    map['name_on_card'] = nameOnCard;
    map['security_code'] = securityCode;
    map['zip_code'] = zipCode;
    return map;
  }

}