import 'package:extrac_app/Services/querying.dart';
import 'package:extrac_app/constants/constants.dart';
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
              TotalMonthlyExpenditure(),
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
                      CategoryQuery(inCategory: 'Medicines'),
                      CategoryQuery(inCategory: 'Bills')
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CategoryQuery(inCategory: 'Education'),
                      CategoryQuery(inCategory: 'Groceries'),
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
