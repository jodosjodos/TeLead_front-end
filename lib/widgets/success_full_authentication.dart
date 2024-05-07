import 'package:flutter/material.dart';

class SuccessAuthentication extends StatelessWidget {
  const SuccessAuthentication({super.key, required this.avatar});
  final String avatar;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                avatar,
              ),
              const SizedBox(height: 20),
              Text("Congratulations",
                  style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 10),
              Text(
                "Your Account is Ready to Use. You will be redirected to the Home Page in a Few Seconds.",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 20),
              const CircularProgressIndicator(),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
