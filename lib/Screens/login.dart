import 'package:date_jot/Modules/auth.dart';
import 'package:date_jot/Modules/custom_settings.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: mainGreen,
      body: Column(
        children: [
          SizedBox(height: height * 0.05),
          Text(
            "Sign In",
            style: TextStyle(fontFamily: "WorkSansMedium", color: Colors.black.withOpacity(0.7), fontSize: defaultFontSize, fontStyle: FontStyle.normal),
          ),
          SizedBox(height: height * 0.03),
          TextButton(
            onPressed: () async {
              AuthService().googleLogin();
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(22),
                boxShadow: [
                  defaultBoxShadowFun(8)
                ],
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
            onPressed: () async {
              AuthService().signInWithApple();
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(22),
                boxShadow: [
                  defaultBoxShadowFun(8)
                ],
              ),
              height: height * 0.06,
              width: width * 0.7,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "Assets/Images/UIElements/LoginMenu/AppleLogo.png",
                    height: 32,
                    width: 32,
                  ),
                  SizedBox(width: width * 0.02),
                  const Text(
                    "Sign in With Apple",
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
              Navigator.pushNamed(context, "/signup");
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
              Navigator.pushNamed(context, "/calendar");
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
  }
}
