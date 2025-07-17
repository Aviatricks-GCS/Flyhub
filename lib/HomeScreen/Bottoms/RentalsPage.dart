import 'package:flutter/material.dart';
import '../../CommonClass/ApiClass.dart';
import '../../CommonClass/Utils.dart';

class RentalsPage extends StatefulWidget {
  @override
  State<RentalsPage> createState() => _RentalsPageState();
}

class _RentalsPageState extends State<RentalsPage> with TickerProviderStateMixin {
  late TabController _mainTabController;
  final List<String> subFilters = ['Today', 'Professional', 'With Pilot', 'Insured'];
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
      var response = await _apiClass.getDroneList();
      print('Response from getDroneList: $response');

      if (response != null && response['status'] == 'success') {
        setState(() {
          droneList = response['data'] ?? [];
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
          return Chip(
            label: Text(subFilters[index]),
            backgroundColor: Colors.grey[200],
            labelStyle: TextStyle(color: Colors.black),
          );
        },
      ),
    );
  }

  Widget buildRentalCard(Map<String, dynamic> drone) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      elevation: 4,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(12), bottom: Radius.circular(12)),
                  child: Image.asset(
                    'assets/images/MaskGroup34@2x.png',
                    height: 100,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text('9.2 km away', style: TextStyle(color: Colors.white, fontSize: 10)),
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(drone['name'] ?? 'Drone Name', style: TextStyle(fontWeight: FontWeight.bold)),
                Text(drone['specs'] ?? 'Specifications', style: TextStyle(fontSize: 10, color: Colors.grey[700])),
                SizedBox(height: 4),
                Column(
                  children: [
                    Row(
                      children: [
                        Text('₹${drone['price_per_hour'] ?? '0'}', style: TextStyle(color: Colors.grey[700])),
                        Text('/hour', style: TextStyle(fontSize: 10, color: Colors.deepOrange)),
                      ],
                    ),
                    SizedBox(width: 10),
                    Row(
                      children: [
                        Text('₹${drone['price_per_day'] ?? '0'}', style: TextStyle(color: Colors.grey[700])),
                        Text('/day', style: TextStyle(fontSize: 10, color: Colors.deepOrange)),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 4),
                if ((drone['insurance'] ?? false) == true)
                  Row(
                    children: [
                      Icon(Icons.check_circle, size: 14, color: Colors.green),
                      SizedBox(width: 4),
                      Text('Insurance', style: TextStyle(fontSize: 10, color: Colors.black)),
                    ],
                  ),
                SizedBox(height: 8),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.purple,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    child: Text('Book Now', style: TextStyle(color: Colors.white)),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Drone Rentals'),
        leading: Icon(Icons.arrow_back),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        bottom: TabBar(
          controller: _mainTabController,
          labelColor: Colors.purple,
          unselectedLabelColor: Colors.grey,
          indicatorColor: Colors.purple,
          tabs: [
            Tab(text: 'Available'),
            Tab(text: 'My Bookings'),
            Tab(text: 'Insurance'),
          ],
        ),
      ),
      body: Column(
        children: [
          SizedBox(height: 10),
          buildSubFilterTabs(),
          Expanded(
            child: droneList.isEmpty
                ? Center(child: Text("No drones available"))
                : GridView.builder(
              padding: EdgeInsets.symmetric(horizontal: 8),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.61,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
              ),
              itemCount: droneList.length,
              itemBuilder: (context, index) {
                return buildRentalCard(droneList[index]);
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.purple,
        onPressed: () {},
        child: Icon(Icons.add),
      ),
    );
  }
}
