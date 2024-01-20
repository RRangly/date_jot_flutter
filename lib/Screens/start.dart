import 'package:date_jot/Modules/custom_settings.dart';
import 'package:flutter/material.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    final width = MediaQuery.of(context).size.width;
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
                Text(
                  "All-In-One App for",
                  style: Theme.of(context).textTheme.bodyLarge,
                  textAlign: TextAlign.center,
                ),
                Text(
                  "Organizing Work",
                  style: Theme.of(context).textTheme.bodyLarge,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: height * 0.5 * 0.2),
                TextButton(
                  onPressed: () => Navigator.pushNamed(context, '/login'),
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
  }
}
