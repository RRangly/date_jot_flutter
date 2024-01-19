import 'package:date_jot/Screens/provider_signin.dart';
import 'package:date_jot/Screens/start_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
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
  State<DateJot> createState() => _AppState();
}

class _AppState extends State<DateJot> {
  /// The future is part of the state of our widget. We should not call `initializeApp`
  /// directly inside [build].
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  final Future<SharedPreferences> sharedP = SharedPreferences.getInstance();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize FlutterFire:
      future: _initialization,
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          return Text('error');
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          return MaterialApp();
        }

        // Otherwise, show something whilst waiting for initialization to complete
        return Text('loading');
      },
    );
  }
}
