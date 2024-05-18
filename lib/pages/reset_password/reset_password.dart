import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:te_lead/pages/home/home_page.dart';
import 'package:te_lead/pages/signin-signup/sign_in_page.dart';
import 'package:te_lead/providers/user_provider.dart';
import 'package:te_lead/utils/form_validtors.dart';
import 'package:te_lead/widgets/Submit_button.page.dart';
import 'package:te_lead/widgets/success_full_authentication.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:dio/dio.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  bool hidden = true;
  bool _isSubmitting = false;
  late String rootUrl;
  late String url;

  @override
  void initState() {
    super.initState();
    hidden != hidden;
    loadEnvVariables();
  }

  void togglePasswordState() {
    setState(() {
      hidden = !hidden;
    });
  }

// load .env

  Future<void> loadEnvVariables() async {
    await dotenv.load();
    setState(() {
      rootUrl = dotenv.env["API_URL"]!;
      url = "$rootUrl/user/reset/newPasswords";
      //  load provider user
    });
  }

  Future<void> handleSubmit(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      setState(
        () {
          _isSubmitting = true;
        },
      );
      if (_passwordController.text != _confirmPasswordController.text) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text(
              " password and confirm password doesn't match",
            ),
            backgroundColor: Theme.of(context).colorScheme.primary,
          ),
        );
      }
      final Map<String, dynamic> userDetails =
          Provider.of<UserProvider>(context, listen: false).userData;
      final String token = userDetails["token"];
      final Dio dio = Dio(
        BaseOptions(
          headers: {HttpHeaders.authorizationHeader: "Bearer $token"},
        ),
      );
      try {
        var response = await dio.patch(
          url,
          data: {
            "password": _passwordController.text,
            "confirmPassword": _passwordController.text
          },
        );
        print(response.data);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Theme.of(context).colorScheme.primary,
            content: const Text('reset password is successfull'),
          ),
        );
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const SignInPage(),
          ),
        );
      } on DioException catch (e) {
        final error = e.response?.data;
        final String message = error["response"]["message"].toString();
        final String statusCode = error["statusCode"].toString();
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text("Fail to reset password"),
              content: Text(
                "$message : $statusCode",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.error,
                ),
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );
        _isSubmitting = false;
      } finally {
        setState(() {
          _isSubmitting = false;
        });
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    _confirmPasswordController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Create New  Password",
          style: TextStyle(
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.background,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 50,
        ),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Create Your New  Password",
                textAlign: TextAlign.start,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(
                height: 40,
              ),
              TextFormField(
                controller: _passwordController,
                validator: passwordValidator,
                obscureText: hidden,
                decoration: InputDecoration(
                  hintText: "Password",
                  hintStyle: Theme.of(context).textTheme.titleSmall,
                  prefixIcon: const Icon(
                    Icons.lock_outline,
                  ),
                  suffixIcon: IconButton(
                    onPressed: togglePasswordState,
                    icon: hidden
                        ? const Icon(Icons.visibility_off_outlined)
                        : const Icon(Icons.visibility_outlined),
                  ),
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: _confirmPasswordController,
                validator: passwordValidator,
                obscureText: hidden,
                decoration: InputDecoration(
                  hintText: "confirm password",
                  hintStyle: Theme.of(context).textTheme.titleSmall,
                  prefixIcon: const Icon(
                    Icons.lock_outline,
                  ),
                  suffixIcon: IconButton(
                    onPressed: togglePasswordState,
                    icon: hidden
                        ? const Icon(Icons.visibility_off_outlined)
                        : const Icon(Icons.visibility_outlined),
                  ),
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              _isSubmitting
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : SubmitButton(
                      value: "Continue",
                      onPress: () => handleSubmit(context),
                    )
            ],
          ),
        ),
      ),
    );
  }
}
