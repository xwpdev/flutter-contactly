import 'dart:convert';

import 'package:VoterRegister/models/district.dart';
import 'package:flutter/material.dart';
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

  List<DropdownMenuItem<String>> _cityList = [];
  User _newUser = new User();

  void _getData() async {
    try {
      // load data from API
      Response resp = await Dio().get("$apiUrl/District");
      setState(() {
        CustomResponse d = CustomResponse.fromJson(resp.data);
        _loadCityData(d.data);
      });
    } catch (e) {}
  }

  void _loadCityData(List data) {
    _cityList.clear();
    if (data != null) {
      for (var i = 0; i < data.length; i++) {
        District tempDistrict = District.fromJson(data[i]);
        _cityList.add(DropdownMenuItem(
          value: tempDistrict.id.toString(),
          child: Text(tempDistrict.name),
        ));
      }
    }
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

    final cityDropdown = DropdownButton<String>(
      items: _cityList,
      onChanged: (String value) {
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
          _postData().then((data) => {
                if (data.code == 100)
                  {
                    Navigator.of(context).pushNamed(registerSuccessTag)}
                else
                  {
                    // show error message
                    Toast.show(data.message, context,
                        duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM)
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
