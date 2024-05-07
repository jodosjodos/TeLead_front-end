import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class OTPVerificationPage extends StatelessWidget {
  const OTPVerificationPage({super.key, required this.value});
  final String value;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
      ),
      body: SafeArea(
          child: Column(
        children: [
          Text("Code has been Send to $value"),
          Row(
            children: [
              SizedBox(
                height: 68,
                width: 64,
                child: TextField(
                  decoration: ,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(1),
                    FilteringTextInputFormatter.digitsOnly
                  ],
                ),
              )
            ],
          )
        ],
      )),
    );
  }
}
