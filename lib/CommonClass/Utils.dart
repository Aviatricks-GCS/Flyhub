import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_udid/flutter_udid.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';





class Utils{

  static var apiUrl = 'https://flyhub.nithra.mobi/api/flyRequest';


  static Widget bottomtoast(BuildContext context, String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 15.0);

    return SizedBox.shrink();
  }


  static Future<bool> checkInternetConnection() async {
    final connectivityResults = await Connectivity().checkConnectivity();

    if (connectivityResults.contains(ConnectivityResult.mobile) || connectivityResults.contains(ConnectivityResult.wifi)) {
      return true;
    } else {
      return false;
    }
  }

  static Future<String> getDeviceId() async {
    String? deviceId = '';
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

    if (Platform.isAndroid) {
      deviceId = await FlutterUdid.udid; // Android device ID
      //print("MobileDeViceId = $deviceId");
    } else if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      deviceId = iosInfo.identifierForVendor;
      //print("MobileDeViceId = $deviceId");// iOS device ID
    }

    return deviceId!;
  }

  // static Future<String?> fcmTokenGet() async {
  //   String? fcmToken;
  //   try {
  //     fcmToken = await FirebaseMessaging.instance.getToken();
  //     if (fcmToken != null) {
  //       print("fcm_token : $fcmToken");
  //     } else {
  //       print("Failed to generate FCM token.");
  //     }
  //   } catch (e) {
  //     print("Error getting FCM token: $e");
  //   }
  //   return fcmToken;
  // }

  static Future<String> checkAndroidVersion() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    var device_version;
    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      device_version = androidInfo.version.release;
      //print('Android : $device_version');
    } else if (Platform.isIOS) {
      var iosInfo = await DeviceInfoPlugin().iosInfo;
      device_version = iosInfo.systemVersion;
    }
    return device_version;
  }

  static platform() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var device_platform;

    if (Platform.isAndroid) {
      device_platform = 'Android';
      var androidInfo = await DeviceInfoPlugin().androidInfo;
      var release = androidInfo.version.release;
      var sdkInt = androidInfo.version.sdkInt;
      var manufacturer = androidInfo.manufacturer;
      var model = androidInfo.model;
      //print('Android $release (SDK $sdkInt), $manufacturer $model');
      // Android 9 (SDK 28), Xiaomi Redmi Note 7
    } else if (Platform.isIOS) {
      device_platform = 'Ios';
      var iosInfo = await DeviceInfoPlugin().iosInfo;
      var systemName = iosInfo.systemName;
      var release = iosInfo.systemVersion;
      var name = iosInfo.name;
      var model = iosInfo.model;
      print('$systemName $release, $name $model');
      // iOS 13.1, iPhone 11 Pro Max iPhone
    }

    return device_platform;
  }


  static Future<String> getDeviceModel(BuildContext context) async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      print(
          "Device : ${androidInfo.model} Version : ${androidInfo.version.release}");
      return androidInfo.model;
    } else if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      return '${iosInfo.name}${iosInfo.systemVersion}';
    }

    return 'Device information not available';
  }

}