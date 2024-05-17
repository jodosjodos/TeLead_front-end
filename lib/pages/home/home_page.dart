import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:te_lead/providers/user_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> user =
        Provider.of<UserProvider>(context).userData;
    print(user);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home page"),
      ),
      body: const SafeArea(
          child: Center(
        child: Text("Home "),
      )),
    );
  }
}
