import 'dart:ffi';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:te_lead/pages/fill_profile.dart';
import 'package:te_lead/pages/signin-signup/sign_in_page.dart';
import 'package:te_lead/pages/utils/form_validtors.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool hidden = true;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isSubmitting = false;

  void togglePasswordState() {
    setState(() {
      hidden = !hidden;
    });
  }

  _submitForm() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isSubmitting = true;
      });
      final user = {
        "email": _emailController.text,
        "password": _passwordController.text
      };

      // calling apis
      print(user);
      Future.delayed(
        const Duration(seconds: 3),
        () {
          setState(() {
            _isSubmitting = false;
          });
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Theme.of(context).colorScheme.primary,
              content: const Text('Registration successfully'),
            ),
          );
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const FillProfile(),
            ),
          );
        },
      );
    }
  }

  @override
  void initState() {
    super.initState();
    hidden = !hidden;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 50,
            ),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(child: Image.asset("assets/images/smallLogo.png")),
                  Text(
                    "Getting Started.!",
                    textAlign: TextAlign.start,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    "Create an Account to Continue your allCourses",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      hintText: "Email",
                      hintStyle: Theme.of(context).textTheme.titleSmall,
                      prefixIcon: const Icon(
                        Icons.email_outlined,
                      ),
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    validator: emailValidator,
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  TextFormField(
                    validator: passwordValidator,
                    controller: _passwordController,
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
                  Row(
                    children: [
                      Image.asset("assets/images/agree2.png"),
                      Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: Text(
                          "Agree to Terms & Conditions",
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  _isSubmitting
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : TextButton(
                          onPressed: _isSubmitting ? null : _submitForm,
                          style: TextButton.styleFrom(
                            backgroundColor:
                                Theme.of(context).colorScheme.primary,
                            textStyle: Theme.of(context).textTheme.titleMedium,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  "Sign Up",
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleLarge!
                                      .copyWith(
                                        fontSize: 20,
                                        color: Colors.white,
                                      ),
                                ),
                              ),
                              Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 5),
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  Icons.arrow_right_alt,
                                  color: Theme.of(context).colorScheme.primary,
                                  size: 45,
                                ),
                              )
                            ],
                          ),
                        ),
                  const SizedBox(
                    height: 25,
                  ),
                  Center(
                    child: Text(
                      " Or Continue With ",
                      style: Theme.of(context).textTheme.bodyMedium,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset("assets/images/google2.svg"),
                      const SizedBox(
                        width: 20,
                      ),
                      SvgPicture.asset("assets/images/apple2.svg"),
                    ],
                  ),
                  Center(
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "Already have an Account? ",
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                  color: Theme.of(context).colorScheme.tertiary,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          TextSpan(
                            text: "SIGN IN",
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                  color: Theme.of(context).colorScheme.primary,
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.underline,
                                  decorationColor:
                                      Theme.of(context).colorScheme.primary,
                                  decorationThickness: 4,
                                ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const SignInPage(),
                                  ),
                                );
                              },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
