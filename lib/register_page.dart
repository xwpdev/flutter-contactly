import 'package:VoterRegister/models/district.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

import 'constants.dart';
import 'models/response.dart';
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

  List<DropdownMenuItem<String>> _cityList = [];
  User _newUser = new User();

  void _getHttp() async {
    try {
      // load data from API
      Response resp = await Dio()
          .get("https://datacollectorbackend.azurewebsites.net/District");
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

  @override
  initState() {
    super.initState();
    _getHttp();
  }

  @override
  Widget build(BuildContext context) {
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
