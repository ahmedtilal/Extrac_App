import 'package:extrac_app/Services/querying.dart';
import 'package:extrac_app/constants/constants.dart';
import 'package:flutter/material.dart';

class Transactions extends StatelessWidget {
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
          padding: EdgeInsets.symmetric(vertical: 35),
          child: Column(
            children: [
              Text(
                'Household Expenditure',
                style: kLabelStyle.copyWith(color: Colors.white),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                '67,820 SDG',
                style: kAmountStyleXL,
              ),
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
          height: height * 0.65,
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
            child: PreviousTransactions(),
          ),
        ),
      ],
    );
  }
}
