import 'dart:ui';

import 'package:flutter/material.dart';

// Text on top of Input fields, one that says username, password, ...etc
class TextFieldLabel extends StatelessWidget {
  final String text;
  TextFieldLabel({this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontFamily: 'Poppins',
        fontSize: 14.0,
        fontWeight: FontWeight.w400,
        color: Color(0xff3F72AF),
      ),
    );
  }
}

//Textfield wrappers that give it the white look.
class InputField extends StatelessWidget {
  final Widget child;
  InputField({this.child});
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.only(left: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Colors.white,
      ),
      height: 60.0,
      child: child,
    );
  }
}
