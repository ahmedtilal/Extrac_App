import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:extrac_app/Screens/ChildUser/child_page.dart';
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
        StreamProvider<User>(
          create: (context) =>
              context.read<AuthenticationService>().authStateChanges,
          initialData: null,
        ),
        // StreamProvider<DocumentSnapshot>(
        //     create: (_) =>
        //         UserWrapper(FirebaseAuth.instance.currentUser).currentUser,
        //     initialData: null),
      ],
      child: MaterialApp(
        title: 'Extrac',
        theme: ThemeData(
          primarySwatch: Colors.cyan,
          fontFamily: 'Poppins',
        ),
        home: AuthenticationWrapper(),
        routes: {
          'home': (context) => AuthenticationWrapper(),
          'signUp': (context) => SignUp(),
          'Master': (context) => Master(),
        },
      ),
    );
  }
}

class AuthenticationWrapper extends StatefulWidget {
  @override
  _AuthenticationWrapperState createState() => _AuthenticationWrapperState();
}

class _AuthenticationWrapperState extends State<AuthenticationWrapper> {
  @override
  Widget build(BuildContext context) {
    final firebaseUser = Provider.of<User>(context);
    if (firebaseUser == null) {
      return LogIn();
    }
    return StreamProvider<DocumentSnapshot>(
        create: (context) => UserWrapper(firebaseUser).currentUser,
        initialData: null,
        child: UserWrapper(firebaseUser));
  }
}

//Checks the type of user whether isMaster or not and returns a corresponding type of page.
class UserWrapper extends StatelessWidget {
  final User user;
  UserWrapper(this.user);
  Stream<DocumentSnapshot> get currentUser {
    String userId;
    if (user != null) {
      userId = user.uid;
    }
    return FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future:
            FirebaseFirestore.instance.collection('users').doc(user.uid).get(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else if (snapshot != null) {
            var doc = snapshot.data;
            bool isMaster = doc["isMaster"];
            return isMaster ? Master() : Child();
          }
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        });
  }
}
