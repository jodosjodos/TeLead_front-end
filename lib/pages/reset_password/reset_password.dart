import 'package:flutter/material.dart';
import 'package:te_lead/pages/home/home_page.dart';
import 'package:te_lead/pages/utils/form_validtors.dart';
import 'package:te_lead/widgets/Submit_button.page.dart';
import 'package:te_lead/widgets/success_full_authentication.dart';

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

  void togglePasswordState() {
    setState(() {
      hidden = !hidden;
    });
  }

  @override
  void initState() {
    super.initState();
    hidden != hidden;
  }

  void handleSubmit(BuildContext context) {
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
      Future.delayed(const Duration(seconds: 3), () {
        showDialog(
          barrierDismissible: false,
          context: context,
          builder: (BuildContext context) {
            return const SuccessAuthentication(
              avatar: "assets/images/successAvatar.png",
            );
          },
        );

        // Wait for 3 seconds while showing the dialog
        Future.delayed(const Duration(seconds: 3), () {
          Navigator.of(context).pop(); // Dismiss the dialog

          // Navigate to the HomePage
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => const HomePage(),
            ),
          );
        });
      }).whenComplete(() {
        setState(() {
          _isSubmitting = false;
        });
      });
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
