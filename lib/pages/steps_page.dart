import 'package:flutter/material.dart';

class StepsPage extends StatelessWidget {
  const StepsPage({super.key});

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
            Text(
              "Skip",
              style: TextStyle(
                color: Theme.of(context).colorScheme.secondary,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            Column(
              children: [
                Text(
                  "Online Learning",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.secondary,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                const Text(
                  "We Provide Classes Online Classes and Pre Recorded \n Lectures.!",
                ),
              ],
            )
          ],
        ),
      ),
      bottomNavigationBar: Row(
        children: [
          const Text(". . ."),
          FloatingActionButton(
            onPressed: () {},
            child: const Icon(
              Icons.arrow_right_alt,
            ),
          )
        ],
      ),
    );
  }
}
