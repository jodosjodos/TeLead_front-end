import 'package:flutter/material.dart';

class ProgressTracker extends StatelessWidget {
  const ProgressTracker({super.key, required this.currentStep, required this.totalSteps, required this.progress});
  final int currentStep;
  final int totalSteps;
  final double progress;  // Current step's progress as a fraction (0.0 to 1.0)



  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(totalSteps, (index) {
        return index == currentStep
            ? Container(
                width: 30.0,
                height: 30.0,
                margin: const EdgeInsets.all(8.0),
                child: CircularProgressIndicator(
                  value: progress,  // Partially fill the circular indicator
                  backgroundColor: Colors.grey[300],
                  valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue),
                  strokeWidth: 3,
                ),
              )
            : Container(
                width: 20.0,
                height: 20.0,
                margin: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: index < currentStep ? Colors.blue : Colors.grey,
                  shape: BoxShape.circle,
                ),
              );
      }),
    );
  }
}