import 'package:contactly/home_page.dart';
import 'package:contactly/login_page.dart';
import 'package:contactly/register_page.dart';
import 'package:contactly/register_success_page.dart';
import 'package:flutter/material.dart';

import './constants.dart';

void main() => runApp(ContactlyApp());

class ContactlyApp extends StatelessWidget {
  // This widget is the root of your application.

  final _routes = <String, WidgetBuilder>{
    loginPageTag: (context) => LoginPage(),
    homePageTag: (context) => HomePage(),
    registerPageTag: (context) => RegisterPage(),
    registerSuccessTag: (context) => RegisterSuccessPage()
  };

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appTitle,
      theme: ThemeData(
        primaryColor: appBgColor,
      ),
      home: LoginPage(),
      routes: _routes,
    );
  }
}

// https://www.appcoda.com/flutter-basics/
// https://medium.com/@anilcan/forms-in-flutter-6e1364eafdb5
