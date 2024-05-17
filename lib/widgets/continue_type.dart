import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class ContinueWay extends StatelessWidget {
  const ContinueWay(
      {super.key,
      required this.directText,
      required this.directWidget,
      required this.descText});
  final String directText;
  final Widget directWidget;
  final String descText;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: descText,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Theme.of(context).colorScheme.tertiary,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            TextSpan(
              text: directText,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.underline,
                    decorationColor: Theme.of(context).colorScheme.primary,
                    decorationThickness: 4,
                  ),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => directWidget,
                    ),
                  );
                },
            ),
          ],
        ),
      ),
    );
  }
}
