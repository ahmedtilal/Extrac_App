import 'dart:ui';

import 'package:extrac_app/constants/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// Text on top of Input fields, one that says username, password, ...etc
class TextFieldLabel extends StatelessWidget {
  final String text;
  TextFieldLabel({this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontFamily: 'Poppins',
        fontSize: 14.0,
        fontWeight: FontWeight.w400,
        color: Color(0xff3F72AF),
      ),
    );
  }
}

//Textfield wrappers that give it the white look.
class InputField extends StatelessWidget {
  final Widget child;
  InputField({this.child});
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.only(left: 15, right: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Colors.white,
      ),
      height: 60.0,
      child: child,
    );
  }
}

//Card used to view requests in Requests page.
class RequestCard extends StatelessWidget {
  RequestCard(
      {this.user,
      this.category,
      this.date,
      this.description,
      this.time,
      this.amount});
  final String category;
  final String user;
  final String description;
  final String date;
  final String time;
  final int amount;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white70,
      elevation: 1,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          width: double.infinity,
          height: 150,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '$user',
                      style: kInfoStyle.copyWith(color: kMainColor),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      '$description',
                      style: kInfoStyleM,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Category: $category',
                      style: kInfoStyleM,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      '$amount',
                      style: kAmountStyle,
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '$date \n at $time',
                      style: kInfoStyleM,
                    ),
                    ElevatedButton(
                      style: kApproveButtonStyle,
                      onPressed: () {
                        print('Button pressed.');
                      },
                      child: Text(
                        'Approve',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

//Column which displays all the category rows along with the amounts against them.
class CategoriesList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 3,
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: getCatList(),
          ),
          SizedBox(
            width: 10,
          ),
          Column(
            children: getAmounts(),
          ),
        ],
      ),
    );
  }
}

//Row on which the category color and name are displayed.
class CategoryRow extends StatelessWidget {
  CategoryRow({
    this.text,
    this.color,
  });
  final Color color;
  final String text;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 10,
          width: 10,
          decoration: BoxDecoration(shape: BoxShape.circle, color: color),
        ),
        SizedBox(
          width: 20,
        ),
        Text(
          text,
          style: kInfoStyle,
        ),
      ],
    );
  }
}

//Function that loops through our Categories list and colours to give back a list of rows displayed next to the pie chart.
List<CategoryRow> getCatList() {
  List<CategoryRow> categoryRowList = [];
  for (var i = 0; i < kCategoriesList.length; i++) {
    categoryRowList.add(
      CategoryRow(
        text: kCategoriesList[i].name,
        color: kCategoriesColors[i],
      ),
    );
  }
  return categoryRowList;
}

//Function that adds amounts of all categories to come up with the grand total shown in the centre of the pie chart.
List<Text> getAmounts() {
  List<Text> amountsList = [];
  for (var i = 0; i < kCategoriesList.length; i++) {
    amountsList.add(
      Text(
        kCategoriesList[i].amount.toInt().toString(),
        style: kInfoStyle,
      ),
    );
  }
  return amountsList;
}

//Cards that display data of categories in stats page.
class DisplayBoxCard extends StatelessWidget {
  final String label;
  final int amount;
  DisplayBoxCard({this.label, this.amount});
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
        color: Colors.white70,
        elevation: 1,
        child: Container(
          padding: EdgeInsets.only(
            bottom: 40,
            left: 20,
            right: 20,
            top: 15,
          ),
          child: Column(
            children: [
              Text(
                '$label',
                style: kLabelStyleL,
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                '$amount \n SDG',
                style: kAmountStyle.copyWith(fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

//Cards used in transactions page.
class TransactionDisplay extends StatelessWidget {
  const TransactionDisplay({
    Key key,
    @required this.width,
    @required this.user,
    @required this.amount,
    @required this.date,
    @required this.time,
  }) : super(key: key);

  final double width;
  final String user;
  final String date;
  final String time;
  final int amount;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Icon(
              Icons.monetization_on,
              color: Colors.grey,
              size: 25,
            ),
            SizedBox(
              width: width * 0.05,
            ),
            RichText(
              maxLines: 2,
              text: TextSpan(children: [
                TextSpan(
                  text: '$user\n',
                  style: kInfoStyle,
                ),
                TextSpan(
                  text: '$date @ $time',
                  style: kInfoStyleM,
                )
              ]),
            ),
          ],
        ),
        Text(
          '$amount',
          style: kAmountStyle,
        ),
      ],
    );
  }
}

//Widget used to build drop down menus according to the application's theme for user inputs.
class DropDownBox extends StatelessWidget {
  const DropDownBox({
    @required this.dropDownValue,
    @required this.onChanged,
    @required this.items,
    @required this.hintText,
  });
  final Function onChanged;
  final String dropDownValue;
  final List items;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return FormField(builder: (context) {
      return InputField(
        child: InputDecorator(
          decoration: InputDecoration(border: InputBorder.none),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              hint: Text(hintText),
              isDense: true,
              value: dropDownValue,
              elevation: 10,
              icon: Icon(Icons.arrow_downward),
              iconSize: 20,
              onChanged: onChanged,
              items: items,
            ),
          ),
        ),
      );
    });
  }
}
