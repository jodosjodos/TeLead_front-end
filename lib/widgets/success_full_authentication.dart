import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SuccessAuthentication extends StatelessWidget {
  const SuccessAuthentication({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20)), // Optional: rounded corners
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0), // Padding inside the dialog
          child: Column(
            mainAxisSize: MainAxisSize.min, // Makes the column fit its content
            children: [
              Image.asset("assets/images/successAvatar.png",
                  width: 120), // Set an appropriate size for the image
              SizedBox(height: 20), // Spacing between the image and the text
              Text("Congratulations",
                  style: Theme.of(context).textTheme.headline6),
              SizedBox(
                  height:
                      10), // Spacing between "Congratulations" and the description
              Text(
                "Your Account is Ready to Use. You will be redirected to the Home Page in a Few Seconds.",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyText2,
              ),
              SizedBox(height: 20), // Spacing above the progress indicator
              CircularProgressIndicator(),
              SizedBox(height: 20), // Spacing at the bottom of the dialog
            ],
          ),
        ),
      ),
    );
  }
}
