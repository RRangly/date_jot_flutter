import '../../LegacyLib/ScreensLegacy/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:date_jot/Modules/custom_functions.dart';
import 'package:date_jot/Modules/custom_settings.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({super.key});

  @override
  State<StartScreen> createState() => StartScreenState();
}

class StartScreenState extends State<StartScreen> {
  //build
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final height = constraints.maxHeight;
        final logoSize = (width * 0.175 + height * 0.0875) / 2;
        return Scaffold(
          backgroundColor: Colors.white,
          body: Column(
            children: [
              Image(
                image: const AssetImage("Assets/Images/UIElements/NewMenu/Background.png"),
                width: width * 1.2,
                height: height * 0.5,
              ),
              Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(36)),
                  boxShadow: [
                    defaultBoxShadow
                  ],
                ),
                width: width * 1.2,
                height: height * 0.5,
                child: Column(
                  children: [
                    SizedBox(height: height * 0.04),
                    Image(
                      image: const AssetImage("Assets/Images/UIElements/General/Logo.png"),
                      width: logoSize,
                      height: logoSize,
                    ),
                    SizedBox(height: height * 0.04),
                    const Text(
                      "All-In-One App for",
                      style: TextStyle(
                        fontFamily: "WorkSansMedium",
                        color: Colors.black,
                        fontSize: defaultFontSize,
                        height: 1.2,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const Text(
                      "Organizing Work",
                      style: TextStyle(
                        fontFamily: "WorkSansMedium",
                        color: mainGreen,
                        fontSize: defaultFontSize,
                        height: 1.2,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: height * 0.5 * 0.2),
                    TextButton(
                      onPressed: () async {
                        CustomFunctions.navigateTo(context, const LoginScreen());
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: mainGreen,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        height: height * 0.075,
                        width: width * 0.75,
                        child: const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Get Started",
                              style: TextStyle(
                                fontFamily: "WorkSansMedium",
                                color: Colors.white,
                                fontSize: defaultFontSize,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
