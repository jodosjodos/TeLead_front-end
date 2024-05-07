import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:te_lead/pages/reset_password/reset_password.dart';
import 'package:te_lead/widgets/Submit_button.page.dart';

class OTPVerificationPage extends StatefulWidget {
  const OTPVerificationPage({super.key, required this.value});
  final String value;

  @override
  State<OTPVerificationPage> createState() => _OTPVerificationPageState();
}

class _OTPVerificationPageState extends State<OTPVerificationPage> {
  Timer? _timer;
  int _remainingTime = 60;
  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        if (_remainingTime > 0) {
          setState(() {
            _remainingTime--;
          });
        } else {
          timer.cancel();
          setState(() {}); // Ensure UI updates when timer hits 0
        }
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    _timer?.cancel();
  }

  void handleVerification() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const ResetPassword(),
      ),
    );
  }

  InputDecoration buildInputDecoration(BuildContext context) {
    return InputDecoration(
      contentPadding: const EdgeInsets.symmetric(vertical: 26),
      hintStyle: TextStyle(
        color: Theme.of(context).colorScheme.tertiary,
        fontSize: 12,
        fontWeight: FontWeight.w100,
      ),
      floatingLabelBehavior: FloatingLabelBehavior.never,
      filled: true,
      fillColor: Colors.white,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(
          color: Theme.of(context).colorScheme.primary,
          width: 1,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        title: Text(
          "Forgot Password",
          style: TextStyle(
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: SafeArea(
            child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 100,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("Code has been Send to ${widget.value}"),
              const SizedBox(
                height: 50,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                    height: 68,
                    width: 64,
                    child: TextField(
                      // move cursor to next text field

                      onChanged: (value) {
                        if (value.length == 1) {
                          FocusScope.of(context).nextFocus();
                        }
                      },
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.secondary,
                        fontSize: 20,
                      ),
                      textAlign: TextAlign.center,
                      decoration: buildInputDecoration(context),
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(1),
                        FilteringTextInputFormatter.digitsOnly
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 68,
                    width: 64,
                    child: TextField(
                      // move cursor to next text field
                      onChanged: (value) {
                        if (value.length == 1) {
                          FocusScope.of(context).nextFocus();
                        }
                      },
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.secondary,
                        fontSize: 20,
                      ),
                      decoration: buildInputDecoration(context),

                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(1),
                        FilteringTextInputFormatter.digitsOnly
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 68,
                    width: 64,
                    child: TextField(
                      // move cursor to next text field

                      onChanged: (value) {
                        if (value.length == 1) {
                          FocusScope.of(context).nextFocus();
                        }
                      },
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.secondary,
                        fontSize: 20,
                      ),
                      decoration: buildInputDecoration(context),
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(1),
                        FilteringTextInputFormatter.digitsOnly
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 68,
                    width: 64,
                    child: TextField(
                      // move cursor to next text field

                      onChanged: (value) {
                        if (value.length == 1) {
                          FocusScope.of(context).nextFocus();
                        }
                      },
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.secondary,
                        fontSize: 20,
                      ),
                      decoration: buildInputDecoration(context),

                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(1),
                        FilteringTextInputFormatter.digitsOnly
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 50,
              ),
              _remainingTime > 0
                  ? RichText(
                      text: TextSpan(
                        style: TextStyle(
                          fontSize: 14,
                          color: Theme.of(context).colorScheme.tertiary,
                          fontWeight: FontWeight.normal,
                        ),
                        children: <TextSpan>[
                          const TextSpan(text: "Resend Code in "),
                          TextSpan(
                            text: "$_remainingTime s",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).colorScheme.secondary,
                                fontSize: 20,
                                shadows: [
                                  Shadow(
                                    offset: const Offset(1, 1),
                                    blurRadius: 3,
                                    color: Colors.black.withOpacity(0.5),
                                  )
                                ]),
                          ),
                        ],
                      ),
                    )
                  : ElevatedButton(
                      onPressed: () {
                        if (_remainingTime == 0) {
                          setState(() {
                            _remainingTime = 60; // Reset the timer
                            _timer?.cancel(); // Cancel existing timer if any
                            startTimer(); // Start the timer anew
                          });
                        }
                      },
                      child: const Text("Resend OTP"),
                    ),
              const SizedBox(
                height: 50,
              ),
              SubmitButton(
                value: "Verify",
                onPress: handleVerification,
              )
            ],
          ),
        )),
      ),
    );
  }
}
