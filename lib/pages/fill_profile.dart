import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:te_lead/pages/home/home_page.dart';
import 'package:te_lead/pages/utils/form_validtors.dart';
import 'package:te_lead/pages/utils/pick_image.dart';
import 'package:te_lead/widgets/success_full_authentication.dart';

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

  static final List<String> _gender = ["male", "female", "neutral"];
  Uint8List? _image;
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

_submitForm() {
  if (_formKey.currentState!.validate()) {
    setState(() {
      _isSubmitting = true;
    });
    final user = {
      "profileImage": _image,
      "email": _emailController.text,
      "fullName": _fullNameController.text,
      "nickname": _nickNameController.text,
      "dateOfBirth": _dateController.text,
      "phone": _phoneNumberController.text,
      "gender": gender
    };

    // Print user data to console for debugging
    print(user);

    // Start the process of showing the dialog and waiting for 3 seconds
    Future.delayed(const Duration(seconds: 3), () {
      showDialog(
        barrierDismissible: false, // Make dialog modal
        context: context,
        builder: (BuildContext context) {
          return const SuccessAuthentication();
        },
      );

      // Wait for 3 seconds while showing the dialog
      Future.delayed(const Duration(seconds: 3), () {
        Navigator.of(context).pop(); // Dismiss the dialog

        // Navigate to the HomePage
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const HomePage()),
        );
      });
    }).whenComplete(() {
      setState(() {
        _isSubmitting = false;
      });
    });
  }
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
