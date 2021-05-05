import 'package:extrac_app/Services/authentication.dart';
import 'package:extrac_app/Services/firestore_write.dart';
import 'package:extrac_app/constants/constants.dart';
import 'package:extrac_app/models/widget_models.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';

class SignUp extends StatefulWidget {
  // final TextEditingController emailController = TextEditingController();
  // final TextEditingController passwordController = TextEditingController();
  // final TextEditingController nameController = TextEditingController();
  // final TextEditingController confirmedPasswordController =
  // TextEditingController();
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  String name;
  String email;
  String phoneNumber;
  String password;

  @override
  Widget build(BuildContext context) {
    final bool connecting =
        Provider.of<AuthenticationService>(context).connecting;
    return ModalProgressHUD(
      inAsyncCall: connecting,
      opacity: 0.1,
      child: Scaffold(
        backgroundColor: kSecondaryColor,
        appBar: AppBar(
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
          ),
          centerTitle: true,
          title: Text(
            'Extrac',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          backgroundColor: kMainColor,
        ),
        body: Container(
          height: double.infinity,
          child: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            padding: EdgeInsets.symmetric(
              horizontal: 20.0,
              vertical: 20,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Image.asset(
                    'lib/assets/logo.png',
                    width: 75.0,
                    height: 130.0,
                  ),
                ),
                SizedBox(
                  height: 15.0,
                ),
                Text(
                  'Please fill in the fields below :',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                InputField(
                  child: TextField(
                    onChanged: (value) {
                      setState(() {
                        name = value;
                      });
                    },
                    decoration: InputDecoration(
                      hintText: 'Name',
                      border: InputBorder.none,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                InputField(
                  child: TextField(
                    onChanged: (value) {
                      setState(() {
                        email = value;
                      });
                    },
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Email Address',
                    ),
                    keyboardType: TextInputType.emailAddress,
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                InputField(
                  child: TextField(
                    onChanged: (value) {
                      setState(() {
                        phoneNumber = value;
                      });
                    },
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Phone Number',
                    ),
                    keyboardType: TextInputType.phone,
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                InputField(
                  child: TextField(
                    onChanged: (value) {
                      setState(() {
                        password = value;
                      });
                    },
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Password',
                    ),
                    obscureText: true,
                  ),
                ),
                // SizedBox(
                //   height: 10.0,
                // ),
                // InputField(
                //   child: TextField(
                //     onChanged: (value) {
                //       setState(() {
                //         confirmedPassword = value;
                //       });
                //     },
                //     decoration: InputDecoration(
                //         hintText: 'Confirm Password', border: InputBorder.none),
                //     obscureText: true,
                //   ),
                // ),
                SizedBox(
                  height: 15.0,
                ),
                Center(
                  child: AddUser(
                    email: email,
                    password: password,
                    name: name,
                    phoneNumber: phoneNumber,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
