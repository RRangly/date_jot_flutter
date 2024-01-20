import 'package:date_jot/routes.dart';
import 'package:date_jot/theme.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';

/*

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const DateJot());
}

class DateJot extends StatelessWidget {
  const DateJot({super.key});
  @override
  Widget build(BuildContext context) {

    return ChangeNotifierProvider(
      create: (context) => GoogleSignInProvider(),
      child: const MaterialApp(
        title: "Calendar",
        home: StartScreen(),
      ),
    );
  }
}
*/

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const DateJot());
}

/// We are using a StatefulWidget such that we only create the [Future] once,
/// no matter how many times our widget rebuild.
/// If we used a [StatelessWidget], in the event where [App] is rebuilt, that
/// would re-initialize FlutterFire and make our application re-enter loading state,
/// which is undesired.
class DateJot extends StatefulWidget {
  const DateJot({super.key});

  @override
  State<DateJot> createState() => DateJotState();
}

class DateJotState extends State<DateJot> {
  /// The future is part of the state of our widget. We should not call `initializeApp`
  /// directly inside [build].
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  final Future<SharedPreferences> sharedP = SharedPreferences.getInstance();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize FlutterFire:
      future: Future.wait([
        _initialization,
        sharedP
      ]),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text('loading');
        } else if (snapshot.hasError) {
          return const Text('error');
        } else {
          final String initRoute;
          if (snapshot.hasData) {
            initRoute = '/';
          } else {
            initRoute = '/start';
          }
          return MaterialApp(
            routes: appRoutes,
            theme: appTheme,
            initialRoute: initRoute,
          );
        }
      },
    );
  }
}
