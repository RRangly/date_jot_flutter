import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Account {
  static String email = "", pfpURL = "";
  static bool loggedIn = false;
  static logInWith(String emailLocal, String passWordLocal) {
    FirebaseFirestore.instance
        .collection('AccountInfos')
        .doc(emailLocal)
        .get()
        .then(
      (DocumentSnapshot documentSnapshot) {
        if (documentSnapshot.exists) {
          final pwTemp = documentSnapshot.get(FieldPath(const ["password"]));
          if (pwTemp == passWordLocal) {
            Account.email = emailLocal;
            Account.pfpURL = documentSnapshot.get(FieldPath(const ["pfp"]));
            Account.loggedIn = true;
          }
        } else {
          //TODO: Account does not exist
        }
      },
    );
  }

  static Future<bool> logInWithOutPW(String emailLocal) async {
    await FirebaseFirestore.instance
        .collection('AccountInfos')
        .doc(emailLocal)
        .get()
        .then(
      (DocumentSnapshot documentSnapshot) {
        if (documentSnapshot.exists) {
          Account.email = emailLocal;
          Account.pfpURL = documentSnapshot.get(FieldPath(const ["pfp"]));
          Account.loggedIn = true;
        } else {
          //TODO: Account does not exist
        }
      },
    );
    return Account.loggedIn;
  }

  static void createAccount(
      String email, String password, String? pfpLink) async {
    final userJson = {
      'email': email,
      'password': password,
      'pfp': pfpLink,
    };
    final fireBaseAccountCollection = FirebaseFirestore.instance
        .collection("AccountInfos")
        .doc(email.toString());
    await fireBaseAccountCollection.set(userJson);
  }
}

class AccountSettingsScreen extends StatefulWidget {
  const AccountSettingsScreen({Key? key}) : super(key: key);

  @override
  State<AccountSettingsScreen> createState() => AccountSettingsScreenState();
}

class AccountSettingsScreenState extends State<AccountSettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final height = constraints.maxHeight;
        return Scaffold();
      },
    );
  }
}
