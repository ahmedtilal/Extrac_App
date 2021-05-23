import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:extrac_app/constants/constants.dart';
import 'package:extrac_app/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'authentication.dart';

class AddParentUser extends StatelessWidget {
  final String email;
  final String password;
  final String name;
  final String phoneNumber;

  AddParentUser({
    @required this.email,
    @required this.password,
    @required this.name,
    @required this.phoneNumber,
  });

  @override
  Widget build(BuildContext context) {
    Future<void> addUser() async {
      await Provider.of<AuthenticationService>(context, listen: false)
          .signUp(email: email, password: password);
      print('$name, $email, $password, $phoneNumber');
      String userID = FirebaseAuth.instance.currentUser.uid;
      CollectionReference users =
          FirebaseFirestore.instance.collection('users');
      await users
          .doc(userID)
          .set({
            'name': name,
            'phoneNumber': phoneNumber,
            'isMaster': true,
            'children': FieldValue.arrayUnion([userID]),
          })
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
      },
      style: kAltButtonStyle,
      child: Text('SIGNUP', style: kAltButtonTextStyle),
    );
  }
}

class AddChildUser extends StatelessWidget {
  final String email;
  final String password;
  final String name;
  final String phoneNumber;
  final String parentUserId;

  AddChildUser({
    @required this.email,
    @required this.password,
    @required this.name,
    @required this.phoneNumber,
    @required this.parentUserId,
  });

  @override
  Widget build(BuildContext context) {
    Future<void> addChildUser() async {
      await Provider.of<AuthenticationService>(context, listen: false)
          .signUp(email: email, password: password);
      print('$name, $email, $password, $phoneNumber');
      String userID = FirebaseAuth.instance.currentUser.uid;
      CollectionReference users =
          FirebaseFirestore.instance.collection('users');
      await users
          .doc(parentUserId)
          .update({
            'children': FieldValue.arrayUnion([userID])
          })
          .then((value) => print("User Added to array"))
          .catchError((error) => print("Failed to add user: $error"));
      await users
          .doc(parentUserId)
          .collection("childUsers")
          .doc(userID)
          .set({
            'isMaster': false,
            'name': name,
            'phoneNumber': phoneNumber,
            'parent': parentUserId
          })
          .then((value) => print('User Doc created'))
          .catchError((error) => print("Failed to add user: $error"));
    }

    return ElevatedButton(
      onPressed: () async {
        await addChildUser();
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AuthenticationWrapper(),
          ),
        );
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
  final bool isApproved;
  final String parentUserId;

  AddTransaction(
      {this.amount,
      this.user,
      this.category,
      this.description,
      this.isApproved,
      @required this.parentUserId});

  Future<void> addTransaction() async {
    return await FirebaseFirestore.instance
        .collection('users')
        .doc(parentUserId)
        .collection('transactions')
        .add({
          'user': user,
          'category': category,
          'description': description,
          'amount': amount,
          'time': FieldValue.serverTimestamp(),
          'isApproved': isApproved,
        })
        .then((value) => print("Transaction Added."))
        .catchError((error) => print("Failed to add user: $error"));
  }

//Function called when master user wants to approve a transaction.
  Future<void> approveTransaction(String docReference, String parentUserId) {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(parentUserId)
        .collection('transactions')
        .doc(docReference)
        .update({'isApproved': true})
        .then((value) => print("Transaction Approved"))
        .catchError((error) => print("Failed to update transaction: $error"));
  }
}
