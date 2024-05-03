import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class FillProfile extends StatefulWidget {
  const FillProfile({super.key});

  @override
  State<FillProfile> createState() => _FillProfileState();
}

class _FillProfileState extends State<FillProfile> {
  TextEditingController _controller = TextEditingController();
  String gender = "male";
  void selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      initialDate: DateTime.now(),
    );
    if (pickedDate != null) {
      setState(() {
        _controller.text = "${pickedDate.toLocal()}".split(" ")[0];
      });
    }
  }

  static List<String> _gender = ["male", "female", "neutral"];
  void handleGenderChange(String newGender) {
    setState(() {
      gender = newGender;
    });
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
              child: Column(
                children: [
                  Stack(
                    children: [
                      CircleAvatar(
                        radius: 50,
                        child: SvgPicture.asset("assets/images/profile.svg",
                            height: 100, width: 100),
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
                            onPressed: () {},
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  TextField(
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
                  TextField(
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
                  TextField(
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
                  TextField(
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
                    onChanged: (phone) {
                      print(phone.completeNumber);
                    },
                    onCountryChanged: (country) {
                      print('Country changed to: ' + country.name);
                    },
                  ),
                  DropdownButtonFormField(
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
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const FillProfile(),
                        ),
                      );
                    },
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
        ));
  }
}
