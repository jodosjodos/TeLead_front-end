import 'package:flutter/material.dart';
import 'package:te_lead/pages/signin-signup/signin_signup_landing.dart';

void skipSteps(BuildContext context) {
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(
      builder: (context) => const SignInSignUpPage(),
    ),
  );
}
