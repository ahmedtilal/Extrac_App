import 'package:extrac_app/Services/authentication.dart';
import 'package:extrac_app/constants/constants.dart';
import 'package:extrac_app/models/widget_models.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
              )
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
            child: Column(
              children: [
                Text(
                  'Transactions',
                  style: kLabelStyle.copyWith(color: Colors.black),
                ),
                SizedBox(
                  height: 15,
                ),
                //TODO provide this TransactionDisplay using a ListviewBuilder with dividers.
                TransactionDisplay(
                  width: width,
                  user: 'Tahir',
                  date: '21/04',
                  time: '15:30',
                  amount: 3700,
                ),
                Divider(
                  color: Colors.black,
                  indent: width * 0.05,
                  endIndent: width * 0.05,
                  thickness: 0.6,
                ),
                ElevatedButton(
                  onPressed: () {
                    context.read<AuthenticationService>().signOut();
                  },
                  child: Text(
                    'LOGOUT',
                    style: kButtonTextStyle,
                  ),
                  style: kButtonStyle,
                ),
                //TODO Change later as this is only for testing purposes.
              ],
            ),
          ),
        ),
      ],
    );
  }
}
