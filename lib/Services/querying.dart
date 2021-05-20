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

//Queries firebase for all the transactions and returns them in a Stream.
Stream<QuerySnapshot> getTransactions(String parent) {
  var transactions;
  try {
    transactions = _fireStore
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

//Queries Firebase for all the users and returns them in a stream.
Stream<QuerySnapshot> getUsers(String parent) {
  var users;
  try {
    users = _fireStore
        .collection('users')
        .doc(parent)
        .collection('childUsers')
        .snapshots();
  } catch (e) {
    print(e.toString());
  }
  return users;
}

// A widget that gets all the previous transactions by all the users.
class AllTransactions extends StatelessWidget {
  final String parent;
  AllTransactions({@required this.parent});
  Widget build(BuildContext context) {
    return StreamBuilder(
        initialData: "Working....",
        stream: getTransactions(parent),
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

//Returns the transactions that haven't been approved.
class RequestedTransactions extends StatelessWidget {
  final String parent;
  RequestedTransactions({@required this.parent});
  Widget build(BuildContext context) {
    return StreamBuilder(
        initialData: "Working....",
        stream: getTransactions(parent),
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
                          AddTransaction(parentUserId: parent)
                              .approveTransaction(doc.id.toString(), parent);
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
  final String parent;
  final String category;
  SumPerCategory({@required this.category, @required this.parent});
  @override
  Widget build(BuildContext context) {
    int sum = 0;
    return StreamBuilder(
        initialData: "Working...",
        stream: getTransactions(parent),
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
  final String parent;
  final String category;
  SumPerCategoryText({@required this.category, @required this.parent});
  @override
  Widget build(BuildContext context) {
    int sum = 0;
    return StreamBuilder(
        initialData: "Working...",
        stream: getTransactions(parent),
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
  final String parent;
  final String category;
  final String user;
  SumPerCategoryPerUser(
      {@required this.category, @required this.user, @required this.parent});

  @override
  Widget build(BuildContext context) {
    int sum = 0;
    return StreamBuilder(
        initialData: "Working...",
        stream: getTransactions(parent),
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

//Takes in the transactions stream and returns a text widget with the sum of the transactions
//made in the current month.
//only puts into account approved transactions (where isApproved = true).
class TotalMonthlyExpenses extends StatelessWidget {
  final String parent;
  final TextStyle style;
  TotalMonthlyExpenses({this.style, @required this.parent});

  @override
  Widget build(BuildContext context) {
    int sum = 0;
    return StreamBuilder(
        initialData: "Working...",
        stream: getTransactions(parent),
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

//Takes in the transactions stream and returns a text widget with the sum of the transactions
//made in the current month by the current user.
//only puts into account approved transactions (where isApproved = true).
class TotalMonthlyExpensesPerUser extends StatelessWidget {
  final String parent;
  final String user;
  final TextStyle style;

  TotalMonthlyExpensesPerUser(
      {@required this.parent, @required this.user, this.style});
  @override
  Widget build(BuildContext context) {
    int sum = 0;
    return StreamBuilder(
        initialData: "Working...",
        stream: getTransactions(parent),
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
            style: style,
          );
        });
  }
}

//Returns a ListView that has all the transactions made by the current user logged in.
//only shows transactions that are approved (where isApproved = true).
class TransactionsPerUser extends StatelessWidget {
  final String parent;
  final String user;
  TransactionsPerUser({@required this.parent, @required this.user});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        initialData: "Working....",
        stream: getTransactions(parent),
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

//Returns a ListView of all the users with their phone numbers and their total expenditure this month.
class UsersList extends StatelessWidget {
  final String parent;
  UsersList({@required this.parent});
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        initialData: "Working....",
        stream: getUsers(parent),
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
                return Card(
                  elevation: 3,
                  child: ListTile(
                      title: Text(doc["name"]),
                      subtitle: Text("number: ${doc["phoneNumber"]}"),
                      trailing: TotalMonthlyExpensesPerUser(
                        parent: parent,
                        user: doc["name"],
                        style: kAmountStyle,
                      )),
                );
              });
        });
  }
}
