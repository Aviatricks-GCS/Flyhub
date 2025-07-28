import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flyhub/FindJobs.dart';
import 'package:flyhub/RegistrationDetails.dart';
import 'package:flyhub/Template/Template1.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../CommonClass/ApiClass.dart';
import '../../CommonClass/Utils.dart';
import '../../Template/Template2.dart';
import '../../Template/Template3.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ApiClass _apiClass = ApiClass();
  int _selectedIndex = 0;
  late SharedPreferences pref;

  var homeData = [];
  bool isInternet = true;
  var icon1 = "";
  var icon2 = "";
  var textdata = "";
  var categories = [];

  var featuredDrones = [];
  var feature = "";

  List<Widget> preloadedWidgets = [];

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    gethomedata();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: isLoading
            ? Center(child: CircularProgressIndicator())
            : ListView(
          children: [
            Container(
              color: Color(0xFF1A0A5B), // dark purple background
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap : (){
                 Navigator.push(context, MaterialPageRoute(builder: (context)=> Findjobs()));
      },
                          child: Icon(Icons.menu, color: Colors.white)),
                      Row(
                        children: [
                          Icon(Icons.shopping_cart, color: Colors.white),
                          SizedBox(width: 20),
                          Icon(Icons.notifications, color: Colors.white),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        'assets/images/flyhubicon.svg',
                        width: 65,
                        height: 65,
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  TextField(
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      prefixIcon: Icon(Icons.search),
                      hintText: "Search drones, pilots, services...",
                      suffixIcon: Icon(Icons.mic),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            ...preloadedWidgets,
          ],
        ),
      ),
    );
  }

  void preloadWidgets() async {
    pref = await SharedPreferences.getInstance();
    List<Widget> widgets = [];

    for (var currentItem in homeData) {
      switch (currentItem['template']) {
        case 'template_1':
          widgets.add(Template1(items: currentItem['items']));
          break;
        case 'template_2':
          widgets.add(
            Template2(
              title : currentItem['title'],
              appBar_title: currentItem['form_top'],
              form_title: currentItem['form_title'],
              rightImg: currentItem['right_img'],
              leftImg: currentItem['left_img'],
              items: currentItem['items'],
            ),
          );
          break;
        case 'template_3':
          widgets.add(
            Template3(
              featureTitle: currentItem['title'] ?? '',
              featuredDrones: currentItem['items'],
            ),
          );
          break;

        default:
          widgets.add(SizedBox.shrink());
          break;
      }
    }

    if (mounted) {
      setState(() {
        preloadedWidgets = widgets;
      });
    }
  }

  Future<dynamic> gethomedata() async {
    if (await Utils.checkInternetConnection()) {
      isInternet = true;
      isLoading = true;
      var response = await _apiClass.gethomedata();
      if (response["status"] == "success" && response["items"] is List) {
        homeData = response["items"];
        isLoading = false;
        setState(() {});
      } else {
        print("Unexpected data format: ${response['items']}");
      }
      preloadWidgets();
    } else {
      isInternet = false;
      Utils.bottomtoast(context, "Check your Internet Connection");
    }
  }

}

/*ListView(
          children: [
            Container(
              color: Colors.indigo[900],
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(Icons.menu, color: Colors.white),
                      Row(
                        children: [
                          Icon(Icons.shopping_cart, color: Colors.white),
                          SizedBox(width: 20),
                          Icon(Icons.notifications, color: Colors.white),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    // Horizontal center
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        'assets/images/flyhubicon.svg',
                        width: 65,
                        height: 65,
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  TextField(
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      prefixIcon: Icon(Icons.search),
                      hintText: "Search drones, pilots, services...",
                      suffixIcon: Icon(Icons.mic),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            //Template 1 Design
            GridView.count(
              padding: EdgeInsets.all(16),
              crossAxisCount: 4,
              childAspectRatio: 0.7,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              children: categories
                  .map((c) => CategoryTile(icon: c['image'], label: c['cname']))
                  .toList(),
            ),

            //Template 2 Design
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.network(
                      icon1,
                      width: 24,
                      height: 24,
                      fit: BoxFit.contain,
                    ),
                    SizedBox(width: 8),
                    Text(
                      textdata,
                      maxLines: 2,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(width: 8),
                    Image.network(
                      icon2,
                      width: 24,
                      height: 24,
                      fit: BoxFit.contain,
                    ),
                  ],
                ),
              ),
            ),

            //Template 3 Design
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: Text(
                "${feature}",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            GridView.count(
              padding: EdgeInsets.all(16),
              crossAxisCount: 2,
              childAspectRatio: 0.75,
              // Adjust as needed for extra text height
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              children: featuredDrones.map((c) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    DroneCard(
                      title: c['title'],
                      price: c['price'],
                      image: c['img'],
                      rating: c['rating'],
                    ),
                  ],
                );
              }).toList(),
            ),

            //Template 4 Design
            Padding(
              padding: const EdgeInsets.all(16),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.teal.shade600,
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: EdgeInsets.all(16),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Pesticide Spraying ",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            "Farmers can hire drone service from service providers on a pay-per-use model.",
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 10),
                    //Image.asset("assets/banner.png", width: 80),
                  ],
                ),
              ),
            ),

            //Template 5 Design
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                "Top Rated Pilots",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ),
            ListView(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              children: [
                PilotTile(
                  name: "Amirthakumar AK",
                  role: "Aerial Photography Specialist",
                  imagePath: "assets/images/flyHub_logo.svg",
                  rating: 4.5,
                ),
                PilotTile(
                  name: "Jeevanantham P",
                  role: "Real Estate & Construction Expert",
                  imagePath: "assets/images/flyHub_logo.svg",
                  rating: 4.0,
                ),
                PilotTile(
                  name: "Aravinth",
                  role: "Cinematography & Film Production",
                  imagePath: "assets/images/flyHub_logo.svg",
                  rating: 5.0,
                ),
              ],
            ),

            //Template 6 Design
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Text(
                "Upcoming Events (News)",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade300,
                      blurRadius: 5,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(12),
                        topRight: Radius.circular(12),
                      ),
                      child: SizedBox(
                        width: double.infinity,
                        child: Image.asset(
                          "assets/images/MaskGroup38@2x.png",
                          fit: BoxFit
                              .cover, // ensures it fills the width without distortion
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "International Drone Racing Championship",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 4),
                          Row(
                            children: [
                              Icon(
                                Icons.calendar_month,
                                size: 16,
                                color: Colors.grey,
                              ),
                              SizedBox(width: 6),
                              Text("June 30, 2025"),
                            ],
                          ),
                          SizedBox(height: 4),
                          Row(
                            children: [
                              Icon(
                                Icons.location_on,
                                size: 16,
                                color: Colors.grey,
                              ),
                              SizedBox(width: 6),
                              Text("San Francisco, CA"),
                            ],
                          ),
                          SizedBox(height: 8),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.deepPurple,
                                shape: StadiumBorder(),
                              ),
                              child: Text(
                                "Register Now",
                                style: TextStyle(color: Colors.white),
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
            SizedBox(height: 20),

            //Template 7 Design
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                "Drone Rentals",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Expanded(
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(12),
                              topRight: Radius.circular(12),
                            ),
                            child: Image.asset(
                              "assets/images/MaskGroup34@2x.png",
                              height: 100,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "DJI Mini 3 Pro",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text("4K Camera, 38min Flight"),
                                SizedBox(height: 4),
                                Text(
                                  "₹800/hour",
                                  style: TextStyle(color: Colors.orange),
                                ),
                                Text(
                                  "₹2,500/day",
                                  style: TextStyle(color: Colors.deepPurple),
                                ),
                                Text("Insurance ✅"),
                                SizedBox(height: 6),
                                SizedBox(
                                  width: double.infinity,
                                  child: ElevatedButton(
                                    onPressed: () {},
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.deepPurple,
                                    ),
                                    child: Text(
                                      "Book Now",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                        color: Colors.white,
                                      ),
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
                  SizedBox(width: 12),
                  Expanded(
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(12),
                              topRight: Radius.circular(12),
                            ),
                            child: Image.asset(
                              "assets/images/MaskGroup38@2x.png",
                              height: 100,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Mavic Air 2",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text("4K Camera, 34min Flight"),
                                SizedBox(height: 4),
                                Text(
                                  "₹800/hour",
                                  style: TextStyle(color: Colors.orange),
                                ),
                                Text(
                                  "₹2,500/day",
                                  style: TextStyle(color: Colors.deepPurple),
                                ),
                                Text("Insurance ✅"),
                                SizedBox(height: 6),
                                SizedBox(
                                  width: double.infinity,
                                  child: ElevatedButton(
                                    onPressed: () {},
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.deepPurple,
                                    ),
                                    child: Text(
                                      "Book Now",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                        color: Colors.white,
                                      ),
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
                ],
              ),
            ),

            SizedBox(height: 20),
          ],
        ),
      */