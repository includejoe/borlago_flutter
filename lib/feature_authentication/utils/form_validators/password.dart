class PasswordValidator {
  String? call(String password) {
    if(password.isEmpty) {
      return "Password cannot be empty";
    } else if(password.length < 6) {
      return "Password must be 6 or more characters";
    }
    return null;
  }
}