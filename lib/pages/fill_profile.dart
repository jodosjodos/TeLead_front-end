import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FillProfile extends StatelessWidget {
  const FillProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Fill Your Profile"),
        backgroundColor: Theme.of(context).colorScheme.background,
      ),
      body: SafeArea(
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
                      borderSide: BorderSide.none),
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
                      borderSide: BorderSide.none),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              ShowDate(
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
                      borderSide: BorderSide.none),
                ),
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
                      borderSide: BorderSide.none),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
