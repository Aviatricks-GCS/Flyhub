import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flyhub/HomeScreen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinput/pinput.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../CommonClass/ApiClass.dart';
import '../CommonClass/Utils.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  int _secondsRemaining = 30;
  Timer? _timer;
  late SharedPreferences pref;

  final ApiClass _apiClass = ApiClass();

  var mobile_number = "";

  final defaultPinTheme = PinTheme(
    width: 50,
    height: 50,
    textStyle: TextStyle(
      fontSize: 20,
      color: Colors.white,
      fontWeight: FontWeight.w600,
    ),
    decoration: BoxDecoration(
      border: Border.all(color: Colors.grey),
      borderRadius: BorderRadius.circular(8),
    ),
    margin: const EdgeInsets.symmetric(horizontal: 9),
  );

  late PinTheme focusedPinTheme;

  late PinTheme submittedPinTheme;

  // You can use a TextEditingController to retrieve the input
  final TextEditingController _pinController = TextEditingController();

  @override
  void initState() {
    super.initState();

    _startTimer();
    _getMobileNumber();

    _initializePinThemes();
  }

  Future<void> _getMobileNumber() async {
    pref = await SharedPreferences.getInstance();
    mobile_number = pref.getString("mobile_number") ?? "";
    setState(() {});
  }

  void _startTimer() {
    _timer?.cancel();
    _secondsRemaining = 30;

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsRemaining == 0) {
        _timer?.cancel();
      } else {
        setState(() {
          _secondsRemaining--;
        });
      }
    });
  }

  void _initializePinThemes() {
    focusedPinTheme = defaultPinTheme.copyWith(
      textStyle: const TextStyle(
        fontSize: 20,
        color: Colors.black,
        fontWeight: FontWeight.w600,
      ),
      decoration: defaultPinTheme.decoration!.copyWith(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8),
      ),
    );

    submittedPinTheme = defaultPinTheme.copyWith(
      textStyle: const TextStyle(
        fontSize: 20,
        color: Colors.white,
        fontWeight: FontWeight.w600,
      ),
      decoration: BoxDecoration(
        color: Colors.green,
        borderRadius: BorderRadius.circular(8),
        border: null,
      ),
    );
  }

  @override
  void dispose() {

    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              physics: const BouncingScrollPhysics(),
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/otp_screen_img.png',
                        width: double.infinity,
                      ),

                      SizedBox(height: h * 0.03),

                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: w * 0.08),
                        child: Column(
                          children: [
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
                                Text.rich(
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

                                SizedBox(width: 2),

                                InkWell(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(bottom: 3.0),
                                    child: const Icon(Icons.edit, size: 18),
                                  ),
                                ),
                              ],
                            ),

                            SizedBox(height: h * 0.03),

                            Pinput(
                              length: 4,
                              controller: _pinController,
                              defaultPinTheme: defaultPinTheme,
                              focusedPinTheme: focusedPinTheme,
                              submittedPinTheme: submittedPinTheme,
                              //onCompleted: _submitOtp,
                              // Optional: Customize cursor
                              showCursor: true,

                              cursor: Container(
                                width: 2,
                                height: 24,
                                color: Colors.black, // Cursor color
                              ),
                              isCursorAnimationEnabled: false,
                              // Optional: Add animation
                              //animationType: AnimationType.scale,
                              // Optional: Auto focus
                              autofocus: true,
                              // Optional: Obscure the input
                              obscureText: false,
                              keyboardType: TextInputType.number,
                              // Allow only digits to be entered
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                              // Optional: Define validator
                              /* validator: (value) {
                              // Example validation
                              return value!.length == 6 ? null : 'Enter all 6 digits';
                            },*/
                            ),

                            SizedBox(height: h * 0.06),

                            SizedBox(
                              width: w * 0.6,
                              height: h * 0.06,
                              child: ElevatedButton(
                                onPressed: () async {
                                  if (await Utils.checkInternetConnection()) {
                                    var response = await _apiClass.verifyOTP(
                                      _pinController.text,
                                    );

                                    if (response[0]["status"] == "success") {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => Homepage(),
                                        ),
                                      );
                                    } else {
                                      print('Response Not Success');
                                    }
                                  } else {
                                    Utils.bottomtoast(
                                      context,
                                      "Check Your Internet Connection",
                                    );
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF7057FF),
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

                            InkWell(
                              onTap: _secondsRemaining == 0
                                  ? () async {
                                      if (await Utils.checkInternetConnection()) {
                                        _startTimer();
                                        await _apiClass.getOtp(mobile_number);
                                      } else {
                                        Utils.bottomtoast(
                                          context,
                                          "Check Your Internet Connection",
                                        );
                                      }
                                    }
                                  : null, // disables tap while timer is active
                              child: Text.rich(
                                TextSpan(
                                  text: 'Resend OTP ',
                                  style: GoogleFonts.lexend(
                                    color: _secondsRemaining > 0
                                        ? Colors.black38
                                        : Colors.black,
                                    fontSize: w * 0.04,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  children: _secondsRemaining > 0
                                      ? [
                                          TextSpan(
                                            text: 'after ',
                                            style: GoogleFonts.lexend(
                                              color: Colors.black38,
                                              fontSize: w * 0.035,
                                            ),
                                          ),
                                          TextSpan(
                                            text:
                                                '${_secondsRemaining.toString()} sec',
                                            style: GoogleFonts.lexend(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                              fontSize: w * 0.035,
                                            ),
                                          ),
                                        ]
                                      : [],
                                ),
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
          },
        ),
      ),
    );
  }
}
