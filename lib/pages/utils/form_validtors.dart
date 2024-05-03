const String emailPattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
final RegExp emailRegex = RegExp(emailPattern);

String? emailValidator(String? email) {
  if (email!.trim().isEmpty || !emailRegex.hasMatch(email)) {
    return "Please enter a valid email address";
  }
  return null;
}

String? passwordValidator(String? password) {
  if (password!.trim().isEmpty || password.length < 5) {
    return "Please enter a  strong password";
  }
  return null;
}
