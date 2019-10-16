import 'dart:async';
import 'package:http/http.dart' as http;

const baseUrl = "https://datacollectorbackend.azurewebsites.net";

class API {
  static Future getDistricts() {
    return http.get(Uri.encodeFull(baseUrl + "/District"),
        headers: {"Accept": "application/json"});
  }
}
