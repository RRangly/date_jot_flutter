import 'package:date_jot/Screens/home.dart';
import 'Screens/start.dart';
import 'Screens/calendar.dart';
import 'Screens/login.dart';
import 'Screens/profile.dart';

var appRoutes = {
  '/': (context) => const HomeScreen(),
  '/start': (context) => const StartScreen(),
  '/calendar': (context) => const CalendarScreen(),
  '/login': (context) => const LoginScreen(),
  '/profile': (context) => const ProfileScreen(),
};
