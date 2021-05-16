import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:extrac_app/Screens/adding_page.dart';
import 'package:extrac_app/Screens/stats_page.dart';
import 'package:extrac_app/Screens/transactions_page.dart';
import 'package:extrac_app/Screens/users_page.dart';
import 'package:extrac_app/constants/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Child extends StatefulWidget {
  const Child({Key key}) : super(key: key);

  @override
  _ChildState createState() => _ChildState();
}

class _ChildState extends State<Child> {
  int pageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: bottomBar(pageIndex),
      body: getBody(),
    );
  }

  AnimatedBottomNavigationBar bottomBar(index) {
    List<IconData> iconItems = [
      FontAwesomeIcons.chartBar,
      Icons.add,
      Icons.history,
      FontAwesomeIcons.user
    ];

    return AnimatedBottomNavigationBar(
      gapLocation: GapLocation.none,
      splashColor: Colors.white,
      icons: iconItems,
      leftCornerRadius: 30,
      rightCornerRadius: 30,
      activeIndex: pageIndex,
      onTap: (index) {
        setTabs(index);
      },
      activeColor: kMainColor,
      inactiveColor: Colors.grey,
      iconSize: 25,
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
        StatsPage(),
        AddExpensePage(),
        TransactionsPage(),
        UsersPage(),
      ],
    );
  }
}

//Container(
//         width: MediaQuery.of(context).size.width,
//         height: MediaQuery.of(context).size.height,
//         color: Colors.amberAccent,
//         child: Center(
//           child: ElevatedButton(
//             onPressed: () {
//               CurrentUserInfo().currentUser();
//             },
//             child: Text('Test'),
//           ),
//         ),
//       ),
