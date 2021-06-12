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
    bool isMaster = false;
    String parentUserId;
    if (userDoc != null) {
      user = userDoc["name"];
      isMaster = userDoc["isMaster"];
      isMaster ? parentUserId = userDoc.id : parentUserId = userDoc["parent"];
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
                      parent: parentUserId,
                      style: kAmountStyleXL,
                    )
                  : TotalMonthlyExpensesPerUser(
                      parent: parentUserId,
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
                              parent: parentUserId,
                              category: 'Medicines',
                              user: user,
                            ),
                            SumPerCategoryPerUser(
                              parent: parentUserId,
                              category: 'Bills',
                              user: user,
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SumPerCategoryPerUser(
                              parent: parentUserId,
                              category: 'Education',
                              user: user,
                            ),
                            SumPerCategoryPerUser(
                              parent: parentUserId,
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
    var userDoc = Provider.of<DocumentSnapshot>(context);
    bool isMaster = true;
    String parentUserId;
    if (userDoc != null) {
      isMaster = userDoc["isMaster"];
      isMaster ? parentUserId = userDoc.id : parentUserId = userDoc["parent"];
    }
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SumPerCategory(
              parent: parentUserId,
              category: 'Medicines',
            ),
            SumPerCategory(
              parent: parentUserId,
              category: 'Bills',
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SumPerCategory(parent: parentUserId, category: 'Education'),
            SumPerCategory(parent: parentUserId, category: 'Groceries'),
          ],
        ),
      ],
    );
  }
}
