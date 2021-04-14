import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:extrac_app/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'requests_page.dart';

class Master extends StatefulWidget {
  @override
  _MasterState createState() => _MasterState();
}

class _MasterState extends State<Master> {
  int pageIndex;
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
      Icons.settings,
      FontAwesomeIcons.user
    ];
    return AnimatedBottomNavigationBar(
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
        Center(
          child: Text('Stats Page'),
        ),
        Center(
          child: Text('Settings Page'),
        ),
        Center(
          child: Text('Profile Page'),
        ),
        Center(
          child: Text('Add Expense Page'),
        ),
      ],
    );
  }
}
