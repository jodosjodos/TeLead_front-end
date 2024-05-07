import 'package:flutter/material.dart';
import 'package:te_lead/pages/utils/form_validtors.dart';
import 'package:te_lead/widgets/Submit_button.page.dart';

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

void handleSubmit (){
  if(_formKey.currentState!.validate()){
    
  }
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
              SubmitButton(
                value: "Continue",
                onPress: () {},
              )
            ],
          ),
        ),
      ),
    );
  }
}
