import 'package:intl_phone_field/phone_number.dart';

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

Future<String?> phoneValidator(PhoneNumber? phone) {
  if (phone == null ||
      !phone.isValidNumber() ||
      !phonePattern.hasMatch(phone.number)) {
    return Future.value(" please enter a valid phone number");
  }
  return Future.value(null);
}

String? genderValidator(String? gender) {
  if (gender == null || gender.isEmpty) {
    return 'Please select an option'; // Ensuring an option is selected
  }
  return null;
}
