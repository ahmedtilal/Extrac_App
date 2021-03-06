import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:extrac_app/Screens/adding_page.dart';
import 'package:extrac_app/Screens/stats_page.dart';
import 'package:extrac_app/Screens/users_page.dart';
import 'package:extrac_app/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../transactions_page.dart';
import 'requests_page.dart';

class Master extends StatefulWidget {
  @override
  _MasterState createState() => _MasterState();
}

class _MasterState extends State<Master> {
  int pageIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: kMainColor,
        child: Icon(
          Icons.add,
          color: Colors.white,
          size: 25,
        ),
        onPressed: () {
          setTabs(4);
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: bottomBar(pageIndex),
      body: getBody(),
    );
  }

  AnimatedBottomNavigationBar bottomBar(index) {
    List<IconData> iconItems = [
      FontAwesomeIcons.calendar,
      FontAwesomeIcons.chartBar,
      Icons.compare_arrows,
      FontAwesomeIcons.users
    ];
    return AnimatedBottomNavigationBar(
      splashColor: Colors.white,
      backgroundColor: Colors.white,
      icons: iconItems,
      activeIndex: pageIndex,
      onTap: (index) {
        setTabs(index);
      },
      activeColor: kMainColor,
      inactiveColor: Colors.grey,
      gapLocation: GapLocation.center,
      notchSmoothness: NotchSmoothness.softEdge,
      leftCornerRadius: 10,
      iconSize: 25,
      rightCornerRadius: 10,
    );
  }

  void setDefault() {
    setState(() {
      pageIndex = 0;
    });
  }

  setTabs(index) {
    setState(() {
      pageIndex = index;
    });
  }

  Widget getBody() {
    return IndexedStack(
      index: pageIndex,
      children: [
        RequestsPage(),
        StatsPage(),
        TransactionsPage(),
        UsersPage(),
        AddExpensePage(),
      ],
    );
  }
}
