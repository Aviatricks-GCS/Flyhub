import 'package:flutter/material.dart';

class RentalsPage extends StatefulWidget {
  @override
  State<RentalsPage> createState() => _RentalsPageState();
}

class _RentalsPageState extends State<RentalsPage> with TickerProviderStateMixin {
  late TabController _mainTabController;
  final List<String> subFilters = ['Today', 'Professional', 'With Pilot', 'Insured'];

  @override
  void initState() {
    super.initState();
    _mainTabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _mainTabController.dispose();
    super.dispose();
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

  Widget buildRentalCard(String name, String specs, String imageUrl) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      elevation: 4,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                child: Image.asset(imageUrl, height: 100, width: double.infinity, fit: BoxFit.cover),
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
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: TextStyle(fontWeight: FontWeight.bold)),
                Text(specs, style: TextStyle(fontSize: 12, color: Colors.grey[700])),
                SizedBox(height: 4),
                Row(
                  children: [
                    Text('₹800', style: TextStyle(color: Colors.black)),
                    Text('/hour', style: TextStyle(fontSize: 12, color: Colors.grey[700])),
                    SizedBox(width: 10),
                    Text('₹2,500', style: TextStyle(color: Colors.deepOrange)),
                    Text('/day', style: TextStyle(fontSize: 12, color: Colors.grey[700])),
                  ],
                ),
                SizedBox(height: 4),
                Row(
                  children: [
                    Icon(Icons.check_circle, size: 14, color: Colors.green),
                    SizedBox(width: 4),
                    Text('Insurance', style: TextStyle(fontSize: 12, color: Colors.black)),
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
                    child: Text('Book Now'),
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
            child: GridView.count(
              crossAxisCount: 2,
              childAspectRatio: 0.70,
              children: [
                buildRentalCard('DJI Mini 3 Pro', '4K Camera, 34min flight', 'assets/images/MaskGroup34@2x.png'),
                buildRentalCard('Mavic Air 2', '4K Camera, 34min flight', 'assets/images/MaskGroup38@2x.png'),
              ],
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
