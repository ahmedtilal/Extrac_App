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

//This queries our transactions from the database, fetching the transactions done in the current month,
// according to each category, and providing the sum of them,
// then displays them in a card widget that was already iterated in the models/widgets file.
class CategoryQuery extends StatelessWidget {
  final fireStore = FirebaseFirestore.instance;
  final String inCategory;
  CategoryQuery({@required this.inCategory});

  Future<int> getCatTotal() async {
    int sum = 0;
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

class TotalMonthlyExpenditure extends StatelessWidget {
  final fireStore = FirebaseFirestore.instance;
  Future<int> getMonthlyTotal() async {
    int sum = 0;
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
