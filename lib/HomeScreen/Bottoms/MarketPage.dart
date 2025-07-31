import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flyhub/CommonClass/ApiClass.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../CommonClass/Utils.dart';
import '../../DroneDetailPage.dart';
import '../../MarketItemCard.dart';
import '../Dynamichome.dart';

class MarketPage extends StatefulWidget {
  @override
  State<MarketPage> createState() => _MarketPageState();
}

class _MarketPageState extends State<MarketPage>
    with SingleTickerProviderStateMixin {
  late TabController _mainTabController;
  final List<String> subFilters = ['Under 50K', 'DJI', 'Camera', 'Racing'];
  final ApiClass _apiClass = ApiClass();
  List<dynamic> droneList = [];

  @override
  void initState() {
    super.initState();
    _mainTabController = TabController(length: 3, vsync: this);
    getDroneList();
  }

  @override
  void dispose() {
    _mainTabController.dispose();
    super.dispose();
  }

  Future<void> getDroneList() async {
    if (await Utils.checkInternetConnection()) {
      var response = await _apiClass.getDroneList("1");
      print('Response from getDroneList: $response');

      if (response != null && response['status'] == 'success') {
        setState(() {
          droneList = response['items'] ?? [];
        });
      } else {
        print("API did not return success");
      }
    } else {
      print("No internet connection");
    }
  }

  Widget buildSubFilterTabs() {
    return SizedBox(
      height: 40,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 16),
        itemCount: subFilters.length,
        separatorBuilder: (_, __) => SizedBox(width: 10),
        itemBuilder: (context, index) {
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: Color(0xffF7F7F8),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Center(
              child: Text(
                subFilters[index],
                style: GoogleFonts.lexend(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget buildMarketCard(Map<String, dynamic> drone) {
    double screenWidth = MediaQuery.of(context).size.width;

    // Dynamic scaling factors
    double imageHeight = screenWidth * 0.25; // roughly 90 on ~360dp screens
    double titleFontSize = screenWidth * 0.02; // ~14-15sp
    double subtitleFontSize = screenWidth * 0.02; // ~10-11sp
    double ratingIconSize = screenWidth * 0.035; // ~12-14
    double padding = screenWidth * 0.025; // ~8-10

    return GestureDetector(
      onTap: () {
        Utils.bottomtoast(context, "${drone['image1']}");
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DroneDetailPage(Drone: drone),
          ),
        );
      },
      child: Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        margin: EdgeInsets.symmetric(horizontal: padding, vertical: padding),
        elevation: 4,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: padding, vertical: padding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: CachedNetworkImage(
                  imageUrl: drone['image1'],
                  placeholder: (context, url) => SizedBox(
                    height: imageHeight,
                    child: Center(child: CircularProgressIndicator()),
                  ),
                  errorWidget: (context, url, error) => Image.asset(
                    'assets/images/MaskGroup34@2x.png',
                    height: imageHeight,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  height: imageHeight,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),

              // Details
              SizedBox(height: padding),
              Text(
                drone['model'] ?? 'Drone Name',
                style: GoogleFonts.lexend(
                  fontWeight: FontWeight.bold,
                  fontSize: titleFontSize,
                ),
              ),
              SizedBox(height: 2),
              Text(
                drone['specs'] ?? 'Specifications',
                style: GoogleFonts.lexend(
                  fontSize: subtitleFontSize,
                  color: Colors.grey[700],
                ),
              ),
              SizedBox(height: 4),
              Row(
                children: [
                  Icon(Icons.star, size: ratingIconSize, color: Colors.orange),
                  SizedBox(width: 2),
                  Text(
                    "4.5",
                    style: TextStyle(fontSize: subtitleFontSize),
                  ),
                  SizedBox(width: 4),
                  Text(
                    "(686)",
                    style: TextStyle(fontSize: subtitleFontSize, color: Colors.grey),
                  ),
                ],
              ),
              SizedBox(height: 4),
              Text(
                drone['price'] != "" ? "₹${drone['price']}" : "",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: titleFontSize,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Drone Rentals', style: GoogleFonts.lexend()),
        leading: GestureDetector(
          onTap: (){
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                builder: (context) => Dynamichome(selectedIndex: 0),
              ),
                  (Route<dynamic> route) => false,
            );
          },
            child: Icon(Icons.arrow_back)),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        bottom: TabBar(
          controller: _mainTabController,
          labelColor: Color(0xff7057FF),
          unselectedLabelColor: Colors.grey,
          indicatorColor: Color(0xff7057FF),
          tabs: [
            Tab(text: 'All Drones'),
            Tab(text: 'Parts'),
            Tab(text: 'Accessories'),
          ],
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 10),

          Expanded(
            child: droneList.isEmpty
                ? const Center(child: Text("No drones available"))
                : TabBarView(
              controller: _mainTabController,
              children: [
                // Tab 1: With sub filters
                Column(
                  children: [
                    buildSubFilterTabs(),
                    const SizedBox(height: 8),
                    Expanded(
                      child: GridView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.78,
                        ),
                        itemCount: droneList.length,
                        itemBuilder: (context, index) {
                          return buildMarketCard(droneList[index]);
                        },
                      ),
                    ),
                  ],
                ),

                // Tab 2
                GridView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.78,
                  ),
                  itemCount: droneList.length,
                  itemBuilder: (context, index) {
                    return buildMarketCard(droneList[index]);
                  },
                ),

                // Tab 3
                GridView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.78,
                  ),
                  itemCount: droneList.length,
                  itemBuilder: (context, index) {
                    return buildMarketCard(droneList[index]);
                  },
                ),
              ],
            ),
          ),
        ],
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xff7057FF),
        shape: CircleBorder(),
        onPressed: () {},
        child: Icon(Icons.add, color: Colors.white, size: 35),
      ),
    );
  }
}

/*
class _MarketPageState extends State<MarketPage> {
  final List<String> filters = ['Under 50K', 'DJI', 'Camera', 'Racing'];

  final ApiClass _apiClass = ApiClass();

  @override
  void initState() {
    getDroneList();
    super.initState();
  }

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
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
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
              childAspectRatio: 0.75,
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

  Future<void> getDroneList() async {
    if (await Utils.checkInternetConnection()) {
      var response = await _apiClass.getDroneList("1");
      print('Response from getDroneList: $response');

      if (response != null && response['status'] == 'success') {
        setState(() {
          //droneList = response['items'] ?? [];
        });
      } else {
        print("API did not return success");
      }
    } else {
      print("No internet connection");
    }
  }

}
*/
