import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';
import 'package:toast/toast.dart';

import 'constants.dart';
import 'models/custom_response.dart';
import 'models/user.dart';

class RegisterPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _RegisterPageState();
  }
}

class _RegisterPageState extends State<RegisterPage> {
  final _regiterUserFormKey = GlobalKey<FormState>();
  List cityData = [];

  User _newUser = new User();

  void _savePref(String username, String userKey) async {
    final prefs = await SharedPreferences.getInstance();
    final key = userKey;
    final value = username;
    prefs.setString(key, value);
  }

  void _getData() async {
    try {
      // load data from API
      Response resp = await Dio().get("$apiUrl/District");
      setState(() {
        CustomResponse d = CustomResponse.fromJson(resp.data);
        // _loadCityData(d.data);
        cityData.addAll(d.data);
      });
    } catch (e) {}
  }

  Future<CustomResponse> _postData() async {
    var resp =
        await Dio().post("$apiUrl/Register", data: json.encode(_newUser));
    return CustomResponse.fromJson(resp.data);
  }

  @override
  initState() {
    super.initState();
    _getData();
  }

  @override
  Widget build(BuildContext context) {
    final username = TextFormField(
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        hintText: usernameHintText,
      ),
      style: TextStyle(
        color: Colors.black,
      ),
      onSaved: (value) {
        _newUser.username = value;
      },
    );

    final password = TextFormField(
      obscureText: true,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        hintText: passwordHintText,
      ),
      style: TextStyle(
        color: Colors.black,
      ),
      onSaved: (value) {
        _newUser.password = value;
      },
    );

    final name = TextFormField(
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        hintText: fullNameHintText,
      ),
      style: TextStyle(
        color: Colors.black,
      ),
      onSaved: (value) {
        _newUser.name = value;
      },
    );

    final cityDropdown = DropdownButton(
      items: cityData
          .map((f) => DropdownMenuItem(
                value: f["id"],
                child: Text(f["name"]),
              ))
          .toList(),
      onChanged: (value) {
        setState(() {
          _newUser.districtId = value;
        });
      },
      hint: Text(voterRegCity),
      isExpanded: true,
      value: _newUser.districtId,
    );

    final registerButton = Padding(
      padding: EdgeInsets.symmetric(vertical: 10.0),
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        onPressed: () {
          _regiterUserFormKey.currentState.save();
          _postData().then((resp) {
            Toast.show(resp.message, context,
                duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
            if (resp.code == 100) {
              // save in savePref
              _savePref(resp.data.toString(), "user_key");
              Navigator.of(context).pushReplacementNamed(registerSuccessTag);
            }
          });
        },
        padding: EdgeInsets.all(12),
        color: appBtnDefaultColor,
        child: Text(registerButtonText, style: TextStyle(color: Colors.white)),
      ),
    );

    return Scaffold(
        backgroundColor: appBgColor,
        appBar: AppBar(
          title: Text(registerWithUsText,
              style: TextStyle(color: appBarTextColor)),
          backgroundColor: appBarColor,
        ),
        body: Form(
          key: _regiterUserFormKey,
          child: Center(
            child: ListView(
              shrinkWrap: true,
              padding: EdgeInsets.only(left: 24.0, right: 24.0),
              children: <Widget>[
                SizedBox(height: buttonHeight),
                cityDropdown,
                username,
                password,
                name,
                SizedBox(height: buttonHeight),
                registerButton
              ],
            ),
          ),
        ));
  }
}
