class Register {
  late final String email;
  late final String firstName;
  late final String lastName;
  late final String? password;
  late final String country;
  late final String gender;
  late final String phone;
  late final int userType;

  Register({
      required this.email,
      required this.firstName,
      required this.lastName,
      this.password,
      required this.country,
      required this.gender,
      required this.phone,
      required this.userType,
  });

  Register.fromJson(dynamic json) {
    email = json['email'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    password = json['password'];
    country = json['country'];
    gender = json['gender'];
    phone = json['phone'];
    userType = json['user_type'];
  }


  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['email'] = email;
    map['first_name'] = firstName;
    map['last_name'] = lastName;
    map['password'] = password;
    map['country'] = country;
    map['gender'] = gender;
    map['phone'] = phone;
    map['user_type'] = userType;
    return map;
  }

}