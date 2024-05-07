import 'package:flutter/material.dart';

class ResetPasswordLanding extends StatelessWidget {
  const ResetPasswordLanding({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Forgot Password"),
      ),
      body: const SafeArea(
          child: Center(
        child: Text("select reset password option"),
      )),
    );
  }
}
