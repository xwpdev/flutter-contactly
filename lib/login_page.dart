import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import './constants.dart';

class LoginPage extends StatelessWidget {
  final _userNameInputController = TextEditingController();
  final _passwordInputController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final logo = CircleAvatar(
      backgroundColor: Colors.lime,
      radius: bigRadius,
      child: appLogo,
    );

    final username = TextFormField(
      controller: _userNameInputController,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        hintText: usernameHintText,
      ),
      style: TextStyle(
        color: Colors.black,
      ),
    );

    final password = TextFormField(
      obscureText: true,
      controller: _passwordInputController,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        hintText: passwordHintText,
      ),
      style: TextStyle(
        color: Colors.black,
      ),
    );

    final loginButton = Padding(
      padding: EdgeInsets.symmetric(vertical: 10.0),
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        onPressed: () {
          // validate user and login
          if (username.controller.text == 'SysAdmin' &&
              password.controller.text == 'Admin@123') {
            // add shared data
            _savePref(username.controller.text, "user_key");
            Navigator.of(context).pushReplacementNamed(homePageTag);
          }
        },
        padding: EdgeInsets.all(12),
        color: appBtnDefaultColor,
        child: Text(loginButtonText, style: TextStyle(color: Colors.white)),
      ),
    );

    final registerButton = Padding(
      padding: EdgeInsets.symmetric(vertical: 10.0),
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        onPressed: () {
          Navigator.of(context).pushNamed(registerPageTag);
        },
        padding: EdgeInsets.all(12),
        color: appBtnSecondColor,
        child: Text(registerButtonText, style: TextStyle(color: Colors.white)),
      ),
    );

    return Scaffold(
      backgroundColor: appBgColor,
      body: Center(
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.only(left: 24.0, right: 24.0),
          children: <Widget>[
            logo,
            SizedBox(height: bigRadius),
            username,
            password,
            SizedBox(height: buttonHeight),
            loginButton,
            registerButton
          ],
        ),
      ),
    );
  }

  void _savePref(String username, String userKey) async {
    final prefs = await SharedPreferences.getInstance();
    final key = userKey;
    final value = username;
    prefs.setString(key, value);
  }
}
