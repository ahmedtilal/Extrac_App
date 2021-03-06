import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:extrac_app/Services/authentication.dart';
import 'package:extrac_app/Services/querying.dart';
import 'package:extrac_app/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';

class UsersPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var userDoc = Provider.of<DocumentSnapshot>(context);
    String user = 'Waiting on user name';
    bool isMaster = false;
    String parentUserId;
    if (userDoc != null) {
      user = userDoc["name"];
      isMaster = userDoc["isMaster"];
      isMaster ? parentUserId = userDoc.id : parentUserId = userDoc["parent"];
    }
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
                "Current User:",
                style: kLabelStyle.copyWith(color: Colors.white),
              ),
              SizedBox(
                height: height * 0.02,
              ),
              Text(
                user,
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
              vertical: 15,
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
                isMaster ? Text('Users:') : Material(),
                isMaster
                    ? Expanded(
                        child: UsersList(
                        parent: parentUserId,
                      ))
                    : SizedBox(
                        height: 10,
                      ),
                SizedBox(
                  height: 20,
                ),
                isMaster
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              Share.share(
                                  "Use this code to join my household account in Extrac App:\n"
                                  "$parentUserId");
                            },
                            child: Text(
                              "SHARE INVITE CODE",
                            ),
                            style: kSmallAltButtonStyle,
                          ),
                          ElevatedButton(
                            onPressed: () {
                              Provider.of<AuthenticationService>(context,
                                      listen: false)
                                  .signOut();
                            },
                            child: Text(
                              'SIGN OUT',
                            ),
                            style: kSmallButtonStyle,
                          ),
                        ],
                      )
                    : Center(
                        child: ElevatedButton(
                          onPressed: () {
                            Provider.of<AuthenticationService>(context,
                                    listen: false)
                                .signOut();
                          },
                          child: Text(
                            'SIGN OUT',
                          ),
                          style: kSmallButtonStyle,
                        ),
                      ),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
