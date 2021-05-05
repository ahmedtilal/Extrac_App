import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:extrac_app/constants/constants.dart';
import 'package:extrac_app/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'authentication.dart';

class AddUser extends StatelessWidget {
  final String email;
  final String password;
  final String name;
  final String phoneNumber;

  AddUser({
    this.email,
    this.password,
    this.name,
    this.phoneNumber,
  });

  @override
  Widget build(BuildContext context) {
    Future<void> addUser() async {
      print('$name, $email, $password, $phoneNumber');
      CollectionReference users =
          FirebaseFirestore.instance.collection('users');
      await Provider.of<AuthenticationService>(context, listen: false)
          .signUp(email: email, password: password);
      String userID = FirebaseAuth.instance.currentUser.uid;
      return users
          .doc(userID)
          .set({'name': name, 'phoneNumber': phoneNumber, 'isMaster': true})
          .then((value) => print("User Added"))
          .catchError((error) => print("Failed to add user: $error"));
    }

    return ElevatedButton(
      onPressed: () async {
        await addUser();
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AuthenticationWrapper(),
          ),
        );
        //TODO remember to change for the condition of the non master user.
      },
      style: kAltButtonStyle,
      child: Text('SIGNUP', style: kAltButtonTextStyle),
    );
  }
}

class AddTransaction {
  final String category;
  final String description;
  final int amount;
  final String user;

  AddTransaction({this.amount, this.user, this.category, this.description});

  CollectionReference transactions =
      FirebaseFirestore.instance.collection('transactions');

  Future<void> addTransaction() {
    return transactions
        .add({
          'user': user,
          'category': category,
          'description': description,
          'amount': amount,
          'time': FieldValue.serverTimestamp(),
        })
        .then((value) => print("Transaction Added."))
        .catchError((error) => print("Failed to add user: $error"));
  }
}
