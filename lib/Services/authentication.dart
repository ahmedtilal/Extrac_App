import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class Authentication extends StatefulWidget {
  @override
  _AuthenticationState createState() => _AuthenticationState();
}

class _AuthenticationState extends State<Authentication> {
  @override
  void initState() async {
    await Firebase.initializeApp();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
