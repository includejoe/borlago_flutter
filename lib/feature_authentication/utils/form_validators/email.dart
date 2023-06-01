class EmailValidator {
  String? call(String email) {
    bool isValid = RegExp(r'^[\w-.]+@([\w-]+\.)+[\w-]{2,}$',).hasMatch(email);
    if(email.isEmpty) {
      return "Email cannot be empty";
    } else if(!isValid) {
      return "Enter a valid email address";
    }
    return null;
  }
}