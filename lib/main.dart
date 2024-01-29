import 'package:date_jot/routes.dart';
import 'package:date_jot/theme.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(DateJot());
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
  //final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: appRoutes,
      theme: appTheme,
      initialRoute: "/start",
    );
    /*
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          log("Error");
          return Text('error');
        }

        if (snapshot.connectionState == ConnectionState.done) {
          log("Done");
          return MaterialApp(
            routes: appRoutes,
            theme: appTheme,
            initialRoute: "/start",
          );
          /*
          final String initRoute;
          if (snapshot.hasData) {
            initRoute = '/start';
          } else {
            initRoute = '/start';
          }
          */
        }
        log("Loading");
        return const Scaffold(
          body: Text("Loading..."),
        );
      },
    );
    */
  }
}
