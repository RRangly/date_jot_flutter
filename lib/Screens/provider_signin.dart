import 'package:date_jot/Modules/account.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../Modules/custom_widgets.dart';
import '../Modules/custom_settings.dart';

class GoogleSignInProvider extends ChangeNotifier {
  static final googleSignIn = GoogleSignIn();

  static GoogleSignInAccount? googleUser;

  Future googleLogIn() async {
    if (googleUser != null) {
      googleUser = await googleSignIn.disconnect();
      print("disconnected");
    }
    googleUser = await googleSignIn.signIn();
    if (googleUser == null) return;
    final googleUserTemp = googleUser;
    googleUser = await GoogleSignIn().disconnect();
    googleUser = null;
    return googleUserTemp!.email;
  }
}

class ProviderPassWordScreen extends StatefulWidget {
  const ProviderPassWordScreen({Key? key}) : super(key: key);
  @override
  State<ProviderPassWordScreen> createState() => ProviderPassWordScreenState();
}

class ProviderPassWordScreenState extends State<ProviderPassWordScreen> {
  @override
  Widget build(BuildContext context) {
    List<TextEditingController> textEConts = [
      TextEditingController(),
      TextEditingController(),
    ];
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final height = constraints.maxHeight;
        return Scaffold(
          backgroundColor: CustomSettings.mainGreen,
          body: Column(
            children: [
              SizedBox(height: height * 0.1),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    'Enter Password',
                    style: TextStyle(
                      fontFamily: "WorkSans",
                      color: Colors.black,
                      fontSize: 24,
                    ),
                  ),
                ],
              ),
              SizedBox(height: height * 0.2),
              CustomWidgets.inputBox(
                width * 0.8,
                height * 0.06,
                "Assets/Images/UIElements/LoginMenu/LockIcon.png",
                "Password",
                Colors.white,
                1,
                6,
                14,
                12,
                textEConts[0],
              ),
              SizedBox(height: height * 0.05),
              CustomWidgets.inputBox(
                width * 0.8,
                height * 0.06,
                "Assets/Images/UIElements/LoginMenu/LockIcon.png",
                "Verify Password",
                Colors.white,
                1,
                6,
                14,
                12,
                textEConts[1],
              ),
              SizedBox(height: height * 0.1),
              FloatingActionButton.extended(
                onPressed: () async {
                  if (textEConts[0].text == textEConts[1].text) {
                    Account.createAccount(
                      GoogleSignInProvider.googleUser!.email,
                      textEConts[0].text,
                      GoogleSignInProvider.googleUser!.photoUrl,
                    );
                    GoogleSignInProvider.googleUser =
                        await GoogleSignIn().signOut();
                  } else {}
                },
                label: const Text(
                  'Sign Up',
                  style: TextStyle(
                    fontFamily: "WorkSans",
                    color: Colors.black,
                    fontSize: 14,
                  ),
                ),
                backgroundColor: Colors.white,
                extendedPadding: const EdgeInsets.symmetric(horizontal: 60),
              ),
            ],
          ),
        );
      },
    );
  }
}
