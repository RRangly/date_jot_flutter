import 'package:date_jot/account.dart';
import 'package:date_jot/calendar.dart';
import 'package:date_jot/custom_functions.dart';
import 'package:date_jot/custom_widgets.dart';
import 'package:date_jot/custom_settings.dart';
import 'package:date_jot/loggedin_screen.dart';
import 'package:date_jot/provider_signin.dart';
import 'package:date_jot/signup_screen.dart';
import 'package:date_jot/testscreen.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => LoginScreenState();
}

//build
class LoginScreenState extends State<LoginScreen> {
  @override
  void initState() {
    super.initState();
  }

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
              SizedBox(height: height * 0.05),
              Text(
                "Sign In",
                style: TextStyle(
                    fontFamily: "WorkSansMedium",
                    color: Colors.black.withOpacity(0.7),
                    fontSize: CustomSettings.defaultFontSize,
                    fontStyle: FontStyle.normal),
              ),
              SizedBox(height: height * 0.05),
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
              SizedBox(height: height * 0.01),
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
              SizedBox(height: height * 0.01),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "Forgot password?",
                    style: TextStyle(
                      fontFamily: "WorkSansRegular",
                      color: Colors.red[600],
                      fontSize: 12,
                    ),
                  ),
                  SizedBox(width: width * 0.1),
                ],
              ),
              SizedBox(height: height * 0.03),
              TextButton(
                onPressed: () async {
                  final loggedIn = await Account.logInWith(
                      textEConts[0].text, textEConts[1].text);
                  if (!mounted || !loggedIn) return;
                  CustomFunctions.navigateTo(context, const LoggedInScreen());
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(22),
                    boxShadow: [CustomSettings.defaultBoxShadowFun(8)],
                  ),
                  height: height * 0.06,
                  width: width * 0.7,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        "Sign in With Email",
                        style: TextStyle(
                          fontFamily: "WorkSansMedium",
                          color: Colors.black,
                          fontSize: 14,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
              TextButton(
                onPressed: () async {
                  final googleProvider =
                      Provider.of<GoogleSignInProvider>(context, listen: false);
                  final emailLocal = await googleProvider.googleLogIn();
                  final loggedIn = await Account.logInWithOutPW(
                    emailLocal,
                  );
                  if (!mounted || !loggedIn) return;
                  CustomFunctions.navigateTo(context, const LoggedInScreen());
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(22),
                    boxShadow: [CustomSettings.defaultBoxShadowFun(8)],
                  ),
                  height: height * 0.06,
                  width: width * 0.7,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "Assets/Images/UIElements/LoginMenu/GoogleLogo.png",
                        height: 32,
                        width: 32,
                      ),
                      SizedBox(width: width * 0.02),
                      const Text(
                        "Sign in With Google",
                        style: TextStyle(
                          fontFamily: "WorkSansMedium",
                          color: Colors.black,
                          fontSize: 14,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  CustomFunctions.navigateTo(context, const SignUpScreen());
                },
                child: Text(
                  "Don't have an account?",
                  style: TextStyle(
                    fontFamily: "WorkSansSemiBold",
                    color: Colors.black.withOpacity(0.5),
                    fontSize: 14,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  CustomFunctions.navigateTo(context, const CalendarScreen());
                },
                child: Text(
                  "logged in?",
                  style: TextStyle(
                    fontFamily: "WorkSansSemiBold",
                    color: Colors.black.withOpacity(0.5),
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
