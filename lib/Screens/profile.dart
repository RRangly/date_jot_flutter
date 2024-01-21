import 'package:date_jot/Modules/auth.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
      ),
      body: ElevatedButton(
          child: Text("Signout"),
          onPressed: () async {
            await AuthService().signOut();
            Navigator.pushNamedAndRemoveUntil(context, "/start", (route) => false);
          }),
    );
  }
}
