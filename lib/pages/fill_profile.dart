import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:provider/provider.dart';
import 'package:te_lead/providers/user_provider.dart';
import 'package:te_lead/utils/form_validtors.dart';
import 'package:te_lead/utils/pick_image.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:dio/dio.dart';

class FillProfile extends StatefulWidget {
  const FillProfile({super.key});

  @override
  State<FillProfile> createState() => _FillProfileState();
}

class _FillProfileState extends State<FillProfile> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _nickNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  bool _isSubmitting = false;
  String? phoneNumber;
  String gender = "male";
  late String rootUrl;
  late String url;
  late String id;
  late String token;
  late Dio dio;
  // gender
  static final List<String> _gender = ["male", "female", "neutral"];
  Uint8List? _image;

  // load initial values
  @override
  void initState() {
    loadEnvVariables();
    super.initState();
  }

  void selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      initialDate: DateTime.now(),
    );
    if (pickedDate != null) {
      setState(() {
        _dateController.text = "${pickedDate.toLocal()}".split(" ")[0];
      });
    }
  }

  void handleGenderChange(String newGender) {
    setState(() {
      gender = newGender;
    });
  }

  void selectImage() async {
    Uint8List img = await pickImage(ImageSource.gallery);
    setState(() {
      _image = img;
    });
  }

  Future<void> loadEnvVariables() async {
    await dotenv.load();
    setState(() {
      rootUrl = dotenv.env["API_URL"]!;
      url = "$rootUrl/user/fillProfile";
      //  load provider user
      final Map<String, dynamic> userDetails =
          Provider.of<UserProvider>(context).userData;
      id = userDetails["id"];

      token = userDetails["token"];
      dio = Dio(
        BaseOptions(
          headers: {HttpHeaders.authorizationHeader: "Bearer $token"},
        ),
      );
    });
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isSubmitting = true;
      });
      final Map<String, dynamic> user = {
        "profileImage": _image,
        "email": _emailController.text,
        "fullName": _fullNameController.text,
        "nickname": _nickNameController.text,
        "dateOfBirth": _dateController.text,
        "phone": _phoneNumberController.text,
        "gender": gender
      };

      final realUrl = "$url/$id";
      try {
        var response = await dio.post(realUrl, data: user);
        print(response.data);
      } on DioException catch (e) {
        final error = e.response?.data;
        final String message = error["response"]["message"].toString();
        final String statusCode = error["statusCode"].toString();
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text("Fail to sign up"),
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
        _isSubmitting = false;
      } finally {
        setState(() {
          _isSubmitting = false;
        });
      }

      // Future.delayed(const Duration(seconds: 3), () {
      //   showDialog(
      //     barrierDismissible: false,
      //     context: context,
      //     builder: (BuildContext context) {
      //       return const SuccessAuthentication(
      //         avatar: "assets/images/successAvatar.png",
      //       );
      //     },
      //   );

      //   // Wait for 3 seconds while showing the dialog
      //   Future.delayed(const Duration(seconds: 3), () {
      //     Navigator.of(context).pop(); // Dismiss the dialog

      //     // Navigate to the HomePage
      //     Navigator.of(context).pushReplacement(
      //       MaterialPageRoute(builder: (context) => const HomePage()),
      //     );
      //   });
      // }).whenComplete(() {
      //   setState(() {
      //     _isSubmitting = false;
      //   });
      // });
    }
  }

  @override
  void dispose() {
    _dateController.dispose();
    _fullNameController.dispose();
    _nickNameController.dispose();
    _emailController.dispose();
    _phoneNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Fill Your Profile"),
          backgroundColor: Theme.of(context).colorScheme.background,
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Stack(
                      children: [
                        _image != null
                            ? CircleAvatar(
                                radius: 50,
                                backgroundImage: MemoryImage(_image!),
                              )
                            : CircleAvatar(
                                radius: 50,
                                child: SvgPicture.asset(
                                  "assets/images/profile.svg",
                                  height: 100,
                                  width: 100,
                                ),
                              ),
                        Positioned(
                          bottom: 2,
                          height: 30,
                          right: 3,
                          child: Container(
                            decoration: const BoxDecoration(
                                color: Color.fromRGBO(22, 127, 113, 1),
                                shape: BoxShape.circle),
                            child: IconButton(
                              iconSize: 20,
                              color: Colors.white,
                              icon: const Icon(
                                Icons.edit_calendar_outlined,
                              ),
                              onPressed: selectImage,
                            ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    TextFormField(
                      controller: _fullNameController,
                      validator: fullNameNickNameValidator,
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                        hintText: "Full Name",
                        hintStyle: Theme.of(context).textTheme.titleSmall,
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
                      controller: _nickNameController,
                      validator: fullNameNickNameValidator,
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                        hintText: "Nick Name",
                        hintStyle: Theme.of(context).textTheme.titleSmall,
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
                      controller: _dateController,
                      readOnly: true,
                      keyboardType: TextInputType.datetime,
                      decoration: InputDecoration(
                        hintText: "Date of Birth",
                        hintStyle: Theme.of(context).textTheme.titleSmall,
                        prefixIcon: const Icon(Icons.calendar_month_outlined),
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      onTap: () => selectDate(context),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
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
                    const SizedBox(
                      height: 20,
                    ),
                    IntlPhoneField(
                      controller: _phoneNumberController,
                      validator: phoneValidator,
                      decoration: InputDecoration(
                        hintText: "Phone Number",
                        hintStyle: Theme.of(context).textTheme.titleSmall,
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      languageCode: "en",
                    ),
                    DropdownButtonFormField(
                      value: gender,
                      validator: genderValidator,
                      decoration: InputDecoration(
                        hintText: "gender",
                        hintStyle: Theme.of(context).textTheme.titleSmall,
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                      items: _gender
                          .map<DropdownMenuItem<String>>(
                            (String value) => DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            ),
                          )
                          .toList(),
                      onChanged: (String? value) {
                        handleGenderChange(value!);
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextButton(
                      onPressed: _isSubmitting ? null : _submitForm,
                      style: TextButton.styleFrom(
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        textStyle: Theme.of(context).textTheme.titleMedium,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              "Continue",
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
                            margin: const EdgeInsets.symmetric(horizontal: 5),
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.arrow_right_alt,
                              color: Theme.of(context).colorScheme.primary,
                              size: 45,
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
