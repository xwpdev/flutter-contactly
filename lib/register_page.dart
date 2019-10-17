import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

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
  List<DropdownMenuItem<String>> _cityList = [];
  List _data = new List();
  User _newUser = new User();

  void _getHttp() async {
    try {
      print("api call");
      // load data from API
      Response resp = await Dio()
          .get("https://datacollectorbackend.azurewebsites.net/District");
      setState(() {
        print('setState');
        _data = resp.data[2];
        _loadCityData();
      });
    } catch (e) {}
  }

  void _loadCityData() {
    print('loadCityData');
    _cityList.clear();
    print(_data);
    for (var i = 0; i < _data.length; i++) {
      _cityList.add(DropdownMenuItem(
        value: _data[i].id,
        child: Text(_data[i].name),
      ));
    }

    // _cityList.add(DropdownMenuItem(
    //   value: "1",
    //   child: Text("Colombo / කොළඹ"),
    // ));

    // _cityList.add(DropdownMenuItem(
    //   value: "2",
    //   child: Text("Kandy / මහනුවර"),
    // ));

    // _cityList.add(DropdownMenuItem(
    //   value: "3",
    //   child: Text("Kurunegala / කුරුණෑගල"),
    // ));
  }

  @override
  Widget build(BuildContext context) {
    _getHttp();
    // _loadCityData();

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
