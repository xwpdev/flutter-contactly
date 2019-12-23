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
  List districtData = [];
  List pollingDivisonData = [];
  List pollingCentreData = [];
  List postOfficeData = [];

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final _addVoterFormKey = GlobalKey<FormState>();
  int _adminUserId;

  void _getSharedPref() async {
    final prefs = await SharedPreferences.getInstance();
    _adminUserId = int.parse(prefs.getString("user_key"));
  }

  void _getDistrictData() async {
    try {
      // load data from API
      Response resp = await Dio().get("$apiUrl/District");
      setState(() {
        CustomResponse d = CustomResponse.fromJson(resp.data);
        districtData.addAll(d.data);
      });
    } catch (e) {}
  }

  void _getPollingDivisionData(districtId) async {
    try {
      // load data from API
      Response resp = await Dio().get("$apiUrl/PollingDivision/" + districtId);
      setState(() {
        CustomResponse d = CustomResponse.fromJson(resp.data);
        pollingDivisonData.addAll(d.data);
      });
    } catch (e) {}
  }

  void _getPollingCentreData(divisonId) async {
    try {
      // load data from API
      Response resp = await Dio().get("$apiUrl/PollingCentre/" + divisonId);
      setState(() {
        CustomResponse d = CustomResponse.fromJson(resp.data);
        pollingCentreData.addAll(d.data);
      });
    } catch (e) {}
  }

  void _getPostOfficeData() async {
    try {
      // load data from API
      Response resp = await Dio().get("$apiUrl/PostOffice/");
      setState(() {
        CustomResponse d = CustomResponse.fromJson(resp.data);
        postOfficeData.addAll(d.data);
      });
    } catch (e) {}
  }

  @override
  initState() {
    super.initState();
    _getSharedPref();
    _getDistrictData();
    _getPostOfficeData();
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

    final districtDropdown = DropdownButton(
      items: districtData
          .map((f) => DropdownMenuItem(
                value: f["id"],
                child: Text(f["name"]),
              ))
          .toList(),
      onChanged: (value) {
        setState(() {
          _newVoter.districtId = value;
          var tempDistrict = districtData.firstWhere((c) => c["id"] == value);
          _newVoter.districtName = tempDistrict["name"];
        });
        _getPollingDivisionData(value);
      },
      hint: Text(voterRegCity),
      focusColor: labelColor,
      isExpanded: true,
      value: _newVoter.districtId,
    );

    final postalDropdown = DropdownButton(
      items: postOfficeData
          .map((f) => DropdownMenuItem(
                value: f["id"],
                child: Text(f["name"] + '/' + f["postalCode"]),
              ))
          .toList(),
      onChanged: (value) {
        setState(() {
          _newVoter.postOfficeId = value;
          var tempPostOffice =
              postOfficeData.firstWhere((c) => c["id"] == value);
          _newVoter.postalCode = tempPostOffice["postalCode"];
        });
      },
      hint: Text(voterRegPostalCode),
      focusColor: labelColor,
      isExpanded: true,
      value: _newVoter.postOfficeId,
    );

    final pollingDivisionDropdown = DropdownButton(
      items: pollingDivisonData
          .map((f) => DropdownMenuItem(
                value: f["id"],
                child: Text(f["name"]),
              ))
          .toList(),
      onChanged: (value) {
        setState(() {
          _newVoter.pollingDivisionId = value;
          _getPollingCentreData(value);
        });
      },
      hint: Text(voterRegPollingDivision),
      focusColor: labelColor,
      isExpanded: true,
      value: _newVoter.pollingDivisionId,
    );

    final pollingCentreDropdown = DropdownButton(
      items: pollingCentreData
          .map((f) => DropdownMenuItem(
                value: f["id"],
                child: Text(f["name"]),
              ))
          .toList(),
      onChanged: (value) {
        setState(() {
          _newVoter.pollingCentreId = value;
        });
      },
      hint: Text(voterRegPostalCode),
      focusColor: labelColor,
      isExpanded: true,
      value: _newVoter.pollingCentreId,
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
            districtDropdown,
            postalDropdown,
            pollingDivisionDropdown,
            pollingCentreDropdown,
            SizedBox(height: buttonHeight),
            confirmButton
          ],
        ),
      ),
    );
  }
}
