import 'package:flutter/material.dart';

import '../../MarketItemCard.dart';

class MarketPage extends StatefulWidget {
  @override
  State<MarketPage> createState() => _MarketPageState();
}

class _MarketPageState extends State<MarketPage> {
  final List<String> filters = ['Under 50K', 'DJI', 'Camera', 'Racing'];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3, // All Drones, Parts, Accessories
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          title: Text("Drone Marketplace"),
          bottom: TabBar(
            indicatorColor: Colors.deepPurple,
            labelColor: Colors.deepPurple,
            unselectedLabelColor: Colors.grey,
            tabs: [
              Tab(text: 'All Drones'),
              Tab(text: 'Parts'),
              Tab(text: 'Accessories'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildDroneTab(context), // All Drones tab
            Center(child: Text("Parts coming soon")),
            Center(child: Text("Accessories coming soon")),
          ],
        ),
      ),
    );
  }
  Widget _buildFilterRow() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          // Under 50K Dropdown
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: Colors.deepPurple.shade50,
            ),
            child: Row(
              children: [
                Text("Under 50K", style: TextStyle(color: Colors.deepPurple, fontWeight: FontWeight.bold)),
                SizedBox(width: 5),
                Icon(Icons.keyboard_arrow_down, size: 18, color: Colors.deepPurple),
              ],
            ),
          ),
          SizedBox(width: 12),

          // DJI
          _buildFilterChip("DJI"),

          // Camera
          _buildFilterChip("Camera"),

          // Racing
          _buildFilterChip("Racing"),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      margin: EdgeInsets.only(right: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Colors.grey.shade200,
      ),
      child: Text(label, style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500)),
    );
  }


  Widget _buildDroneTab(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          _buildFilterRow(),
          SizedBox(height: 16),
          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              childAspectRatio: 0.8,
              children: [
                MarketItemCard(image: "assets/images/MaskGroup38@2x.png", name: "DJI Mini 3 Pro", price: "₹25,500"),
                MarketItemCard(image: "assets/images/MaskGroup34@2x.png", name: "Mavic Air 2", price: "₹52,500"),
                MarketItemCard(image: "assets/images/MaskGroup38@2x.png", name: "Racing Drone FPV", price: "₹62,500"),
                MarketItemCard(image: "assets/images/MaskGroup34@2x.png", name: "Mavic Air 2", price: "₹32,500"),

              ],
            ),
          ),
        ],
      ),
    );
  }
}
