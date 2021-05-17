import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:extrac_app/Services/querying.dart';
import 'package:extrac_app/constants/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StatsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var userDoc = Provider.of<DocumentSnapshot>(context);
    String user = 'Waiting on user name';
    if (userDoc != null) {
      user = userDoc.data()["name"];
    }
    bool isMaster = false;
    if (userDoc != null) {
      isMaster = userDoc.data()["isMaster"];
    }
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        Container(
          height: double.infinity,
          width: double.infinity,
          color: kMainColor,
          padding: EdgeInsets.symmetric(
            vertical: 35,
          ),
          child: Column(
            children: [
              Text(
                'Total Expenditure This Month',
                style: kLabelStyle.copyWith(color: Colors.white),
              ),
              SizedBox(
                height: 20,
              ),
              isMaster
                  ? TotalMonthlyExpenses(
                      style: kAmountStyleXL,
                    )
                  : TotalMonthlyExpensesPerUser(
                      user: user,
                      style: kAmountStyleXL,
                    ),
            ],
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          width: width * 1,
          height: height * 0.65,
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(30),
                  topLeft: Radius.circular(30),
                )),
            child: SingleChildScrollView(
              child: isMaster
                  ? MasterUserColumn()
                  : Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SumPerCategoryPerUser(
                              category: 'Medicines',
                              user: user,
                            ),
                            SumPerCategoryPerUser(
                              category: 'Bills',
                              user: user,
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SumPerCategoryPerUser(
                              category: 'Education',
                              user: user,
                            ),
                            SumPerCategoryPerUser(
                              category: 'Groceries',
                              user: user,
                            ),
                          ],
                        ),
                      ],
                    ),
            ),
          ),
        ),
      ],
    );
  }
}

class MasterUserColumn extends StatelessWidget {
  const MasterUserColumn({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SumPerCategory(
              category: 'Medicines',
            ),
            SumPerCategory(
              category: 'Bills',
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SumPerCategory(category: 'Education'),
            SumPerCategory(category: 'Groceries'),
          ],
        ),
      ],
    );
  }
}
