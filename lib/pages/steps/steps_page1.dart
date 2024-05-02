import 'package:flutter/material.dart';
import 'package:te_lead/pages/steps/steps_page2.dart';
import 'package:te_lead/pages/utils/nextStep.dart';
import 'package:te_lead/widgets/bottomNavigation.dart';

class Step1Page extends StatefulWidget {
  const Step1Page({super.key});

  @override
  State<Step1Page> createState() => _StepsPageState();
}

class _StepsPageState extends State<Step1Page> {
  int currentStep = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
              onPressed: ()=>skipSteps(context),
              child: Text(
                "Skip",
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.secondary,
                    ),
              ),
            ),
            Center(
              child: Column(
                children: [
                  Text(
                    "Online Learning",
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Text(
                    "We Provide Classes Online Classes and Pre Recorded Lectures.!",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(
                    height: 60,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigation(
          currentStep: currentStep, nextPage: const Step2Page()),
    );
  }
}
