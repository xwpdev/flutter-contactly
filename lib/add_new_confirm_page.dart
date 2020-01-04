import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:toast/toast.dart';
import 'package:loading/loading.dart';
import 'package:loading/indicator/ball_pulse_indicator.dart';

import 'constants.dart';
import 'models/custom_response.dart';
import 'models/voter.dart';

class AddNewConfirmPage extends StatefulWidget {
  final Voter _voterData;
  AddNewConfirmPage(this._voterData);

  @override
  _AddNewConfirmPageState createState() => _AddNewConfirmPageState();
}

class _AddNewConfirmPageState extends State<AddNewConfirmPage> {
  bool _loading = false;

  _addVoter(voterData) async {
    var resp = await Dio().post("$apiUrl/Voter", data: json.encode(voterData));
    return CustomResponse.fromJson(resp.data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBgColor,
      appBar: AppBar(
        title: Text(voterRegConfirm, style: TextStyle(color: appBarTextColor)),
        backgroundColor: appBarColor,
      ),
      body: _loading
          ? Center(
              child: Loading(
                  indicator: BallPulseIndicator(),
                  size: 80.0,
                  color: appBtnDefaultColor))
          : SingleChildScrollView(
              padding: EdgeInsets.all(16),
              child: Column(
                children: <Widget>[
                  Table(
                    children: <TableRow>[
                      TableRow(children: <Widget>[
                        Text(
                          voterRegFirstName,
                        ),
                        Text(
                          widget._voterData.firstName,
                        )
                      ]),
                      TableRow(children: <Widget>[
                        Text(
                          voterRegLastName,
                        ),
                        Text(
                          widget._voterData.lastName,
                        )
                      ]),
                      TableRow(children: <Widget>[
                        Text(
                          voterRegAddress,
                        ),
                        Text(
                          widget._voterData.address,
                        )
                      ]),
                      TableRow(children: <Widget>[
                        Text(
                          voterRegCity,
                        ),
                        Text(
                          widget._voterData.districtName,
                        )
                      ]),
                      TableRow(children: <Widget>[
                        Text(
                          voterRegPostalCode,
                        ),
                        Text(
                          widget._voterData.postalCode,
                        )
                      ]),
                      TableRow(children: <Widget>[
                        Text(
                          voterRegPollingDivision,
                        ),
                        Text(
                          widget._voterData.pollingDivisionName,
                        )
                      ]),
                      TableRow(children: <Widget>[
                        Text(
                          voterRegPollingCentre,
                        ),
                        Text(
                          widget._voterData.pollingCentreName,
                        )
                      ]),
                      TableRow(children: <Widget>[
                        Text(
                          voterRegEmail,
                        ),
                        Text(
                          widget._voterData.email,
                        )
                      ]),
                      TableRow(children: <Widget>[
                        Text(
                          voterRegPhone,
                        ),
                        Text(
                          widget._voterData.phone,
                        )
                      ])
                    ],
                  ),
                  RaisedButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                    onPressed: () {
                      // push data to db
                      // VoterReq voterReqData = VoterReq();
                      // voterReqData.firstName = _voterData.firstName;
                      // voterReqData.lastName = _voterData.lastName;
                      // voterReqData.address = _voterData.address;
                      // voterReqData.email = _voterData.email;
                      // voterReqData.phone = _voterData.phone;
                      // voterReqData.postOfficeId = _voterData.postOfficeId;
                      // voterReqData.pollingCentreId = _voterData.pollingCentreId;
                      // voterReqData.adminUserId = _voterData.adminUserId;

                      _addVoter(widget._voterData).then((resp) {
                        Toast.show(
                            resp.message != null
                                ? resp.message
                                : 'Added Successfully!',
                            context,
                            duration: Toast.LENGTH_SHORT,
                            gravity: Toast.BOTTOM);
                        if (resp.code == 100) {
                          Navigator.popUntil(
                              context, ModalRoute.withName(homePageTag));
                        }
                      });
                    },
                    padding: EdgeInsets.all(12),
                    color: appBtnDefaultColor,
                    child: Text(voterRegSubmit,
                        style: TextStyle(color: Colors.white)),
                  )
                ],
              ),
            ),
    );
  }
}
