import 'package:extrac_app/constants/constants.dart';
import 'package:extrac_app/models/widget_models.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddExpense extends StatefulWidget {
  @override
  _AddExpenseState createState() => _AddExpenseState();
}

class _AddExpenseState extends State<AddExpense> {
  @override
  Widget build(BuildContext context) {
    String categoriesDropDownValue;
    String usersDropDownValue;
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
                    decoration: InputDecoration(
                        border: InputBorder.none, hintText: 'Description'),
                  ),
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                InputField(
                  child: TextField(
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
                      print(newValue);
                    },
                    items: getCategoryItems(),
                    hintText: 'Category',
                  );
                }),
                SizedBox(
                  height: height * 0.02,
                ),
                StatefulBuilder(builder: (context, setState) {
                  return DropDownBox(
                    hintText: 'User',
                    dropDownValue: usersDropDownValue,
                    items: getUserItems(),
                    onChanged: (newValue) {
                      setState(() {
                        usersDropDownValue = newValue;
                      });
                    },
                  );
                }),
                SizedBox(
                  height: height * 0.04,
                ),
                ElevatedButton(
                  onPressed: () {
                    print('Add button pressed');
                  },
                  child: Text(
                    'ADD',
                    style: kButtonTextStyle,
                  ),
                  style: kButtonStyle,
                )
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
