import './home_page.dart';
import './login_page.dart';
import './register_page.dart';
import './register_success_page.dart';
import 'package:flutter/material.dart';

import './constants.dart';
import 'add_new_page.dart';

void main() => runApp(ContactlyApp());

class ContactlyApp extends StatelessWidget {
  // This widget is the root of your application.

  final _routes = <String, WidgetBuilder>{
    loginPageTag: (context) => LoginPage(),
    homePageTag: (context) => HomePage(),
    registerPageTag: (context) => RegisterPage(),
    registerSuccessTag: (context) => RegisterSuccessPage(),
    addNewVoterTag: (context) => AddNewPage()
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
// https://codingwithjoe.com/building-forms-with-flutter/
// https://medium.com/flutter-community/flutter-push-pop-push-1bb718b13c31
