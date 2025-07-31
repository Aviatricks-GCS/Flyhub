import 'dart:async';

import 'package:flutter/material.dart';

import 'package:flyhub/Login/SelectLanguage.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../HomeScreen/Dynamichome.dart';
import 'OrderCenterPage.dart';

class OrderSuccessPage extends StatefulWidget {
  const OrderSuccessPage({super.key});

  @override
  State<OrderSuccessPage> createState() => _OrderSuccessPageState();
}

class _OrderSuccessPageState extends State<OrderSuccessPage> {
  Timer? _timer;
  late SharedPreferences pref;

  @override
  void initState() {
    super.initState();

    _timer = Timer(Duration(milliseconds: 3000), () async {
      if (!mounted) return;
      //bool isFirstLaunch = pref.getBool('isFirstLaunch') ?? true;
      navigateToNextPage();
    });
  }

  Future<void> navigateToNextPage() async {
    Navigator.pop(context);
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
                      'assets/images/Order.svg',
                      width: screenWidth * 0.55, // 50% of screen width
                    ),
                    SizedBox(height: screenHeight * 0.015),
                    Text(
                      'Your Order Has Been Placed Successfully',
                      style: GoogleFonts.lexend(
                        fontSize: screenWidth * 0.035,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff131313),
                      ),
                    ),
                    Text(
                      'Your items has been placcd and is on it’s way to being processed',
                      style: GoogleFonts.lexend(
                        fontSize: screenWidth * 0.020,
                        color: Color(0xff9F9F9F),
                      ),
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
