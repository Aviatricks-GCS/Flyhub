import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  int _secondsRemaining = 30;
  late final TextEditingController _otpController;
  late final Timer _timer;
  late SharedPreferences pref;

  var mobile_number = "";

  @override
  void initState() {
    super.initState();
    _otpController = TextEditingController();
    _startTimer();
    _getMobileNumber();
  }

  Future<void> _getMobileNumber() async {
    pref = await SharedPreferences.getInstance();
    mobile_number = pref.getString("mobile_number") ?? "";
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsRemaining == 0) {
        _timer.cancel();
      } else {
        setState(() {
          _secondsRemaining--;
        });
      }
    });
  }

  @override
  void dispose() {
    _otpController.dispose();
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: w * 0.08),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/images/otp_screen_img.png', width: w * 0.8),

              SizedBox(height: h * 0.03),

              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Verify Details',
                  style: GoogleFonts.lexend(
                    fontSize: w * 0.06,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              SizedBox(height: h * 0.005),

              Row(
                children: [
                  Expanded(
                    child: Text.rich(
                      TextSpan(
                        text: 'OTP will send vis SMS to ',
                        style: GoogleFonts.lexend(
                          color: Colors.black87,
                          fontSize: w * 0.035,
                        ),
                        children: [
                          TextSpan(
                            text: '$mobile_number',
                            style: GoogleFonts.lexend(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: w * 0.035,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Icon(Icons.edit, size: 18),
                ],
              ),

              SizedBox(height: h * 0.03),

              TextField(
                controller: _otpController,
                keyboardType: TextInputType.number,
                maxLength: 6,
                decoration: InputDecoration(
                  counterText: '',
                  hintText: 'Enter OTP',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),

              SizedBox(height: h * 0.03),

              SizedBox(
                width: double.infinity,
                height: h * 0.06,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF7049EC),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    'Verify OTP',
                    style: GoogleFonts.lexend(color: Colors.white),
                  ),
                ),
              ),

              SizedBox(height: h * 0.02),

              Text.rich(
                TextSpan(
                  text: 'Resend OTP after ',
                  style: GoogleFonts.lexend(
                    color: Colors.black38,
                    fontSize: w * 0.035,
                  ),
                  children: [
                    TextSpan(
                      text:
                          '${_secondsRemaining.toString().padLeft(2, '0')} sec',
                      style: GoogleFonts.lexend(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: w * 0.035,
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
