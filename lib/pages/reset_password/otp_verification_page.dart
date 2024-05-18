import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:te_lead/pages/reset_password/reset_password.dart';
import 'package:te_lead/providers/user_provider.dart';
import 'package:te_lead/widgets/Submit_button.page.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class OTPVerificationPage extends StatefulWidget {
  const OTPVerificationPage({super.key, required this.value});
  final String value;

  @override
  State<OTPVerificationPage> createState() => _OTPVerificationPageState();
}

class _OTPVerificationPageState extends State<OTPVerificationPage> {
  final TextEditingController _value1 = TextEditingController();
  final TextEditingController _value2 = TextEditingController();
  final TextEditingController _value3 = TextEditingController();
  final TextEditingController _value4 = TextEditingController();

  Timer? _timer;
  int _remainingTime = 60;
  String? rootUrl;
  String? url;
  final dio = Dio();
  bool _isSubmitting = false;

  @override
  void initState() {
    super.initState();
    startTimer();
    loadEnvVariables();
  }

// Load env variables
  Future<void> loadEnvVariables() async {
    await dotenv.load();
    setState(() {
      rootUrl = dotenv.env["API_URL"];
    });
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
          setState(() {});
        }
      },
    );
  }

// resend OTP
  Future<void> resendOTP() async {
    setState(() {
      _isSubmitting = true; // Show circular spinner when resend OTP is clicked
    });
    print("reaching out");
    try {
      url = "$rootUrl/user/resetRequest";
      final String validUrl = "$url/${widget.value}";
      var response = await dio.get(validUrl);
      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Theme.of(context).colorScheme.primary,
            content: const Text('OTP has been resent to your email address'),
          ),
        );
      }
    } on DioException catch (e) {
      final error = e.response?.data;
      final String message = error?["response"]?["message"]?.toString() ?? "";
      final String statusCode = error?["statusCode"]?.toString() ?? "";
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Failed to resend OTP"),
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
    } finally {
      // After response is received, start the timer
      if (!_isSubmitting) {
        startTimer();
      }
      setState(() {
        _isSubmitting = false; // Hide circular spinner
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    _timer?.cancel();
  }

//combine OTP
  String combineOTP() {
    String otp = _value1.text + _value2.text + _value3.text + _value4.text;
    return otp;
  }

  void handleVerification() async {
    setState(() {
      _isSubmitting = true;
    });
    try {
      final otp = combineOTP();
      final url1 = "$rootUrl/user/reset/verify/otp";
      final String validUrl = "$url1/${widget.value}/$otp";
      var response = await dio.get(validUrl);
      if (response.statusCode == 200) {
        Provider.of<UserProvider>(context, listen: false).updateUser({
          "token": response.data["token"],
          "userId": response.data["userId"],
        });
        final msg = response.data["msg"];
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Theme.of(context).colorScheme.primary,
            content: Text(msg),
          ),
        );
      }

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const ResetPassword(),
        ),
      );
    } on DioException catch (e) {
      print(e);
      final error = e.response?.data;
      final String message = error["response"]["message"].toString();
      final String statusCode = error["statusCode"].toString();
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Fail to sign in"),
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
    } finally {
      setState(() {
        _isSubmitting = false;
      });
    }
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
                      controller: _value1,
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
                      controller: _value2,
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
                      controller: _value3,
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
                      controller: _value4,
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
                  : _isSubmitting
                      ? const Center(child: CircularProgressIndicator())
                      : ElevatedButton(
                          onPressed: _isSubmitting ? null : resendOTP,
                          child: _isSubmitting
                              ? const CircularProgressIndicator() // Show spinner when submitting
                              : const Text("Resend OTP"),
                        ),
              const SizedBox(
                height: 50,
              ),
              if (!_isSubmitting)
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
