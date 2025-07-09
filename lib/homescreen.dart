import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'buildPilotTile.dart';
import 'category_tile.dart';
import 'drone_card.dart';
import 'drone_model.dart';

class HomeScreen extends StatelessWidget {
  int _selectedIndex = 0;
  final List<Map<String, dynamic>> categories = [
    {"icon": Icons.shopping_cart, "label": "Buy/Sell Drones"},
    {"icon": Icons.settings, "label": "parts & accessories"},
    {"icon": Icons.person, "label": "Hire Pilots"},
    {"icon": Icons.build, "label": "Drone Services"},
    {"icon": Icons.school, "label": "Training"},
    {"icon": Icons.support, "label": "Maintenance"},
    {"icon": Icons.work, "label": "Jobs Portal"},
    {"icon": Icons.rule, "label": "Regulatory"},
  ];

  final List<DroneModel> featuredDrones = [
    DroneModel(name: "DJI Mavic 3 Pro", price: "25500", image: "assets/images/MaskGroup34@2x.png", rating: 4.5),
    DroneModel(name: "Autel EVO Lite+", price: "12000", image: "assets/images/MaskGroup38@2x.png", rating: 4.0),
  ];
  void _onTabTapped(int index) {
    // setState(() {
    //   _selectedIndex = index;
    // });
    // You can implement screen switching here.
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: ListView(
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
                      )

                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center, // Horizontal center
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset('assets/images/flyHub_logo.svg',
                        width: 50,
                        height: 50,
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
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                ],
              ),
            ),
            GridView.count(
              padding: EdgeInsets.all(16),
              crossAxisCount: 4,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              children: categories.map((c) => CategoryTile(icon: c['icon'], label: c['label'])).toList(),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: ElevatedButton.icon(
                onPressed: () {},
                icon: Icon(Icons.store),
                label: Text("Register as a seller/services provider", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold,color: Colors.white)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  shape: StadiumBorder(),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text("Featured Drones", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ),
            SizedBox(
              height: 220,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: featuredDrones.length,
                itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: DroneCard(drone: featuredDrones[index]),
                ),
              ),
            ),


            // Pesticide Spraying Banner
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
                          Text("Pesticide Spraying ", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                          SizedBox(height: 4),
                          Text("Farmers can hire drone service from service providers on a pay-per-use model.",
                              style: TextStyle(color: Colors.white70, fontSize: 12)),
                        ],
                      ),
                    ),
                    SizedBox(width: 10),
                    //Image.asset("assets/banner.png", width: 80),
                  ],
                ),
              ),
            ),

// Top Rated Pilots
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text("Top Rated Pilots", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            ),
            ListView(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              children: [
                PilotTile(name: "Amirthakumar AK", role: "Aerial Photography Specialist", imagePath: "assets/images/flyHub_logo.svg", rating: 4.5),
                PilotTile(name: "Jeevanantham P", role: "Real Estate & Construction Expert", imagePath: "assets/images/flyHub_logo.svg", rating: 4.0),
                PilotTile(name: "Aravinth", role: "Cinematography & Film Production", imagePath: "assets/images/flyHub_logo.svg", rating: 5.0),
              ],
            ),

            // Upcoming Events
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Text("Upcoming Events (News)", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(color: Colors.grey.shade300, blurRadius: 5, offset: Offset(0, 2))
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
                          fit: BoxFit.cover, // ensures it fills the width without distortion
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("International Drone Racing Championship",
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          SizedBox(height: 4),
                          Row(
                            children: [
                              Icon(Icons.calendar_month, size: 16, color: Colors.grey),
                              SizedBox(width: 6),
                              Text("June 30, 2025")
                            ],
                          ),
                          SizedBox(height: 4),
                          Row(
                            children: [
                              Icon(Icons.location_on, size: 16, color: Colors.grey),
                              SizedBox(width: 6),
                              Text("San Francisco, CA")
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
                              child: Text("Register Now",style: TextStyle(color:  Colors.white),),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),


            // Drone Rentals Section
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text("Drone Rentals", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Expanded(
                    child: Card(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(12),
                              topRight: Radius.circular(12),
                            ),
                            child: Image.asset("assets/images/MaskGroup34@2x.png", height: 100, width: double.infinity, fit: BoxFit.cover),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("DJI Mini 3 Pro", style: TextStyle(fontWeight: FontWeight.bold)),
                                Text("4K Camera, 38min Flight"),
                                SizedBox(height: 4),
                                Text("₹800/hour", style: TextStyle(color: Colors.orange)),
                                Text("₹2,500/day", style: TextStyle(color: Colors.deepPurple)),
                                Text("Insurance ✅"),
                                SizedBox(height: 6),
                                SizedBox(
                                  width: double.infinity,
                                  child: ElevatedButton(
                                    onPressed: () {},
                                    style: ElevatedButton.styleFrom(backgroundColor: Colors.deepPurple),
                                    child: Text("Book Now", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16,color: Colors.white)),
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: Card(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(12),
                              topRight: Radius.circular(12),
                            ),
                            child: Image.asset("assets/images/MaskGroup38@2x.png", height: 100, width: double.infinity, fit: BoxFit.cover),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Mavic Air 2", style: TextStyle(fontWeight: FontWeight.bold)),
                                Text("4K Camera, 34min Flight"),
                                SizedBox(height: 4),
                                Text("₹800/hour", style: TextStyle(color: Colors.orange)),
                                Text("₹2,500/day", style: TextStyle(color: Colors.deepPurple)),
                                Text("Insurance ✅"),
                                SizedBox(height: 6),
                                SizedBox(
                                  width: double.infinity,
                                  child: ElevatedButton(
                                    onPressed: () {},
                                    style: ElevatedButton.styleFrom(backgroundColor: Colors.deepPurple),
                                    child: Text("Book Now", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16,color: Colors.white)),
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),

            SizedBox(height: 20),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onTabTapped,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.deepPurple,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_bag), label: 'Market'),
          BottomNavigationBarItem(icon: Icon(Icons.person_pin), label: 'Pilot'),
          BottomNavigationBarItem(icon: Icon(Icons.car_rental), label: 'Rentals'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}
