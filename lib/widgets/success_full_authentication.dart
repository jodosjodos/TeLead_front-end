import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SuccessAuthentication extends StatelessWidget {
  const SuccessAuthentication({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        children: [
          Image.asset("assets/images/successAvatar.png"),
          Text("Congratulations"),
          Text(
              "Your Account is Ready to Use. You will be \n redirected to the Home Page in a  \nFew Seconds."),
          CircularProgressIndicator()
        ],
      ),
    );
  }
}
