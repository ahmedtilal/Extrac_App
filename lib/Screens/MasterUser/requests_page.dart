import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:extrac_app/Services/querying.dart';
import 'package:extrac_app/constants/constants.dart';
import 'package:extrac_app/models/pieChartView.dart';
import 'package:extrac_app/models/widget_models.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RequestsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var userDoc = Provider.of<DocumentSnapshot>(context);
    bool isMaster = true;
    String parentUserId;
    if (userDoc != null) {
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
          decoration: BoxDecoration(
            color: kSecondaryColor,
          ),
        ),
        SizedBox(
          height: height * 0.29,
          child: Padding(
            padding: EdgeInsets.only(
              left: 10,
              top: 30,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    'Expenses',
                    style: kLabelStyle.copyWith(color: Colors.black),
                  ),
                ),
                SizedBox(
                  height: height * 0.03,
                ),
                Expanded(
                  child: CategoriesListWithAmounts(
                    parent: parentUserId,
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          height: height * 0.6,
          width: width * 1,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40),
                topRight: Radius.circular(40),
              ),
              color: Colors.white,
            ),
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Requests',
                  style: kLabelStyle.copyWith(color: Colors.black),
                ),
                SizedBox(
                  height: 15,
                ),
                Expanded(
                    child: RequestedTransactions(
                  parent: parentUserId,
                )),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

Future<List<Category>> categoriesList(String parent) async {
  List<Category> list = [];
  for (int i = 0; i < kCategoriesList.length; i++) {
    int amount = await getAmount(parent, kCategoriesList[i]);
    list.add(Category(kCategoriesList[i], amount: amount));
  }
  print(list);
  return list;
}

List<Category> testingList = [
  Category("test", amount: 800),
  Category("test2", amount: 500),
  Category("test3", amount: 100),
  Category("test4", amount: 200),
  Category("test5", amount: 300),
];
