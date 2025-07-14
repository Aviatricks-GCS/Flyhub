import 'package:flutter/material.dart';
import 'package:flyhub/Login/splashscreen.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'CommonClass/Utils.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late SharedPreferences prefs;


  @override
  void initState() {
    deviceDetails();
    super.initState();
  }

  Future<void> deviceDetails() async {
    prefs = await SharedPreferences.getInstance();
    bool isFirstLaunch = prefs.getBool('firstLaunch') ?? true;
    if (isFirstLaunch) {
      print('FirstLaunch');
      if (await Utils.checkInternetConnection()) {

        var packageInfo = await PackageInfo.fromPlatform();

        var deviceModel = await Utils.getDeviceModel(context);
        var deviceId = await Utils.getDeviceId();
        var deviceVersion = await Utils.checkAndroidVersion();
        var platform = await Utils.platform();
        //var fcmId = await Utils.fcmTokenGet() ?? "";

        var versionCode = packageInfo.buildNumber;

        prefs.setString("deviceModel", deviceModel);
        prefs.setString("deviceId", deviceId);
        //prefs.setString("fcmId", fcmId);
        prefs.setString("deviceVersion", deviceVersion);
        prefs.setString("platform", platform);
        prefs.setString("vCode", versionCode);
      } else {
        prefs.setBool("FCM_Not_generated", true);
        print("fcm token not generated");
      }
      prefs.setBool("firstLaunch", false);
    }
    //print("fcm Token : ${prefs.getString("fcmId")}");
    //installReferrer();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'FlyHub',
      theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),),
      home:  Splashscreen(),
    );
  }
}

