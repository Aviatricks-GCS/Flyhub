import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
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

  Future<dynamic> getOtp(String mobileNo) async {
    pref = await SharedPreferences.getInstance();
    //var mobile_number = pref.getString("mobile_number") ?? "";

    var deviceId = pref.getString("deviceId") ?? "";
    var deviceVersion = pref.getString("deviceVersion") ?? "";
    var platform = pref.getString("platform") ?? "";
    var deviceModel = pref.getString("deviceModel") ?? "";
    var versionCode = pref.getString("vCode") ?? "";

    var responseData;

    var _body = {
      "action": "checkUser",
      "mobile": mobileNo,
      "deviceId": deviceId,
      "device_version": deviceVersion,
      "platform": platform,
      "device_Model": deviceModel,
      "vcode": versionCode,
      "fcmId": "",
    };

    print("Request data from checkUser : $_body");

    try {
      var response = await http.post(Uri.parse(Utils.apiUrl), body: _body);

      if (response.statusCode == 200) {
        final responseBody = response.body;
        responseData = json.decode(responseBody);
        print("Response data from checkUser : $responseData");
      } else {
        print(
          'Failed to load data. Server responded with status code: ${response.statusCode}',
        );
        throw Exception("Failed to load data for Internal Server Error");
      }
    } catch (e) {
      print("Exception occurred in getLanguage: $e");
    }

    return responseData;
  }

  Future<dynamic> verifyOTP(String otp) async {
    pref = await SharedPreferences.getInstance();
    var mobile_number = pref.getString("mobile_number") ?? "";
    var userId = pref.getString("userId") ?? "";

    var responseData;

    var _body = {
      "action": "verifyOtp",
      "mobile": mobile_number,
      "otp": otp,
      "user_id": userId,
    };

    print("Request data from verifyOtp : $_body");

    try {
      var response = await http.post(Uri.parse(Utils.apiUrl), body: _body);

      if (response.statusCode == 200) {
        final responseBody = response.body;
        responseData = json.decode(responseBody);
        print("Response data from verifyOtp : $responseData");
      } else {
        print(
          'Failed to load data. Server responded with status code: ${response.statusCode}',
        );
        throw Exception("Failed to load data for Internal Server Error");
      }
    } catch (e) {
      print("Exception occurred in getLanguage: $e");
    }

    return responseData;
  }

  Future<dynamic> gethomedata() async {
    pref = await SharedPreferences.getInstance();
    var lanId = pref.getInt("langId");
    var responseData;
    var _body = {"action": "homeRequest", "lang": "$lanId"};

    var response = await http.post(Uri.parse(Utils.liveLocal_Url), body: _body);

    print('Request data from gethomedata $_body');

    try {
      if (response.statusCode == 200) {
        final responseBody = response.body;
        responseData = json.decode(responseBody);
        print('Response data from gethomedata $responseData');
      } else {
        print(
          'Failed to load data. Server responded with status code: ${response.statusCode}',
        );
        throw Exception("Failed to load data for Internal Server Error");
      }
    } catch (e) {
      print(e);
    }
    return responseData;
  }


  Future<dynamic> addDrone(String clickUrl) async {
    pref = await SharedPreferences.getInstance();
    var mobile_number = pref.getString("mobile_number") ?? "";
    var userId = pref.getString("userId") ?? "";

    var responseData;

    var _body = {
      "action" : "addDrone",
      "user_id": userId,
      "DGCA_approval": "0",
      "model": "K++",
      "type": "2",
      "purpose": "1",
      "charging_time": "2 hours",
      "flying_time": "6hours",
      "rental_terms": "Agri Drone ",
      "price": "2500",
      "image4": "",
      "image3": "",
      "image2": "",
      "image1": "",
      "tags": "",
      "discounts": "1000",
      "drone_weight": "24 kgs",
      "battery_capacity": "33000",
      "lat": "5",
      "long": "50",
      "ratings": "5",
      "price_type": "2",
      "availability": "",
      "insurance_details": "testing insurance",
      "damage_report": "testing damage",
      "pickup_location": "Tiruchengode",
      "delivery_method": "testing"
    };

    print("Request data from addDrone : $_body");

    try {
      var response = await http.post(Uri.parse(Utils.apiUrl), body: _body);

      if (response.statusCode == 200) {
        final responseBody = response.body;
        responseData = json.decode(responseBody);
        print("Response data from addDrone : $responseData");
      } else {
        print(
          'Failed to load data. Server responded with status code: ${response.statusCode}',
        );
        throw Exception("Failed to load data for Internal Server Error");
      }
    } catch (e) {
      print(e);
    }
    return responseData;
  }


  Future<dynamic> getPurpose() async {
    pref = await SharedPreferences.getInstance();
    var lanId = pref.getInt("langId");
    var responseData;
    var _body = {"action": "getMaster", "lang": "$lanId"};

    var response = await http.post(Uri.parse(Utils.liveLocal_Url), body: _body);

    print('Request data from getPurpose $_body');

    try {
      if (response.statusCode == 200) {
        final responseBody = response.body;
        responseData = json.decode(responseBody);
        print('Response data from getPurpose $responseData');
      } else {
        print(
          'Failed to load data. Server responded with status code: ${response.statusCode}',
        );
        throw Exception("Failed to load data for Internal Server Error");
      }
    } catch (e) {
      print(e);
    }
    return responseData;
  }


}
