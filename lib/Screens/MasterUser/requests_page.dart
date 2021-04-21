import 'package:extrac_app/constants/constants.dart';
import 'package:extrac_app/models/pieChartView.dart';
import 'package:extrac_app/models/widget_models.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RequestsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
            color: kSecondaryColor,
          ),
        ),
        SizedBox(
          height: height * 0.29,
          child: Padding(
            padding: EdgeInsets.only(
              left: 10,
              top: 30,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    'Expenses',
                    style: kLabelStyle.copyWith(color: Colors.black),
                  ),
                ),
                SizedBox(
                  height: height * 0.03,
                ),
                Expanded(
                  child: Row(
                    children: [
                      //TODO inject data to these charts from backend.
                      CategoriesList(),
                      PieChartView(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          height: height * 0.58,
          width: width * 1,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40),
                topRight: Radius.circular(40),
              ),
              color: Colors.white,
            ),
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Requests',
                  style: kLabelStyle.copyWith(color: Colors.black),
                ),
                SizedBox(
                  height: 15,
                ),
                //TODO provide those requests cards using a ListViewBuilder and inject data from backend.
                RequestCard(
                  user: 'Tahir',
                  description: 'Requesting money for uni to last him 7 days.',
                  date: '18/04/2021',
                  time: '19:40',
                  category: 'Education',
                  amount: 5700,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
