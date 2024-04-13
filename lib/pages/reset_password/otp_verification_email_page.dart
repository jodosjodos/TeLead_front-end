import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
          _remainingTime--;
        } else {
          _timer?.cancel();
        }
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    _timer?.cancel();
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
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 100,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("Code has been Send to ${widget.value}"),
            const SizedBox(
              height: 30,
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
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 26,
                      ),
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
                        borderSide:
                            BorderSide.none, // No border when not focused
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color: Theme.of(context)
                              .colorScheme
                              .primary, // Border color when the TextField is focused
                          width: 1,
                        ),
                      ),
                    ),
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
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 26,
                      ),
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
                        borderSide:
                            BorderSide.none, // No border when not focused
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color: Theme.of(context)
                              .colorScheme
                              .primary, // Border color when the TextField is focused
                          width: 1,
                        ),
                      ),
                    ),
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
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 26,
                      ),
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
                        borderSide:
                            BorderSide.none, // No border when not focused
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color: Theme.of(context)
                              .colorScheme
                              .primary, // Border color when the TextField is focused
                          width: 1,
                        ),
                      ),
                    ),
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
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 26,
                      ),
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
                        borderSide:
                            BorderSide.none, // No border when not focused
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color: Theme.of(context)
                              .colorScheme
                              .primary, // Border color when the TextField is focused
                          width: 1,
                        ),
                      ),
                    ),
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(1),
                      FilteringTextInputFormatter.digitsOnly
                    ],
                  ),
                ),
              ],
            ),
            _remainingTime > 0
                ? Text("Code has been Send to $_remainingTime")
                : ElevatedButton(
                    onPressed: () {
                      // resend OTP
                    },
                    child: const Text(
                      "resend OTP ",
                    ),
                  ),
          ],
        ),
      )),
    );
  }
}
