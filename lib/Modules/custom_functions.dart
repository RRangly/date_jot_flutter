import 'package:flutter/material.dart';

class CustomFunctions {
  static void navigateTo(BuildContext context, wantedLocation) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => wantedLocation));
    /*WidgetsBinding.instance.addPostFrameCallback((_) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => wantedLocation));
    });
    print("navigated");*/
  }

  static Future waitfor(int seconds) {
    return Future.delayed(Duration(seconds: seconds), () => "Partly cloudy");
  }
}
