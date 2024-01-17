import 'package:date_jot/Modules/account.dart';
import 'package:date_jot/Screens/calendar.dart';
import 'package:date_jot/Modules/custom_functions.dart';
import 'package:date_jot/Modules/custom_settings.dart';
import 'package:flutter/material.dart';

class LoggedInScreen extends StatefulWidget {
  const LoggedInScreen({Key? key}) : super(key: key);
  @override
  State<LoggedInScreen> createState() => LoggedInScreenState();
}

class LoggedInScreenState extends State<LoggedInScreen> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final height = constraints.maxHeight;
        return Scaffold(
          backgroundColor: CustomSettings.mainGreen,
          body: Column(
            children: [
              SizedBox(height: height * 0.2),
              CircleAvatar(
                radius: 40,
                backgroundImage: NetworkImage(Account.pfpURL),
              ),
              SizedBox(height: height * 0.03),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Logged In As\n${Account.email}",
                    style: const TextStyle(
                      fontFamily: "WorkSansMedium",
                      color: Colors.black,
                      fontSize: 24,
                      fontStyle: FontStyle.normal,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              SizedBox(height: height * 0.2),
              TextButton(
                onPressed: () async {
                  CustomFunctions.navigateTo(context, const CalendarScreen());
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(22),
                    boxShadow: const [CustomSettings.defaultBoxShadow],
                  ),
                  height: height * 0.06,
                  width: width * 0.7,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        "Continue",
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
            ],
          ),
        );
      },
    );
  }
}
