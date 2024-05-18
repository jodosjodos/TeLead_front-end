import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:te_lead/pages/home/home_page.dart';
import 'package:te_lead/pages/reset_password/landing_reset.dart';
import 'package:te_lead/pages/signin-signup/sign_up_page.dart';
import 'package:te_lead/providers/user_provider.dart';
import 'package:te_lead/utils/form_validtors.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:te_lead/widgets/continue_type.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  bool hidden = true;
  bool selected = false;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isSubmitting = false;
  final dio = Dio();
  String? rootUrl;
  String? url;

  @override
  void initState() {
    super.initState();
    loadEnvVariables();
  }

  void togglePasswordState() {
    setState(() {
      hidden = !hidden;
    });
  }

  // Load env variables
  Future<void> loadEnvVariables() async {
    await dotenv.load();
    setState(() {
      rootUrl = dotenv.env["API_URL"];
      url = "$rootUrl/user/login";
    });
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isSubmitting = true;
      });

      final Map<String, String> user = {
        "email": _emailController.text,
        "password": _passwordController.text,
      };
      try {
        // Calling API
        var response = await dio.post(
          url!,
          data: user,
        );
        if (response.statusCode == 200) {
          setState(() {
            _isSubmitting = false;
          });
          Provider.of<UserProvider>(context, listen: false).updateUser({
            "token": response.data["token"],
            "userId": response.data["user"]["id"],
          });
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Theme.of(context).colorScheme.primary,
              content: const Text('Login successfully'),
            ),
          );

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const HomePage(),
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
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void landingResetNavigator() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const ResetPasswordLanding(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(child: Image.asset("assets/images/smallLogo.png")),
                  Text(
                    "Let’s Sign In.!",
                    textAlign: TextAlign.start,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 5),
                  Text(
                    "Login to Your Account to Continue your Courses",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 30),
                  TextFormField(
                    controller: _emailController,
                    validator: emailValidator,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      hintText: "Email",
                      hintStyle: Theme.of(context).textTheme.titleSmall,
                      prefixIcon: const Icon(Icons.email_outlined),
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: 25),
                  TextFormField(
                    controller: _passwordController,
                    validator: passwordValidator,
                    obscureText: hidden,
                    decoration: InputDecoration(
                      hintText: "Password",
                      hintStyle: Theme.of(context).textTheme.titleSmall,
                      prefixIcon: const Icon(Icons.lock_outline),
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
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Checkbox(
                            value: selected,
                            onChanged: (value) {
                              setState(() {
                                selected = value!;
                              });
                            },
                          ),
                          Text(
                            "Remember Me",
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ],
                      ),
                      GestureDetector(
                        onTap: landingResetNavigator,
                        child: Text(
                          "Forgot Password?",
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(
                                color: Theme.of(context).colorScheme.primary,
                                decoration: TextDecoration.underline,
                                decorationColor:
                                    Theme.of(context).colorScheme.primary,
                                decorationThickness: 2,
                              ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 40),
                  _isSubmitting
                      ? const Center(child: CircularProgressIndicator())
                      : TextButton(
                          onPressed: _submitForm,
                          style: TextButton.styleFrom(
                            backgroundColor:
                                Theme.of(context).colorScheme.primary,
                            textStyle: Theme.of(context).textTheme.titleMedium,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  "Sign In",
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleLarge!
                                      .copyWith(
                                        fontSize: 20,
                                        color: Colors.white,
                                      ),
                                ),
                              ),
                              Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 5),
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  Icons.arrow_right_alt,
                                  color: Theme.of(context).colorScheme.primary,
                                  size: 45,
                                ),
                              ),
                            ],
                          ),
                        ),
                  const SizedBox(height: 25),
                  Center(
                    child: Text(
                      " Or Continue With ",
                      style: Theme.of(context).textTheme.bodyMedium,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 25),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset("assets/images/google2.svg"),
                      const SizedBox(width: 20),
                      SvgPicture.asset("assets/images/apple2.svg"),
                    ],
                  ),
                  const ContinueWay(
                    directText: "SIGN_UP",
                    directWidget: SignUpPage(),
                    descText: "Don't have account yet ?",
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
