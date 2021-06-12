import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:extrac_app/Services/firestore_write.dart';
import 'package:extrac_app/constants/constants.dart';
import 'package:extrac_app/models/widget_models.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddExpensePage extends StatefulWidget {
  @override
  _AddExpensePageState createState() => _AddExpensePageState();
}

class _AddExpensePageState extends State<AddExpensePage> {
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
    TextEditingController amountController = TextEditingController();
    TextEditingController descriptionController = TextEditingController();
    String categoriesDropDownValue;

    final height = MediaQuery.of(context).size.height;
    return Stack(
      children: [
        Container(
          padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
          height: double.infinity,
          width: double.infinity,
          color: kSecondaryColor,
          child: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            child: Column(
              children: [
                Text(
                  'Add Expense',
                  style: kLabelStyleL,
                ),
                SizedBox(
                  height: height * 0.1,
                ),
                InputField(
                  child: TextField(
                    controller: descriptionController,
                    decoration: InputDecoration(
                        border: InputBorder.none, hintText: 'Description'),
                  ),
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                InputField(
                  child: TextField(
                    controller: amountController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        border: InputBorder.none, hintText: 'Amount'),
                  ),
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                StatefulBuilder(builder: (context, setState) {
                  return DropDownBox(
                    dropDownValue: categoriesDropDownValue,
                    onChanged: (String newValue) {
                      setState(() {
                        categoriesDropDownValue = newValue;
                      });
                    },
                    items: getCategoryItems(),
                    hintText: 'Category',
                  );
                }),
                SizedBox(
                  height: height * 0.02,
                ),
                SizedBox(
                  height: height * 0.04,
                ),
                ElevatedButton(
                  onPressed: () async {
                    await AddTransaction(
                            category: categoriesDropDownValue,
                            user: user,
                            description: descriptionController.text,
                            amount: int.parse(amountController.text),
                            isApproved: isMaster,
                            parentUserId: parentUserId)
                        .addTransaction();
                    Navigator.pushNamed(context, 'home');
                  },
                  child: Text(
                    'ADD',
                    style: kButtonTextStyle,
                  ),
                  style: kButtonStyle,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

List<DropdownMenuItem<String>> getCategoryItems() {
  List<DropdownMenuItem<String>> itemsList = [];
  for (var i = 0; i < kCategoriesList.length; i++) {
    itemsList.add(
      DropdownMenuItem(
        value: kCategoriesList[i],
        child: Text(kCategoriesList[i]),
      ),
    );
  }
  return itemsList;
}
