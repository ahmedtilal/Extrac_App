import 'package:flutter/material.dart';

const Color kMainColor = Color(0xff4f3d9b);
const Color kGradientStartColor = Color(0x80b7cfe8);
const Color kGradientEndColor = Color(0xffB7CFE8);

const TextStyle kLabelStyle = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 16.0,
    fontWeight: FontWeight.w500,
    color: Color(0xff3f72af));

final ButtonStyle kButtonStyle = ElevatedButton.styleFrom(
  onPrimary: Colors.white,
  primary: kMainColor,
  minimumSize: Size(275, 60),
  padding: EdgeInsets.symmetric(horizontal: 16),
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(10.0)),
  ),
  elevation: 10.0,
);

final ButtonStyle kAltButtonStyle = ElevatedButton.styleFrom(
  onPrimary: Colors.black,
  primary: Colors.white,
  minimumSize: Size(275, 60),
  padding: EdgeInsets.symmetric(horizontal: 16),
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(10.0)),
  ),
  elevation: 10.0,
);

const TextStyle kAltButtonTextStyle = TextStyle(
  color: Colors.black,
  fontSize: 24,
  letterSpacing: 1.5,
);

const TextStyle kButtonTextStyle = TextStyle(
  color: Colors.white,
  fontSize: 24,
  letterSpacing: 1.5,
);
