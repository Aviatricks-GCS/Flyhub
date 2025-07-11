import 'package:flutter/material.dart';

class Mobilelogin extends StatefulWidget {
  const Mobilelogin({super.key});

  @override
  State<Mobilelogin> createState() => _MobileloginState();
}

class _MobileloginState extends State<Mobilelogin> {

  final TextEditingController _controller = TextEditingController();
  bool _isAgreed = false;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              SizedBox(height: screenHeight * 0.04),

              // Image at the top
              Center(
                child: Image.asset(
                  'assets/images/mobileLoginscreen_img.png',
                  width: screenWidth * 0.97,
                  fit: BoxFit.contain,
                ),
              ),

              SizedBox(height: screenHeight * 0.03),

              Padding(
                padding:  EdgeInsets.symmetric(horizontal: screenWidth * 0.07),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Login Title
                    Text(
                      'Login',
                      style: TextStyle(
                        fontSize: screenWidth * 0.05,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),

                    SizedBox(height: screenHeight * 0.01),

                    Text(
                      'Please enter your mobile number',
                      style: TextStyle(
                        fontSize: screenWidth * 0.035,
                        color: Colors.grey[700],
                      ),
                    ),

                    SizedBox(height: screenHeight * 0.02),

                    // Mobile Input Field
                    TextField(
                      controller: _controller,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        labelText: 'Mobile Number',
                        hintText: 'eg.9876543210',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),

                    SizedBox(height: screenHeight * 0.02),

                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start, // aligns top of both checkbox and text
                      mainAxisAlignment: MainAxisAlignment.start,   // aligns row to the left
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 4), // aligns checkbox slightly lower
                          child: Checkbox(
                            value: _isAgreed,
                            onChanged: (value) {
                              setState(() {
                                _isAgreed = value ?? false;
                              });
                            },
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 12), // aligns text vertically with checkbox
                            child: Text.rich(
                              TextSpan(
                                text: 'I will Agree to our ',
                                style: TextStyle(fontSize: screenWidth * 0.035),
                                children: [
                                  TextSpan(
                                    text: 'Terms & Conditions',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: screenWidth * 0.035,
                                    ),
                                  ),
                                  TextSpan(text: ' and '),
                                  TextSpan(
                                    text: 'Privacy Policy',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: screenWidth * 0.035,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: screenHeight * 0.03),

                    // Continue Button
                    SizedBox(
                      width: double.infinity,
                      height: screenHeight * 0.07,
                      child: ElevatedButton(
                        onPressed: _isAgreed ? () {} : null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF7049EC),
                          disabledBackgroundColor: Colors.grey[400],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Text(
                          'Continue',
                          style: TextStyle(
                            fontSize: screenWidth * 0.045,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: screenHeight * 0.03),
                  ],
                ),
              )

            ],
          ),
        ),
      ),
    );
  }
}
