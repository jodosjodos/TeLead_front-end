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
        child: Center(
          child: Column(
            children: [
              Stack(
                children: [
                  CircleAvatar(
                    radius: 100,
                    child: SvgPicture.asset("assets/images/profile.svg",
                        height: 200, width: 200),
                  ),
                  Positioned(
                    bottom: 20,
                    right: 0,
                    child: Container(
                      decoration: const BoxDecoration(
                          color: Colors.green, shape: BoxShape.circle),
                      child: IconButton(
                        color: Colors.white,
                        icon: const Icon(
                          Icons.edit_calendar_outlined,
                        ),
                        onPressed: () {},
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
