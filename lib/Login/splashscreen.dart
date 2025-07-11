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

    _timer = Timer(Duration(milliseconds: 3000), () async {
      if (!mounted) return;
      //bool isFirstLaunch = pref.getBool('isFirstLaunch') ?? true;
      navigateToNextPage();
    });

  }

  void navigateToNextPage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Selectlanguage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Stack(
            children: [

              // Centered FlyHub logo and tagline
              Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SvgPicture.asset(
                      'assets/images/flyHub_logo.svg',
                      width: screenWidth * 0.55, // 50% of screen width
                    ),
                    SizedBox(height: screenHeight * 0.015),
                    Text(
                      'your complete drone ecosystem',
                      style: TextStyle(
                        fontSize: screenWidth * 0.035,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff9F9F9F),
                      ),
                    ),
                  ],
                ),
              ),

              // Bottom "powered by" section
              Positioned(
                bottom: screenHeight * 0.06,
                left: 0,
                right: 0,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'powered by',
                      style: TextStyle(
                        fontSize: screenWidth * 0.03,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff9F9F9F),
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.015),
                    SvgPicture.asset(
                      'assets/images/flytutor_logo.svg',
                      width: screenWidth * 0.3,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

}
