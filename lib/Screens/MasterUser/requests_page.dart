import 'package:extrac_app/constants/constants.dart';
import 'package:flutter/material.dart';

class RequestsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Stack(
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  kGradientStartColor,
                  kGradientEndColor,
                ],
                stops: [0.0, 1.0],
              ),
            ),
          ),
          SizedBox(
            height: height * 0.43,
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 20.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Monthly Expenses',
                    style: kLabelStyle.copyWith(color: Colors.black),
                  ),
                  SizedBox(
                    height: height * 0.0065,
                  ),
                  Expanded(
                    child: Placeholder(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
