class Login {
  late final String email;
  late final String jwt;

  Login({
    required this.email,
    required this.jwt,
  });

  Login.fromJson(dynamic json) {
    email = json['email'];
    jwt = json['jwt'];
  }
}