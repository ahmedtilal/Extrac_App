import 'package:flutter/material.dart';

const Color kMainColor = Color(0xff4f3d9b);
const Color kGradientStartColor = Color(0x80b7cfe8);
const Color kGradientEndColor = Color(0xFFC1D6E9);
const Color kSecondaryColor = Color.fromRGBO(193, 214, 233, 1);
const Color kNeumorphicColor = Color(0xFF92B6D8);

const TextStyle kLabelStyle = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 16.0,
    fontWeight: FontWeight.w500,
    color: Color(0xff3f72af));

const TextStyle kInfoStyle = TextStyle(
  fontFamily: 'Poppins',
  fontSize: 14.0,
  fontWeight: FontWeight.w300,
  color: Colors.black,
);

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

final ButtonStyle kSmallButtonStyle = ElevatedButton.styleFrom(
  onPrimary: Colors.white,
  primary: kMainColor,
  minimumSize: Size(140, 30),
  padding: EdgeInsets.symmetric(horizontal: 16),
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(10.0)),
  ),
  elevation: 10.0,
);

final ButtonStyle kSmallAltButtonStyle = ElevatedButton.styleFrom(
  onPrimary: Colors.black,
  primary: Colors.white,
  minimumSize: Size(140, 30),
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
final ButtonStyle kApproveButtonStyle = ElevatedButton.styleFrom(
  onPrimary: kSecondaryColor,
  primary: kSecondaryColor,
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

const TextStyle kInfoStyleM =
    TextStyle(color: Colors.black, fontSize: 12, fontFamily: 'Poppins');

const TextStyle kAmountStyle = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 24,
    fontWeight: FontWeight.w800,
    color: Colors.black);

const TextStyle kAmountStyleXL = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 48,
    fontWeight: FontWeight.w800,
    color: Colors.white);

const TextStyle kLabelStyleL = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 18.0,
    fontWeight: FontWeight.w700,
    color: kMainColor);

final List<String> kCategoriesList = [
  'Groceries',
  'Medicines',
  'Education',
  'Fuel',
  'Bills',
  'Stationery',
];

final kCategoriesColors = [
  Colors.blue,
  Colors.red,
  Colors.yellow,
  Colors.green,
  Colors.deepPurple,
  Colors.white,
  Colors.deepOrange
];
