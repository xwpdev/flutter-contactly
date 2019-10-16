import 'package:flutter/material.dart';

import 'constants.dart';
import 'models/voter.dart';

class AddNewPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AddNewPageState();
  }
}

class _AddNewPageState extends State {
  Voter _newVoter = new Voter();

  final List<DropdownMenuItem<String>> _cityList = [];
  final List<DropdownMenuItem<String>> _pollingCentreList = [];

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final _addVoterFormKey = GlobalKey<FormState>();

  void _loadCityData() {
    _cityList.clear();
    // load data from API
    _cityList.add(DropdownMenuItem(
      value: "Colombo",
      child: Text("Colombo / කොළඹ"),
    ));

    _cityList.add(DropdownMenuItem(
      value: "Kandy",
      child: Text("Kandy / මහනුවර"),
    ));

    _cityList.add(DropdownMenuItem(
      value: "Kurunegala",
      child: Text("Kurunegala / කුරුණෑගල"),
    ));
  }

  void _loadPollingCentreData(String cityId) {
    _pollingCentreList.clear();
    _pollingCentreList.add(DropdownMenuItem(
      value: "PC_1",
      child: Text("Polling Centre 01 / ඡන්ද මධ්‍යස්ථානය 01"),
    ));

    _pollingCentreList.add(DropdownMenuItem(
      value: "PC_2",
      child: Text("Polling Centre 02 / ඡන්ද මධ්‍යස්ථානය 02"),
    ));

    _pollingCentreList.add(DropdownMenuItem(
      value: "PC_3",
      child: Text("Polling Centre 03 / ඡන්ද මධ්‍යස්ථානය 03"),
    ));
  }

  @override
  Widget build(BuildContext context) {
    _newVoter.adminUserId = 1;

    _loadCityData();

    final firstNameText = TextFormField(
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        hintText: voterRegFirstName,
      ),
      onSaved: (value) => _newVoter.firstName = value,
    );

    final lastNameText = TextFormField(
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        hintText: voterRegLastName,
      ),
      onSaved: (value) => _newVoter.lastName = value,
    );

    final addressText = TextFormField(
      maxLines: 3,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        hintText: voterRegAddress,
      ),
      onSaved: (value) => _newVoter.address = value,
    );

    final cityDropdown = DropdownButton<String>(
      items: _cityList,
      onChanged: (String value) {
        _loadPollingCentreData(value);
        setState(() {
          _newVoter.city = value;
        });
      },
      hint: Text(voterRegCity),
      isExpanded: true,
      value: _newVoter.city,
    );

    final pollingCentreDropdown = DropdownButton<String>(
      items: _pollingCentreList,
      onChanged: (String value) {
        setState(() {
          _newVoter.pollingCentre = value;
        });
      },
      hint: Text(voterRegPollingCentre),
      isExpanded: true,
      value: _newVoter.pollingCentre,
    );

    final phoneText = TextFormField(
      keyboardType: TextInputType.phone,
      decoration: InputDecoration(
        hintText: voterRegPhone,
      ),
      onSaved: (value) => _newVoter.phone = value,
    );

    final emailText = TextFormField(
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(hintText: voterRegEmail),
      onSaved: (value) => _newVoter.email = value,
    );

    final confirmButton = RaisedButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      onPressed: () {
        // push data to db
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
            cityDropdown,
            pollingCentreDropdown,
            firstNameText,
            lastNameText,
            addressText,
            emailText,
            phoneText,
            SizedBox(height: buttonHeight),
            confirmButton
          ],
        ),
      ),
    );
  }
}
