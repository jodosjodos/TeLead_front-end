import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ResetPasswordLanding extends StatelessWidget {
  const ResetPasswordLanding({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        title: const Text("Forgot Password"),
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
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 20,
              ),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(16),
                ),
              ),
              child: Row(
                children: [
                  SvgPicture.asset(
                    "assets/images/message.svg",
                    width: 40,
                    height: 40,
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Via Email",
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.tertiary,
                          fontSize: 12,
                        ),
                      ),
                      Text(
                        "priscilla.frank26@gmail.com",
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 20,
              ),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(16),
                ),
              ),
              child: Row(
                children: [
                  SvgPicture.asset(
                    "assets/images/message.svg",
                    width: 40,
                    height: 40,
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Via SMS",
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.tertiary,
                          fontSize: 12,
                        ),
                      ),
                      Text(
                        "( +1 ) 480-894-5529",
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
