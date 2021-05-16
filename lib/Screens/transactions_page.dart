import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:extrac_app/Services/querying.dart';
import 'package:extrac_app/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TransactionsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var userDoc = Provider.of<DocumentSnapshot>(context);
    String user = userDoc.data()["name"];
    bool isMaster = userDoc.data()["isMaster"];
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        Container(
          height: double.infinity,
          width: double.infinity,
          color: kMainColor,
          padding: EdgeInsets.symmetric(vertical: 35),
          child: Column(
            children: [
              Text(
                'Monthly Expenditure',
                style: kLabelStyle.copyWith(color: Colors.white),
              ),
              SizedBox(
                height: 20,
              ),
              isMaster
                  ? TotalMonthlyExpenses(
                      style: kAmountStyleXL,
                    )
                  : TotalMonthlyExpensesPerUser(user: user),
              SizedBox(
                height: 20.0,
              ),
              Text(
                'Transactions',
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
        Positioned(
          bottom: 0,
          height: height * 0.62,
          width: width * 1,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
            ),
            child: isMaster
                ? AllTransactions()
                : TransactionsPerUser(
                    user: user,
                  ),
          ),
        ),
      ],
    );
  }
}
