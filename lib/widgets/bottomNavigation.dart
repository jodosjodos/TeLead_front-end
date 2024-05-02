
import 'package:flutter/material.dart';

class BottomNavigation extends StatelessWidget {
  const BottomNavigation({super.key, required this.currentStep, required this.nextPage});
  final int currentStep;
 final Widget nextPage;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: List.generate(
              3,
              (index) => Container(
                margin: const EdgeInsets.all(3),
                width: currentStep == index ? 25 : 11,
                height: 11.0,
                decoration: BoxDecoration(
                  color: index == currentStep ? Colors.blue : Colors.grey,
                  shape: currentStep == index
                      ? BoxShape.rectangle
                      : BoxShape.circle,
                  borderRadius: currentStep == index
                      ? const BorderRadius.all(
                          Radius.circular(
                            10,
                          ),
                        )
                      : null,
                ),
              ),
            ),
          ),
          FloatingActionButton(
            backgroundColor: Theme.of(context).colorScheme.primary,
            foregroundColor: Colors.white,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: ((context) => nextPage),
                ),
              );
            },
            child: const Icon(
              size: 35,
              Icons.arrow_right_alt,
            ),
          ),
        ],
      ),
    );
  }
}
