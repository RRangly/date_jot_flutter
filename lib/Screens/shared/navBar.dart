import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const [
        BottomNavigationBarItem(
          icon: Icon(
            FontAwesomeIcons.house,
            size: 20,
          ),
          label: "Home",
        ),
        BottomNavigationBarItem(
          icon: Icon(
            FontAwesomeIcons.calendar,
            size: 20,
          ),
          label: "Calendar",
        ),
        BottomNavigationBarItem(
          icon: Icon(
            FontAwesomeIcons.user,
            size: 20,
          ),
          label: "Profile",
        ),
      ],
      onTap: (int idx) {
        switch (idx) {
          case 0:
            Navigator.pushNamed(context, "/");
            break;
          case 1:
            Navigator.pushNamed(context, "/calendar");
            break;
          case 2:
            Navigator.pushNamed(context, "/profile");
            break;
        }
      },
    );
  }
}
