import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flyhub/CommonClass/ApiClass.dart';
import 'package:flyhub/CommonClass/Utils.dart';
import 'package:flyhub/Login/MobileLogin.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Selectlanguage extends StatefulWidget {
  const Selectlanguage({super.key});

  @override
  State<Selectlanguage> createState() => _SelectlanguageState();
}

class _SelectlanguageState extends State<Selectlanguage> {
  final ApiClass _apiClass = ApiClass();

  var languageList = [];

  int selectedIndex = -1;

  bool isInternet = true;

  late SharedPreferences pref;

  @override
  void initState() {
    super.initState();
    getLanguage();
  }

  Future<void> getLanguage() async {
    if (await Utils.checkInternetConnection()) {
      isInternet = true;
      languageList = await _apiClass.getLanguage();
    } else {
      isInternet = false;
    }

    setState(() {});

    print('languageList : $languageList');
  }

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: w * 0.07,
            vertical: h * 0.05,
          ),
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
                        style: GoogleFonts.lexend(
                          fontSize: w * 0.055,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: h * 0.005),
                      Text(
                        'Update of preferred language for your mobile app use',
                        style: GoogleFonts.lexend(
                          fontSize: w * 0.035,
                          color: Colors.grey,
                        ),
                      ),
                      SizedBox(height: h * 0.035),

                      SizedBox(
                        height: h * 0.65,
                        child: languageList.isEmpty
                            ? Center(child: CircularProgressIndicator())
                            : !isInternet
                            ? Center(child: CircularProgressIndicator())
                            : GridView.builder(
                                shrinkWrap: true,
                                padding: EdgeInsets.zero,
                                physics: AlwaysScrollableScrollPhysics(),
                                itemCount: languageList.length,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      childAspectRatio: 1.2,
                                      crossAxisSpacing: 15,
                                      mainAxisSpacing: 15,
                                    ),
                                itemBuilder: (context, i) {
                                  final lang = languageList[i];
                                  final isSel = i == selectedIndex;
                                  return GestureDetector(
                                    onTap: () async {
                                      pref =
                                          await SharedPreferences.getInstance();
                                      pref.setInt("langId", lang['id']);

                                      setState(() {
                                        selectedIndex = i;
                                      });
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Color(0xFFE7F3EF),
                                        borderRadius: BorderRadius.circular(12),
                                        border: isSel
                                            ? Border.all(
                                                color: Color(0xFF7049EC),
                                                width: 2,
                                              )
                                            : null,
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          SvgPicture.network(
                                            lang['img'],
                                            width: w * 0.12,
                                            height: w * 0.12,
                                            placeholderBuilder: (context) =>
                                                CircularProgressIndicator(),
                                            fit: BoxFit.contain,
                                            //semanticsLabel: lang['label'],
                                            clipBehavior: Clip.antiAlias,
                                          ),

                                          SizedBox(height: 8),

                                          Text(
                                            lang['name'],
                                            style: GoogleFonts.lexend(
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
                      ),
                    ],
                  ),
                ),
              ),

              // Button stays at the bottom
              SizedBox(
                width: double.infinity,
                height: h * 0.065,
                child: ElevatedButton(
                  onPressed: () {
                    if (selectedIndex >= 0) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Mobilelogin()),
                      );
                    } else {
                      Utils.bottomtoast(context, "Choose Your Language");
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF7049EC),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: Text(
                    'Continue in English',
                    style: GoogleFonts.lexend(
                      fontSize: w * 0.045,
                      color: Colors.white,
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
