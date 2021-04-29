import 'package:extrac_app/constants/constants.dart';
import 'package:extrac_app/models/widget_models.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Stats extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
              Text(
                '124,564 SDG',
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
              child: Column(
                children: [
                  //TODO implement data into cards.
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      DisplayBoxCard(
                        label: 'Medicine',
                        amount: 32540,
                      ),
                      DisplayBoxCard(
                        label: 'Bills',
                        amount: 17850,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      DisplayBoxCard(
                        label: 'Education',
                        amount: 25400,
                      ),
                      DisplayBoxCard(
                        label: 'Groceries',
                        amount: 28500,
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
