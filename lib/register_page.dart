import 'package:VoterRegister/models/district.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

import 'api.dart';
import 'constants.dart';
import 'models/user.dart';

class RegisterPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _RegisterPageState();
  }
}

class _RegisterPageState extends State<RegisterPage> {
  final _userNameInputController = TextEditingController();
  final _passwordInputController = TextEditingController();
  final _fullNameInputController = TextEditingController();
  List _cityList = List();
  User _newUser = new User();

  // Future<District> _fetchPost() async {
  //   final response = await http
  //       .get('https://datacollectorbackend.azurewebsites.net/district');

  //   return District.fromJson(json.decode(response.body));
  // }

  void _loadCityData() {
    _cityList.clear();
    // load data from API

    API.getDistricts().then((response) {
      setState(() {
        _cityList = json.decode(response.body);
      });
    });

    // _fetchPost().then((onValue) => print(onValue));

    _cityList.add(DropdownMenuItem(
      value: "1",
      child: Text("Colombo / කොළඹ"),
    ));

    _cityList.add(DropdownMenuItem(
      value: "2",
      child: Text("Kandy / මහනුවර"),
    ));

    _cityList.add(DropdownMenuItem(
      value: "3",
      child: Text("Kurunegala / කුරුණෑගල"),
    ));
  }

  @override
  Widget build(BuildContext context) {
    _loadCityData();

    final username = TextFormField(
      controller: _userNameInputController,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        hintText: usernameHintText,
      ),
      style: TextStyle(
        color: Colors.black,
      ),
      onSaved: (value) => _newUser.username,
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
      onSaved: (value) => _newUser.password,
    );

    final name = TextFormField(
      controller: _fullNameInputController,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        hintText: fullNameHintText,
      ),
      style: TextStyle(
        color: Colors.black,
      ),
      onSaved: (value) => _newUser.name,
    );

    final cityDropdown = DropdownButton<String>(
      items: _cityList.map((item) {
        print(item);
        return new DropdownMenuItem(
          child: new Text(item['name']),
          value: item['id'].toString(),
        );
      }),
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
            cityDropdown,
            username,
            password,
            name,
            SizedBox(height: buttonHeight),
            registerButton
          ],
        ),
      ),
    );
  }
}
