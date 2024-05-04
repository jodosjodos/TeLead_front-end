const String emailPattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
final RegExp emailRegex = RegExp(emailPattern);
const String pattern =
    r'^\+?([0-9]{1,3})?[-. ]?([0-9]{1,3})?[-. ]?([0-9]{1,4})?[-. ]?([0-9]{1,4})?[-. ]?([0-9]{1,6})$';
final RegExp phonePattern = RegExp(pattern);
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

String? fullNameNickNameValidator(String? name) {
  if (name!.trim().isEmpty) {
    return "Please enter a valid name";
  }
  return null;
}

String? dateValidator(DateTime? date) {
  if (date == null) {
    return "date is  required";
  }
  return null;
}

String? phoneValidator(String? phone) {
  if (phone!.isEmpty || !phonePattern.hasMatch(phone)) {
    return " please enter a valid phone number";
  }
  return null;
}
