import 'package:flutter/material.dart';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';

import 'add_new_confirm_page.dart';
import 'constants.dart';
import 'models/custom_response.dart';
import 'models/voter.dart';

class AddNewPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AddNewPageState();
  }
}

class _AddNewPageState extends State {
  Voter _newVoter = new Voter();
  List cityData = [];

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final _addVoterFormKey = GlobalKey<FormState>();
  int _adminUserId;

  void _getSharedPref() async {
    final prefs = await SharedPreferences.getInstance();
    _adminUserId = int.parse(prefs.getString("user_key"));
  }

  void _getData() async {
    try {
      _getSharedPref();
      // load data from API
      Response resp = await Dio().get("$apiUrl/District");
      setState(() {
        CustomResponse d = CustomResponse.fromJson(resp.data);
        cityData.addAll(d.data);
      });
    } catch (e) {}
  }

  @override
  initState() {
    super.initState();
    _getData();
  }

  @override
  Widget build(BuildContext context) {
    _newVoter.adminUserId = _adminUserId;

    final firstNameText = TextFormField(
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
          labelText: voterRegFirstName,
          labelStyle: TextStyle(color: labelColor)),
      onSaved: (value) => _newVoter.firstName = value,
    );

    final lastNameText = TextFormField(
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
          labelText: voterRegLastName,
          labelStyle: TextStyle(color: labelColor)),
      onSaved: (value) => _newVoter.lastName = value,
    );

    final addressText = TextFormField(
      maxLines: 3,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
          labelText: voterRegAddress, labelStyle: TextStyle(color: labelColor)),
      onSaved: (value) => _newVoter.address = value,
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
          _newVoter.cityId = value;
          var tempCity = cityData.firstWhere((c) => c["id"] == value);
          _newVoter.cityName = tempCity["name"];
        });
      },
      hint: Text(voterRegCity),
      focusColor: labelColor,
      isExpanded: true,
      value: _newVoter.cityId,
    );

    final postalCodeText = TextFormField(
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
          labelText: voterRegPostalCode,
          labelStyle: TextStyle(color: labelColor)),
      onSaved: (value) => _newVoter.postalCode = value,
    );

    // final pollingCentreDropdown = DropdownButton<String>(
    //   items: _pollingCentreList,
    //   onChanged: (String value) {
    //     setState(() {
    //       _newVoter.pollingCentre = value;
    //     });
    //   },
    //   hint: Text(voterRegPollingCentre),
    //   isExpanded: true,
    //   value: _newVoter.pollingCentre,
    // );

    final pollingDivisionText = TextFormField(
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
          labelText: voterRegPollingDivision,
          labelStyle: TextStyle(color: labelColor)),
      onSaved: (value) => _newVoter.pollingDivision = value,
    );

    final pollingStationText = TextFormField(
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
          labelText: voterRegPollingCentre,
          labelStyle: TextStyle(color: labelColor)),
      onSaved: (value) => _newVoter.pollingCentre = value,
    );

    final phoneText = TextFormField(
      keyboardType: TextInputType.phone,
      decoration: InputDecoration(
          labelText: voterRegPhone, labelStyle: TextStyle(color: labelColor)),
      onSaved: (value) => _newVoter.phone = value,
    );

    final emailText = TextFormField(
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
          labelText: voterRegEmail, labelStyle: TextStyle(color: labelColor)),
      onSaved: (value) => _newVoter.email = value,
    );

    final confirmButton = RaisedButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      onPressed: () {
        _addVoterFormKey.currentState.save();
        if (_newVoter != null) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => AddNewConfirmPage(_newVoter)));
        } else {
          Toast.show("Please Enter All Required Fields", context,
              duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
        }
      },
      padding: EdgeInsets.all(12),
      color: appBtnDefaultColor,
      child: Text(voterRegConfirm, style: TextStyle(color: Colors.white)),
    );

    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text(addNewTitleText, style: TextStyle(color: appBarTextColor)),
        backgroundColor: appBarColor,
      ),
      body: Form(
        key: _addVoterFormKey,
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.only(left: 24.0, right: 24.0),
          children: <Widget>[
            firstNameText,
            lastNameText,
            emailText,
            phoneText,
            addressText,
            cityDropdown,
            postalCodeText,
            pollingDivisionText,
            pollingStationText,
            SizedBox(height: buttonHeight),
            confirmButton
          ],
        ),
      ),
    );
  }
}
