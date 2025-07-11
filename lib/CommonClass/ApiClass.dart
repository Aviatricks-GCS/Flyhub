import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'Utils.dart';

class ApiClass {
  late SharedPreferences pref;

  Future<dynamic> getLanguage() async {

    var langList = [];

    var _body = {"action": "getLang"};

    print("Request data from getLang action : $_body");

    try {
      var response = await http.post(Uri.parse(Utils.apiUrl), body: _body);

      if (response.statusCode == 200) {
        print("Successs");
        final responseBody = response.body;
        langList = json.decode(responseBody);
        print("Response data from getLang action : $langList");
      } else {
        print(
          'Failed to load data. Server responded with status code: ${response.statusCode}',
        );
        throw Exception("Failed to load data for Internal Server Error");
      }
    } catch (e) {
      print("Exception occurred in getLanguage: $e");
    }

    return langList;
  }


  Future<dynamic> getOtp() async {
    pref = await SharedPreferences.getInstance();
    var mobile_number = pref.getString("mobile_number") ?? "";
    var langList = [];

    var _body = {
      "action": "checkUser",
      "mobile": mobile_number,
      "deviceId": "checkUser",
      "device_version": "checkUser",
      "vcode": "checkUser",
      "fcmId": "",
    };

    print("Request data from getLang action : $_body");

    try {
      var response = await http.post(Uri.parse(Utils.apiUrl), body: _body);

      if (response.statusCode == 200) {
        print("Successs");
        final responseBody = response.body;
        langList = json.decode(responseBody);
        print("Response data from getLang action : $langList");
      } else {
        print(
          'Failed to load data. Server responded with status code: ${response.statusCode}',
        );
        throw Exception("Failed to load data for Internal Server Error");
      }
    } catch (e) {
      print("Exception occurred in getLanguage: $e");
    }

    return langList;
  }


}
