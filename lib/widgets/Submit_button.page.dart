import 'package:flutter/material.dart';

class SubmitButton extends StatelessWidget {
  const SubmitButton({super.key, required this.value, required this.onPress});
  final String value;
  final VoidCallback onPress;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
      ),
      child: TextButton(
        onPressed: onPress,
        style: TextButton.styleFrom(
          backgroundColor: Theme.of(context).colorScheme.primary,
          textStyle: Theme.of(context).textTheme.titleMedium,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                value,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
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
    );
  }
}
