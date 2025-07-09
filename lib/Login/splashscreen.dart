import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flyhub/Login/SelectLanguage.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();

    /*_timer = Timer(Duration(milliseconds: 5000), () async {
      if (!mounted) return;
      //bool isFirstLaunch = pref.getBool('isFirstLaunch') ?? true;
      navigateToNextPage();
    });*/

  }

  void navigateToNextPage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Selectlanguage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // clean white background
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            const Spacer(),

            // Centered Logo
            SvgPicture.asset('assets/images/flyHub_logo.svg',
              width: 200,
              height: 100,
            ),

            const SizedBox(height: 8),


            const Text(
              'your complete drone ecosystem',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),

            const Spacer(),

            // Powered by Section
            Column(
              children: [
                const Text(
                  'powered by',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 4),
                SvgPicture.asset(
                  'assets/images/flytutor_logo.svg',
                  width: 100,
                  height: 40,
                ),
              ],
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

}
