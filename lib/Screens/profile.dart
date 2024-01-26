import 'package:date_jot/Modules/auth.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = AuthService().user;

    if (user != null) {
      return Scaffold(
        appBar: AppBar(
          title: Text(user.displayName ?? "Guest"),
        ),
        body: ElevatedButton(
            child: Text("Signout"),
            onPressed: () async {
              await AuthService().signOut();
              Navigator.pushNamedAndRemoveUntil(context, "/start", (route) => false);
            }),
      );
    }
    return Placeholder();
  }
}
