import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Selectlanguage extends StatefulWidget {
  const Selectlanguage({super.key});

  @override
  State<Selectlanguage> createState() => _SelectlanguageState();
}

class _SelectlanguageState extends State<Selectlanguage> {
  final languages = [
    {
      'label': 'தமிழ்',
      'asset': 'assets/images/tamil.svg',
      'bg': Color(0xFFEAF3FF),
    },
    {
      'label': 'English',
      'asset': 'assets/images/tamil.svg',
      'bg': Color(0xFFFEEEEE),
    },
    {
      'label': 'ಕನ್ನಡ',
      'asset': 'assets/images/tamil.svg',
      'bg': Color(0xFFFFF3E7),
    },
    {
      'label': 'తెలుగు',
      'asset': 'assets/images/tamil.svg',
      'bg': Color(0xFFEAF3F3),
    },
    {
      'label': 'हिंदी',
      'asset': 'assets/images/tamil.svg',
      'bg': Color(0xFFFFEFEF),
    },
    {
      'label': 'മലയാളം',
      'asset': 'assets/images/tamil.svg',
      'bg': Color(0xFFE9F2F2),
    },
    {
      'label': 'മലയാളം',
      'asset': 'assets/images/tamil.svg',
      'bg': Color(0xFFE9F2F2),
    },
    {
      'label': 'മലയാളം',
      'asset': 'assets/images/tamil.svg',
      'bg': Color(0xFFE9F2F2),
    }
  ];

  int selectedIndex = 1;

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: w * 0.07, vertical: h * 0.05),
          child: Column(
            children: [
              // This Expanded will take all available space and center its child
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min, // Important for centering
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Choose Language',
                        style: TextStyle(
                          fontSize: w * 0.055,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: h * 0.005),
                      Text(
                        'Update of preferred language for your mobile app use',
                        style: TextStyle(
                          fontSize: w * 0.035,
                          color: Colors.grey,
                        ),
                      ),
                      SizedBox(height: h * 0.035),
                      GridView.builder(
                        shrinkWrap: true,
                        padding: EdgeInsets.zero,
                        physics: AlwaysScrollableScrollPhysics(),
                        itemCount: languages.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 1.2,
                          crossAxisSpacing: 15,
                          mainAxisSpacing: 15,
                        ),
                        itemBuilder: (context, i) {
                          final lang = languages[i];
                          final isSel = i == selectedIndex;
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedIndex = i;
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: lang['bg'] as Color,
                                borderRadius: BorderRadius.circular(12),
                                border: isSel
                                    ? Border.all(
                                  color: Color(0xFF7049EC),
                                  width: 2,
                                )
                                    : null,
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(
                                    lang['asset'] as String,
                                    width: w * 0.12,
                                    height: w * 0.12,
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    lang['label'] as String,
                                    style: TextStyle(
                                      fontSize: w * 0.038,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
              // Button stays at the bottom
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: SizedBox(
                  width: double.infinity,
                  height: h * 0.065,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF7049EC),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    child: Text(
                      'Continue in English',
                      style: TextStyle(
                        fontSize: w * 0.045,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );

  }
}
