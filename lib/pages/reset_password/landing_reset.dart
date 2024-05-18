import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:te_lead/pages/reset_password/otp_verification_page.dart';
import 'package:te_lead/widgets/Submit_button.page.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ResetPasswordLanding extends StatefulWidget {
  const ResetPasswordLanding({super.key});

  @override
  State<ResetPasswordLanding> createState() => _ResetLanding();
}

class _ResetLanding extends State<ResetPasswordLanding> {
  int? selectedIndex;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  bool _isSubmitting = false;

  String? rootUrl;
  String? url;
  final dio = Dio();

  @override
  void initState() {
    super.initState();
    loadEnvVariables();
  }

// Load env variables
  Future<void> loadEnvVariables() async {
    await dotenv.load();
    setState(() {
      rootUrl = dotenv.env["API_URL"];
      url = "$rootUrl/user/resetRequest";
    });
  }

  // form sumption
  Future<void> formSubmitting() async {
    setState(() {
      _isSubmitting = true;
    });
    try {
      if (selectedIndex == 1) {
        final String validUrl = "$url/${_emailController.text}";
        var response = await dio.get(validUrl);
        if (response.statusCode == 200) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Theme.of(context).colorScheme.primary,
              content: const Text('OTP have been sent to your email address'),
            ),
          );
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => OTPVerificationPage(
                value: _emailController.text,
              ),
            ),
          );
        }
      } else if (selectedIndex == 2) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => OTPVerificationPage(
              value: _phoneController.text,
            ),
          ),
        );
      }
    } on DioException catch (e) {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              textAlign: TextAlign.center,
              "Select which contact details should we use to  \nReset Your Password",
              style: TextStyle(
                color: Theme.of(context).colorScheme.tertiary,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: TextFormField(
                controller: _emailController,
                onTap: () {
                  setState(() {
                    selectedIndex = 1;
                  });
                },
                keyboardType: TextInputType.emailAddress,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.secondary,
                  fontWeight: FontWeight.bold,
                ),
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 26,
                  ),
                  hintText: "Via Email",
                  hintStyle: TextStyle(
                    color: Theme.of(context).colorScheme.tertiary,
                    fontSize: 12,
                    fontWeight: FontWeight.w100,
                  ),
                  prefixIcon: Padding(
                    padding: const EdgeInsets.all(12),
                    child: SvgPicture.asset(
                      "assets/images/message.svg",
                      width: 40,
                      height: 40,
                    ),
                  ),
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  filled: true,
                  fillColor: Colors.white,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none, // No border when not focused
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
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: TextFormField(
                onTap: () {
                  setState(() {
                    selectedIndex = 2;
                  });
                },
                style: TextStyle(
                  color: Theme.of(context).colorScheme.secondary,
                  fontWeight: FontWeight.bold,
                ),
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 26,
                  ),
                  hintText: "Via SMS",
                  hintStyle: TextStyle(
                    color: Theme.of(context).colorScheme.tertiary,
                    fontSize: 12,
                    fontWeight: FontWeight.w100,
                  ),
                  prefixIcon: Padding(
                    padding: const EdgeInsets.all(12),
                    child: SvgPicture.asset(
                      "assets/images/message.svg",
                      width: 40,
                      height: 40,
                    ),
                  ),
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  filled: true,
                  fillColor: Colors.white,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none, // No border when not focused
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
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            _isSubmitting
                ? const Center(child: CircularProgressIndicator())
                : SubmitButton(value: "Continue", onPress: formSubmitting)
          ],
        ),
      ),
    );
  }
}
