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
    String user = userDoc.data()["name"];
    bool isMaster = userDoc.data()["isMaster"];
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
                    ).addTransaction();
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
        value: kCategoriesList[i].name,
        child: Text(kCategoriesList[i].name),
      ),
    );
  }
  return itemsList;
}

List<DropdownMenuItem<String>> getUserItems() {
  List<DropdownMenuItem<String>> usersList = [];
  for (var i = 0; i < kCategoriesList.length; i++) {
    usersList.add(
      DropdownMenuItem(
        value: kUsersList[i],
        child: Text(kUsersList[i]),
      ),
    );
  }
  return usersList;
}