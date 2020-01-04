import 'package:flutter/material.dart';

import 'package:dio/dio.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';
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
      Response resp =
          await Dio().get("$apiUrl/PollingDivision/" + districtId.toString());
      setState(() {
        CustomResponse d = CustomResponse.fromJson(resp.data);
        pollingDivisonData.addAll(d.data);
      });
    } catch (e) {}
  }

  void _getPollingCentreData(divisonId) async {
    try {
      // load data from API
      Response resp =
          await Dio().get("$apiUrl/PollingCentre/" + divisonId.toString());
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

    final districtDropdown = SearchableDropdown(
      items: districtData
          .map((f) => DropdownMenuItem(
                value: f["name"],
                child: Text(f["name"]),
              ))
          .toList(),
      value: _newVoter.districtName,
      hint: new Text(voterRegCity),
      searchHint: new Text(
        voterRegCity,
        style: new TextStyle(fontSize: 20),
      ),
      onChanged: (value) {
        setState(() {
          _newVoter.districtName = value;
          var tempDistrict = districtData.firstWhere((c) => c["name"] == value);
          _newVoter.districtId = tempDistrict["id"];

          _getPollingDivisionData(_newVoter.districtId);
        });
      },
    );

    final postalDropdown = SearchableDropdown(
      items: postOfficeData
          .map((f) => DropdownMenuItem(
                value: f["name"],
                child: Text(f["name"] + ' / ' + f["postalCode"]),
              ))
          .toList(),
      value: _newVoter.postOfficeName,
      hint: new Text(voterRegPostalCode),
      searchHint: new Text(
        voterRegPostalCode,
        style: new TextStyle(fontSize: 20),
      ),
      onChanged: (value) {
        setState(() {
          _newVoter.postOfficeName = value;
          var tempPostOffice =
              postOfficeData.firstWhere((c) => c["name"] == value);
          _newVoter.postalCode = tempPostOffice["postalCode"];
          _newVoter.postOfficeId = tempPostOffice["id"];
        });
      },
    );

    final pollingDivisionDropdown = SearchableDropdown(
      items: pollingDivisonData
          .map((f) => DropdownMenuItem(
                value: f["name"],
                child: Text(f["name"]),
              ))
          .toList(),
      value: _newVoter.pollingDivisionName,
      hint: new Text(voterRegPollingDivision),
      searchHint: new Text(
        voterRegPollingDivision,
        style: new TextStyle(fontSize: 20),
      ),
      onChanged: (value) {
        setState(() {
          _newVoter.pollingDivisionName = value;
          var tempPollingDivision =
              pollingDivisonData.firstWhere((c) => c["name"] == value);
          _newVoter.pollingDivisionId = tempPollingDivision["id"];
          _getPollingCentreData(_newVoter.pollingDivisionId);
        });
      },
    );

    final pollingCentreDropdown = SearchableDropdown(
      items: pollingCentreData
          .map((f) => DropdownMenuItem(
                value: f["name"],
                child: Text(f["name"]),
              ))
          .toList(),
      value: _newVoter.pollingCentreName,
      hint: new Text(voterRegPollingCentre),
      searchHint: new Text(
        voterRegPollingCentre,
        style: new TextStyle(fontSize: 20),
      ),
      onChanged: (value) {
        setState(() {
          _newVoter.pollingCentreName = value;
          var tempPollingCentre =
              pollingCentreData.firstWhere((c) => c["name"] == value);
          _newVoter.pollingCentreId = tempPollingCentre["id"];
        });
      },
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
      backgroundColor: appBgColor,
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
