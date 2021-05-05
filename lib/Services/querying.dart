import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:extrac_app/constants/constants.dart';
import 'package:extrac_app/models/widget_models.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

int month = DateTime.now().month;
String year = DateTime.now().year.toString();
DateTime startDate = DateFormat('MM/yyyy').parse('0$month/$year');
Timestamp startStamp = Timestamp.fromDate(startDate);
final fireStore = FirebaseFirestore.instance;

//This queries our transactions from the database, fetching the transactions done in the current month,
// according to each category, and providing the sum of them,
// then displays them in a card widget that was already iterated in the models/widgets file.
class CategoryQuery extends StatelessWidget {
  final String inCategory;
  CategoryQuery({@required this.inCategory});

  Future<int> getCatTotal() async {
    int sum = 0;
    try {
      await fireStore
          .collection('transactions')
          .where('category', isEqualTo: inCategory)
          .orderBy('time', descending: true)
          .where('time', isGreaterThanOrEqualTo: startStamp)
          .get()
          .then((QuerySnapshot querySnapshot) {
        querySnapshot.docs.forEach((doc) {
          print(doc["amount"]);
          sum += doc["amount"];
          print(sum);
        });
      });
    } catch (e) {
      print(e.toString());
    }

    return sum;
  }

  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getCatTotal(),
        builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
          if (!snapshot.hasData) {
            return CircularProgressIndicator();
          }
          return DisplayBoxCard(
            label: inCategory,
            amount: snapshot.data,
          );
        });
  }
}

//Returns a a Text widget with the total amount of expenditure for the current month.
//Querying Firestore for all the transactions that happened this month, and ordering them by timeStamp.
class TotalMonthlyExpenditure extends StatelessWidget {
  Future<int> getMonthlyTotal() async {
    int sum = 0;
    try {
      await fireStore
          .collection('transactions')
          .orderBy('time', descending: true)
          .where('time', isGreaterThanOrEqualTo: startStamp)
          .get()
          .then((QuerySnapshot querySnapshot) {
        querySnapshot.docs.forEach((doc) {
          print(doc["amount"]);
          sum += doc["amount"];
          print(sum);
        });
      });
    } catch (e) {
      print(e.toString());
    }

    return sum;
  }

  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getMonthlyTotal(),
        builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
          if (!snapshot.hasData) {
            return CircularProgressIndicator();
          }
          return Text(
            snapshot.data.toString(),
            style: kAmountStyleXL,
          );
        });
  }
}

class PreviousTransactions extends StatelessWidget {
  const PreviousTransactions({Key key}) : super(key: key);

  Future<List<ListTile>> getPreviousTransactions() async {
    List<ListTile> transactions = [];
    try {
      await fireStore
          .collection('transactions')
          .orderBy('time', descending: true)
          .where('time', isGreaterThanOrEqualTo: startStamp)
          .get()
          .then((QuerySnapshot querySnapshot) {
        querySnapshot.docs.forEach((doc) {
          transactions.add(ListTile(
            title: Text(doc["user"]),
            subtitle: Text(DateFormat.yMd()
                .add_jm()
                .format(doc["time"].toDate())
                .toString()),
            trailing: Text(
              doc["amount"].toString(),
              style: kAmountStyle,
            ),
          ));
          print(transactions);
        });
      });
      return transactions;
    } catch (e) {
      print(e.toString());
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<ListTile>>(
        future: getPreviousTransactions(),
        builder:
            (BuildContext context, AsyncSnapshot<List<ListTile>> snapshot) {
          if (!snapshot.hasData) {
            return CircularProgressIndicator();
          }
          return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) {
                return snapshot.data[index];
              });
        });
  }
}
