class Login {
  late final String email;
  late final String password;
  late final int userType;

  Login({
      required this.email,
      required this.password,
      required this.userType,
  });

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['email'] = email;
    map['password'] = password;
    map['user_type'] = userType;
    return map;
  }
}


class LoginResponse {
  late final String email;
  late final String jwt;

  LoginResponse({
    required this.email,
    required this.jwt,
  });

  LoginResponse.fromJson(dynamic json) {
    email = json['email'];
    jwt = json['jwt'];
  }
}