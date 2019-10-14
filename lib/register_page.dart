import 'package:flutter/material.dart';

import 'constants.dart';

class RegisterPage extends StatelessWidget {
  final _userNameInputController = TextEditingController();
  final _passwordInputController = TextEditingController();
  final _fullNameInputController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final username = TextFormField(
      controller: _userNameInputController,
      keyboardType: TextInputType.text,
      autofocus: true,
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

    final fullName = TextFormField(
      controller: _fullNameInputController,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        hintText: fullNameHintText,
      ),
      style: TextStyle(
        color: Colors.black,
      ),
    );

    final registerButton = Padding(
      padding: EdgeInsets.symmetric(vertical: 10.0),
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        onPressed: () {
          Navigator.of(context).pushNamed(registerSuccessTag);
        },
        padding: EdgeInsets.all(12),
        color: appBtnDefaultColor,
        child: Text(registerButtonText, style: TextStyle(color: Colors.white)),
      ),
    );

    return Scaffold(
      backgroundColor: appBgColor,
      appBar: AppBar(
        title:
            Text(registerWithUsText, style: TextStyle(color: appBarTextColor)),
        backgroundColor: appBarColor,
      ),
      body: Center(
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.only(left: 24.0, right: 24.0),
          children: <Widget>[
            SizedBox(height: buttonHeight),
            username,
            password,
            fullName,
            SizedBox(height: buttonHeight),
            registerButton
          ],
        ),
      ),
    );
  }
}
