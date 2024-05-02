import 'package:flutter/material.dart';
import 'package:te_lead/pages/steps_page.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(
        const Duration(seconds: 3),
        () => {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const StepsPage()),
              )
            });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: Expanded(
          child: Container(
        width: double.infinity,
        height: double.infinity,
        color: Theme.of(context).colorScheme.primary,
        child: Image.asset("assets/images/logo.png"),
      )),
    );
  }
}
