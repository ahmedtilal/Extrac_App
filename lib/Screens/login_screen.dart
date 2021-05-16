import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:extrac_app/Services/authentication.dart';
import 'package:extrac_app/constants/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';

class LogIn extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final bool connecting =
        Provider.of<AuthenticationService>(context).connecting;
    return Scaffold(
      backgroundColor: kSecondaryColor,
      body: SafeArea(
        child: ModalProgressHUD(
          inAsyncCall: connecting,
          opacity: 0.05,
          child: Container(
            height: double.infinity,
            child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              padding: EdgeInsets.symmetric(
                horizontal: 20.0,
                vertical: 10.0,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Image.asset(
                      'lib/assets/logo.png',
                      height: 150.0,
                      width: 75.0,
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Username',
                        style: kLabelStyle,
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.white,
                        ),
                        height: 60.0,
                        child: TextField(
                          controller: emailController,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            prefixIcon: Icon(Icons.account_box_rounded),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        'Password',
                        style: kLabelStyle,
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.white,
                        ),
                        height: 60.0,
                        child: TextField(
                          controller: passwordController,
                          obscureText: true,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            prefixIcon: Icon(Icons.lock),
                          ),
                        ),
                      ),
                      Container(
                        alignment: Alignment.topRight,
                        child: TextButton(
                          onPressed: () {
                            print('Forgot Password?');
                          },
                          child: Text('Forgot Password?', style: kLabelStyle),
                        ),
                      ),
                      SizedBox(
                        height: 20.0,
                      )
                    ],
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      await context.read<AuthenticationService>().signIn(
                          email: emailController.text,
                          password: passwordController.text);
                      context.read<DocumentSnapshot>();
                    },
                    style: kButtonStyle,
                    child: Text('LOGIN', style: kButtonTextStyle),
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  Text('- or -'),
                  Text('Sign in with'),
                  SizedBox(height: 20.0),
                  GestureDetector(
                    child: Container(
                      height: 60.0,
                      width: 60.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: kSecondaryColor,
                        image: DecorationImage(
                          image: AssetImage('lib/assets/google_logo.png'),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account? ",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                            color: Colors.black),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, 'signUp');
                        },
                        child: Text(
                          "Sign Up.",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.red),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
