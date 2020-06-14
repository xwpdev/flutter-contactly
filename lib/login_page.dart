import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';
import 'package:toast/toast.dart';
import 'package:loading/loading.dart';
import 'package:loading/indicator/ball_pulse_indicator.dart';

import './constants.dart';
import 'models/custom_response.dart';
import 'models/user.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _loading = false;

  final _userNameInputController = TextEditingController();

  final _passwordInputController = TextEditingController();

  _loginUser(userData) async {
    var resp = await Dio().post("$apiUrl/Login", data: json.encode(userData));
    return CustomResponse.fromJson(resp.data);
  }

  @override
  Widget build(BuildContext context) {
    final logo = CircleAvatar(
      backgroundColor: Colors.lightBlue[50],
      radius: bigLoginRadius,
      child: appLogo,
    );

    final username = TextFormField(
      controller: _userNameInputController,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
          labelText: usernameHintText,
          labelStyle: TextStyle(color: labelColor)),
      style: TextStyle(
        color: Colors.black,
      ),
    );

    final password = TextFormField(
      obscureText: true,
      controller: _passwordInputController,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
          labelText: passwordHintText,
          labelStyle: TextStyle(color: labelColor)),
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
          if (username.controller.text != "" &&
              password.controller.text != "") {
            var tempUser = new User();

            setState(() {
              _loading = true;
            });

            tempUser.username = username.controller.text;
            tempUser.password = password.controller.text;
            _loginUser(tempUser).then((resp) {
              setState(() {
                _loading = false;
              });
              if (resp.code == 100) {
                _savePref(resp.data.toString(), "user_key");
                Navigator.of(context).pushReplacementNamed(homePageTag);
              } else {
                Toast.show(resp.message, context,
                    duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
              }
            });
          } else {
            Toast.show("Login Error", context,
                duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
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
        body: _loading
            ? Center(
                child: Loading(
                    indicator: BallPulseIndicator(),
                    size: 80.0,
                    color: appBtnDefaultColor))
            : Center(
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
              ));
  }

  void _savePref(String username, String userKey) async {
    final prefs = await SharedPreferences.getInstance();
    final key = userKey;
    final value = username;
    prefs.setString(key, value);
  }
}
