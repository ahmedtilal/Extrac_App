import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:extrac_app/Services/firestore_write.dart';
import 'package:extrac_app/constants/constants.dart';
import 'package:extrac_app/models/widget_models.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

int month = DateTime.now().month;
String year = DateTime.now().year.toString();
DateTime startDate = DateFormat('MM/yyyy').parse('0$month/$year');
Timestamp startStamp = Timestamp.fromDate(startDate);
final _fireStore = FirebaseFirestore.instance;

//Gets the logged in user's name and whether it's a Master or child user from the database.
//Also is passed to the App's state through the provider package.

class CurrentUserInfo extends ChangeNotifier {
  var firebaseUser = FirebaseAuth.instance;
  String userId;
}

Stream<QuerySnapshot> getTransactions() {
  var transactions;
  try {
    transactions = _fireStore
        .collection('transactions')
        .orderBy('time', descending: true)
        .where('time', isGreaterThanOrEqualTo: startStamp)
        .snapshots();
    print(transactions);
  } catch (e) {
    print(e.toString());
  }
  return transactions;
}

// A widget that gets all the previous transactions by all the users.
class AllTransactions extends StatelessWidget {
  Widget build(BuildContext context) {
    return StreamBuilder(
        initialData: "Working....",
        stream: getTransactions(),
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
                return doc["isApproved"]
                    ? ListTile(
                        title: Text(doc["user"]),
                        subtitle: Text(DateFormat.yMd()
                            .add_jm()
                            .format(doc["time"].toDate())
                            .toString()),
                        trailing: Text(
                          doc["amount"].toString(),
                          style: kAmountStyle,
                        ),
                      )
                    : Material();
              });
        });
  }
}

class RequestedTransactions extends StatelessWidget {
  Widget build(BuildContext context) {
    return StreamBuilder(
        initialData: "Working....",
        stream: getTransactions(),
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
                return doc["isApproved"] == false
                    ? RequestCard(
                        user: doc["user"],
                        amount: doc["amount"],
                        description: doc["description"],
                        category: doc["category"],
                        date: DateFormat.yMd()
                            .add_jm()
                            .format(doc["time"].toDate())
                            .toString(),
                        onPressed: () {
                          AddTransaction()
                              .approveTransaction(doc.id.toString());
                        },
                      )
                    : Material();
              });
        });
  }
}

//Loops through all the transactions returned from the getTransactions stream...
// ... and provides the sum of the transactions in a specific category in a...
//... DisplayBoxCard(a view model created in the models/widgets file).
class SumPerCategory extends StatelessWidget {
  final String category;
  SumPerCategory({@required this.category});
  @override
  Widget build(BuildContext context) {
    int sum = 0;
    return StreamBuilder(
        initialData: "Working...",
        stream: getTransactions(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text("Loading");
          }
          for (var doc in snapshot.data.docs) {
            if (doc["category"] == category && doc["isApproved"] == true) {
              sum += doc["amount"];
            }
          }
          return DisplayBoxCard(
            label: category,
            amount: sum,
          );
        });
  }
}

//Does the same as the widget above and only difference is returning a text widget instead.
class SumPerCategoryText extends StatelessWidget {
  final String category;
  SumPerCategoryText({@required this.category});
  @override
  Widget build(BuildContext context) {
    int sum = 0;
    return StreamBuilder(
        initialData: "Working...",
        stream: getTransactions(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text("Loading");
          }
          for (var doc in snapshot.data.docs) {
            if (doc["category"] == category && doc["isApproved"] == true) {
              sum += doc["amount"];
            }
          }
          return Text(
            sum.toString(),
            style: kInfoStyle,
          );
        });
  }
}

//Gets sum of transactions for a specific category done by a specific user.
class SumPerCategoryPerUser extends StatelessWidget {
  final String category;
  final String user;
  SumPerCategoryPerUser({@required this.category, @required this.user});

  @override
  Widget build(BuildContext context) {
    int sum = 0;
    return StreamBuilder(
        initialData: "Working...",
        stream: getTransactions(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text("Loading");
          }
          for (var doc in snapshot.data.docs) {
            if (doc["category"] == category &&
                doc["user"] == user &&
                doc["isApproved"] == true) {
              sum += doc["amount"];
            }
          }
          return DisplayBoxCard(
            label: category,
            amount: sum,
          );
        });
  }
}

//Returns a a Text widget with the total amount of expenditure for the current month.
class TotalMonthlyExpenses extends StatelessWidget {
  final TextStyle style;
  TotalMonthlyExpenses({this.style});

  @override
  Widget build(BuildContext context) {
    int sum = 0;
    return StreamBuilder(
        initialData: "Working...",
        stream: getTransactions(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text("Loading");
          }
          for (var doc in snapshot.data.docs) {
            if (doc["isApproved"] == true) {
              sum += doc["amount"];
            }
          }
          return Text(
            sum.toString(),
            style: style,
          );
        });
  }
}

class TotalMonthlyExpensesPerUser extends StatelessWidget {
  final String user;
  TotalMonthlyExpensesPerUser({@required this.user});

  @override
  Widget build(BuildContext context) {
    int sum = 0;
    return StreamBuilder(
        initialData: "Working...",
        stream: getTransactions(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text("Loading");
          }
          for (var doc in snapshot.data.docs) {
            if (doc["user"] == user && doc["isApproved"] == true) {
              sum += doc["amount"];
            }
          }
          return Text(
            sum.toString(),
            style: kAmountStyleXL,
          );
        });
  }
}

class TransactionsPerUser extends StatelessWidget {
  final String user;
  TransactionsPerUser({@required this.user});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        initialData: "Working....",
        stream: getTransactions(),
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
                  return ListTile(
                    title: Text(doc["user"]),
                    subtitle: Text(DateFormat.yMd()
                        .add_jm()
                        .format(doc["time"].toDate())
                        .toString()),
                    trailing: Text(
                      doc["amount"].toString(),
                      style: kAmountStyle,
                    ),
                  );
                }
                return Material();
              });
        });
  }
}
