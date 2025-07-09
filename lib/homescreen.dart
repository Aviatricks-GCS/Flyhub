import 'package:flutter/material.dart';

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
    DroneModel(name: "DJI Mavic 3 Pro", price: "25500", image: "assets/drone1.png", rating: 4.5),
    DroneModel(name: "Autel EVO Lite+", price: "12000", image: "assets/drone2.png", rating: 4.0),
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
                      Image.asset("assets/logo.png", height: 30),
                      Icon(Icons.shopping_cart, color: Colors.white),
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
                PilotTile(name: "Amirthakumar AK", role: "Aerial Photography Specialist", imagePath: "assets/p1.jpg", rating: 4.5),
                PilotTile(name: "Jeevanantham P", role: "Real Estate & Construction Expert", imagePath: "assets/p2.jpg", rating: 4.0),
                PilotTile(name: "Aravinth", role: "Cinematography & Film Production", imagePath: "assets/p3.jpg", rating: 5.0),
              ],
            ),

            // Upcoming Events
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Text("Upcoming Events (News)", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            ),
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
