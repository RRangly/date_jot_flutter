import 'package:date_jot/Modules/custom_settings.dart';
import '../../LegacyLib/ScreensLegacy/provider_signin.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../lib/Modules/custom_widgets.dart';
import '../../lib/Modules/custom_functions.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => SignUpScreenState();
  static Widget emailSignUpScreen(BuildContext context) {
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
              SizedBox(height: height * 0.15),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    "Sign Up With Email",
                    style: TextStyle(
                      fontFamily: "WorkSansMedium",
                      color: Colors.black,
                      fontSize: CustomSettings.defaultFontSize,
                    ),
                  ),
                ],
              ),
              SizedBox(height: height * 0.02),
              CustomWidgets.inputBox(
                width * 0.8,
                height * 0.06,
                "Assets/Images/UIElements/LoginMenu/MailIcon.png",
                "Email",
                Colors.white,
                2,
                6,
                14,
                12,
                textEConts[0],
              ),
              SizedBox(height: height * 0.02),
              CustomWidgets.inputBox(
                width * 0.8,
                height * 0.06,
                "Assets/Images/UIElements/LoginMenu/LockIcon.png",
                "Password",
                Colors.white,
                2,
                6,
                14,
                12,
                textEConts[1],
              ),
              SizedBox(height: height * 0.04),
            ],
          ),
        );
      },
    );
  }

  static void signUpAsGoogle(context) async {
    final googleProvider = Provider.of<GoogleSignInProvider>(context, listen: false);
    await googleProvider.googleLogIn();

    if (!context.mounted) return;
    CustomFunctions.navigateTo(context, const ProviderPassWordScreen());
  }

  static void signUpAsEmail(context) async {
    CustomFunctions.navigateTo(context, emailSignUpScreen(context));
  }

  static Widget signUpAs(
    BuildContext context,
    double width,
    double height,
    String assetImagePath,
    String textLocal,
    Function provider,
  ) =>
      FloatingActionButton.extended(
        onPressed: () async {
          provider(context);
        },
        icon: Image.asset(
          assetImagePath,
          height: 32,
          width: 32,
        ),
        label: Text(
          textLocal,
          style: const TextStyle(
            fontFamily: "WorkSans",
            color: Colors.black,
            fontSize: 14,
          ),
        ),
        backgroundColor: Colors.white,
        extendedPadding: const EdgeInsets.symmetric(horizontal: 60),
      );
  //functions
}

//build
class SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => GoogleSignInProvider(),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final width = constraints.maxWidth;
          final height = constraints.maxHeight;
          return Scaffold(
            backgroundColor: CustomSettings.mainGreen,
            body: Column(
              children: [
                SizedBox(height: height * 0.07),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      "Sign up",
                      style: TextStyle(
                        fontFamily: "WorkSansMedium",
                        color: Colors.black,
                        fontSize: CustomSettings.defaultFontSize,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: height * 0.06),
                SignUpScreen.signUpAs(
                  context,
                  width * 0.8,
                  height * 0.05,
                  "Assets/Images/UIElements/LoginMenu/MailIcon.png",
                  "Sign up with Email",
                  SignUpScreen.signUpAsEmail,
                ),
                SizedBox(height: height * 0.05),
                SignUpScreen.signUpAs(
                  context,
                  width * 0.8,
                  height * 0.05,
                  "Assets/Images/UIElements/LoginMenu/GoogleLogo.png",
                  "Sign up with Google",
                  SignUpScreen.signUpAsGoogle,
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
