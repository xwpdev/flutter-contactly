import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:toast/toast.dart';

import 'constants.dart';
import 'models/custom_response.dart';
import 'models/voter.dart';

class AddNewConfirmPage extends StatelessWidget {
  final Voter _voterData;
  AddNewConfirmPage(this._voterData);

  _addVoter(voterData) async {
    var resp = await Dio().post("$apiUrl/Voter", data: json.encode(voterData));
    return CustomResponse.fromJson(resp.data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(voterRegConfirm, style: TextStyle(color: appBarTextColor)),
        backgroundColor: appBarColor,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(12),
        child: Column(
          children: <Widget>[
            Table(
              children: <TableRow>[
                TableRow(children: <Widget>[
                  Text(
                    voterRegFirstName,
                  ),
                  Text(
                    _voterData.firstName,
                  )
                ]),
                TableRow(children: <Widget>[
                  Text(
                    voterRegLastName,
                  ),
                  Text(
                    _voterData.lastName,
                  )
                ]),
                TableRow(children: <Widget>[
                  Text(
                    voterRegAddress,
                  ),
                  Text(
                    _voterData.address,
                  )
                ]),
                TableRow(children: <Widget>[
                  Text(
                    voterRegCity,
                  ),
                  Text(
                    _voterData.cityName,
                  )
                ]),
                TableRow(children: <Widget>[
                  Text(
                    voterRegPollingCentre,
                  ),
                  Text(
                    _voterData.pollingCentre,
                  )
                ]),
                TableRow(children: <Widget>[
                  Text(
                    voterRegEmail,
                  ),
                  Text(
                    _voterData.email,
                  )
                ]),
                TableRow(children: <Widget>[
                  Text(
                    voterRegPhone,
                  ),
                  Text(
                    _voterData.phone,
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
                _addVoter(_voterData).then((resp) {
                  Toast.show(resp.message, context,
                      duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
                  if (resp.code == 100) {
                    Navigator.of(context).pushReplacementNamed(homePageTag);
                  }
                });
              },
              padding: EdgeInsets.all(12),
              color: appBtnDefaultColor,
              child:
                  Text(voterRegSubmit, style: TextStyle(color: Colors.white)),
            )
          ],
        ),
      ),
    );
  }
}
