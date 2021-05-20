import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:extrac_app/Services/authentication.dart';
import 'package:extrac_app/constants/constants.dart';
import 'package:extrac_app/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

int month = DateTime.now().month;
String year = DateTime.now().year.toString();
DateTime startDate = DateFormat('MM/yyyy').parse('0$month/$year');
Timestamp startStamp = Timestamp.fromDate(startDate);

class TesterAdd extends StatelessWidget {
  final String parentUserId = 'vKuRv7WdrsUY7qIHeMf3GsuYxuY2';
  final String email;
  final String password;
  final String name;
  final String phoneNumber;

  TesterAdd({
    @required this.name,
    @required this.email,
    @required this.password,
    @required this.phoneNumber,
  });

//TODO this is for testing purposes for now.
  //Adding child users this way is perfectly working !!!!!!!
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
          .set({'isMaster': false, 'name': name, 'phoneNumber': phoneNumber})
          .then((value) => print('User Doc created'))
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
      child: Text('Testing ADD', style: kAltButtonTextStyle),
    );
  }
}

//TODO implement later on.
//This has been tested and worked perfectly.
class TesterAddTransaction {
  final String category;
  final String description;
  final int amount;
  final String user;
  final bool isApproved;

  TesterAddTransaction(
      {this.amount,
      this.user,
      this.category,
      this.description,
      this.isApproved});

  DocumentReference parentDoc = FirebaseFirestore.instance
      .collection('users')
      .doc('vKuRv7WdrsUY7qIHeMf3GsuYxuY2');

  Future<void> addTransaction() {
    return parentDoc
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
}

Stream<QuerySnapshot> testerGetTransactions(String parent) {
  var transactions;
  try {
    transactions = FirebaseFirestore.instance
        .collection('users')
        .doc(parent)
        .collection('transactions')
        .orderBy('time', descending: true)
        .where('time', isGreaterThanOrEqualTo: startStamp)
        .snapshots();
  } catch (e) {
    print(e.toString());
  }
  return transactions;
}

class TesterAllTransactions extends StatelessWidget {
  final String parent;
  TesterAllTransactions({@required this.parent});

  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: testerGetTransactions(parent),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text("Loading");
          }
          return ListView.builder(
              itemCount: snapshot.data.docs.length,
              itemBuilder: (context, index) {
                var doc = snapshot.data.docs[index];
                print(doc["user"]);
                return doc["isApproved"]
                    ? Card(
                        child: ListTile(
                          title: Text(doc["user"]),
                          subtitle: Text(DateFormat.yMd()
                              .add_jm()
                              .format(doc["time"].toDate())
                              .toString()),
                          trailing: Text(
                            doc["amount"].toString(),
                            style: kAmountStyle,
                          ),
                        ),
                      )
                    : Material();
              });
        });
  }
}

class TesterTransactionsPerUser extends StatelessWidget {
  final String user;
  final String parent;
  TesterTransactionsPerUser({@required this.user, @required this.parent});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        initialData: "Working....",
        stream: testerGetTransactions(parent),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text("Loading");
          }
          return ListView.builder(
              itemCount: snapshot.data.docs.length,
              itemBuilder: (context, index) {
                var doc = snapshot.data.docs[index];
                if (doc["user"] == user && doc["isApproved"] == true) {
                  return Card(
                    elevation: 3,
                    child: ListTile(
                      title: Text(doc["user"]),
                      subtitle: Text(DateFormat.yMd()
                          .add_jm()
                          .format(doc["time"].toDate())
                          .toString()),
                      trailing: Text(
                        doc["amount"].toString(),
                        style: kAmountStyle,
                      ),
                    ),
                  );
                }
                return Material();
              });
        });
  }
}
