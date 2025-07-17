import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';

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

  Future<Map<String, dynamic>> getLoginscreen() async {
    Map<String, dynamic> langMap = {};
    pref = await SharedPreferences.getInstance();
    var lanId = pref.getInt("langId");
    var _body = {"action": "getLoginscreen", "lang": "$lanId"};

    print("Request data from getLang action : $_body");

    try {
      var response = await http.post(Uri.parse(Utils.apiUrl), body: _body);

      if (response.statusCode == 200) {
        final responseBody = response.body;
        langMap = json.decode(responseBody); // Now correctly expecting a Map
        print("Decoded langMap: $langMap");
      } else {
        print('Failed to load data. Status code: ${response.statusCode}');
        throw Exception("Failed to load data from server");
      }
    } catch (e) {
      print("Exception occurred in getLanguage: $e");
    }

    return langMap;
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

  Future<dynamic> getDroneList(String type) async {      // sale : type = 1, rental : type = 2

    pref = await SharedPreferences.getInstance();
    var userId = pref.getString("userId") ?? "";

    var responseData;

    var _body = {"action": "getDroneList", "user_id": userId, "type": type};

    var response = await http.post(Uri.parse(Utils.liveLocal_Url), body: _body);

    print('Request data from getDroneList $_body');

    try {
      if (response.statusCode == 200) {
        final responseBody = response.body;
        responseData = json.decode(responseBody);
        print('Response data from getDroneList $responseData');
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

  Future<dynamic> addDrone(
    String dgcaApproval,
    String selectedPurposeId,
    String amount,
    String batteryCapacity,
    String weight,
    String model,
    String f_hours,
    String f_minutes,
    String c_hours,
    String c_minutes,
    String description,
    String type,
    Map<String, File?> images,
  ) async {
    pref = await SharedPreferences.getInstance();
    var mobile_number = pref.getString("mobile_number") ?? "";
    var userId = pref.getString("userId") ?? "";

    // Prepare multipart request
    var request = http.MultipartRequest('POST', Uri.parse(Utils.apiUrl));
    request.fields.addAll({
      "action": "addDrone",
      "user_id": userId,
      "DGCA_approval": dgcaApproval,
      "model": model,
      "type": type,
      "purpose": selectedPurposeId,
      "charging_time": "${f_hours}h : ${f_minutes}m",
      "flying_time": "${c_hours}h : ${c_minutes}m",
      "rental_terms": description,
      "price": amount,
      "tags": "",
      "discounts": "",
      "drone_weight": weight,
      "battery_capacity": "${batteryCapacity}mAh",
      "lat": "",
      "long": "",
      "ratings": "",
      "price_type": "",
      "availability": "",
      "insurance_details": "",
      "damage_report": "",
      "pickup_location": "",
      "delivery_method": "",
    });

    // Map your image field keys
    Map<String, String> imageFieldMap = {
      'top': 'image1',
      'right': 'image2',
      'left': 'image3',
      'full': 'image4',
    };

    for (String key in images.keys) {
      final imageFile = images[key];
      final fieldKey = imageFieldMap[key];

      if (imageFile != null && fieldKey != null) {
        final mimeType = lookupMimeType(imageFile.path)?.split('/');
        if (mimeType != null && mimeType.length == 2) {
          request.files.add(await http.MultipartFile.fromPath(
            fieldKey,
            imageFile.path,
            contentType: MediaType(mimeType[0], mimeType[1]),
          ));
        }
      }
    }

    print("Request Data From LoginData : ${request.fields}");

    try {
      var response = await request.send();
      if (response.statusCode == 200) {
        final responseBody = await response.stream.bytesToString();
        var responseData = json.decode(responseBody);
        print("Response data from LoginData : $responseData");
        return responseData;
      } else {
        print(
          'Failed to load data. Server responded with status code: ${response.statusCode}',
        );
        throw Exception("Failed to load data for Internal Server Error");
      }
    } catch (e) {
      print('Exception occurred: $e');
      throw Exception("Failed to load data due to an exception");
    }
  }
}
