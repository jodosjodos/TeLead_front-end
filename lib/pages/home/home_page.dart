import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:te_lead/providers/user_provider.dart';
import 'package:te_lead/utils/fe_user_details.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<Map<String, dynamic>> userDetails;

  // user details
  String? userNames;

  @override
  void initState() {
    final Map<String, dynamic> user =
        Provider.of<UserProvider>(context, listen: false).userData;
    final String token = user["token"];
    final String userId = user["userId"];
    userDetails = getUserAccountDetails(token: token, userId: userId);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hi,$userNames"),
      ),
      body: FutureBuilder(
        future: userDetails,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          }
          if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          }
          final data = snapshot.data!;

          setState(() {
            userNames = data["user"]["fullName"];
          });
          return const Center(
            child: Text("data retrieved"),
          );
        },
      ),
    );
  }
}
