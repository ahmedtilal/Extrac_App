import 'package:extrac_app/constants/constants.dart';
import 'package:flutter/material.dart';

class UsersPage extends StatelessWidget {
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
                "Master's Expenditure This Month",
                style: kLabelStyle.copyWith(color: Colors.white),
              ),
              SizedBox(
                height: height * 0.02,
              ),
              Text(
                '25,300 SDG',
                style: kAmountStyleXL,
              ),
            ],
          ),
        ),
        Positioned(
          height: height * 0.65,
          width: width * 1,
          bottom: 0,
          child: Container(
            padding: EdgeInsets.symmetric(
              vertical: 30,
              horizontal: 20,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(30),
                topLeft: Radius.circular(30),
              ),
            ),
            child: Column(
              children: [
                Card(
                  elevation: 1,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    height: 60,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white70,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Tahir',
                          style: kLabelStyle,
                        ),
                        Text(
                          '18400',
                          style: kAmountStyle,
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
