import 'package:extrac_app/Screens/MasterUser/master_page.dart';
import 'package:extrac_app/Screens/login_screen.dart';
import 'package:extrac_app/Screens/signUp_page.dart';
import 'package:extrac_app/Services/authentication.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(App());
}

class App extends StatefulWidget {
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  // Set default `_initialized` and `_error` state to false
  bool _initialized = false;
  bool _error = false;

  // Define an async function to initialize FlutterFire
  void initializeFlutterFire() async {
    try {
      // Wait for Firebase to initialize and set `_initialized` state to true
      await Firebase.initializeApp();
      setState(() {
        _initialized = true;
      });
    } catch (e) {
      // Set `_error` state to true if Firebase initialization fails
      setState(() {
        _error = true;
      });
    }
  }

  @override
  void initState() {
    initializeFlutterFire();
    print('Initialised');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Show error message if initialization failed
    if (_error) {
      print('Something went wrong.');
    }

    // Show a loader until FlutterFire is initialized
    if (!_initialized) {
      return CircularProgressIndicator();
    }

    return MultiProvider(
      providers: [
        ListenableProvider(
          create: (context) => AuthenticationService(FirebaseAuth.instance),
        ),
        StreamProvider(
          create: (context) =>
              context.read<AuthenticationService>().authStateChanges,
          initialData: null,
        ),
      ],
      child: MaterialApp(
        title: 'Extrac',
        theme: ThemeData(
          primarySwatch: Colors.cyan,
          fontFamily: 'Poppins',
        ),
        home: AuthenticationWrapper(),
        routes: {
          'signUp': (context) => SignUp(),
          'Master': (context) => Master(),
        },
      ),
    );
  }
}

class AuthenticationWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final firebaseUser = Provider.of<User>(context);
    if (firebaseUser == null) {
      return LogIn();
    }
    return Master();
  }
}
