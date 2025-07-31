import 'package:flutter/material.dart';
import 'package:flyhub/PilotRegistration.dart';

import '../Dynamichome.dart';

class PilotPage extends StatefulWidget {
  @override
  State<PilotPage> createState() => _PilotPageState();
}

class _PilotPageState extends State<PilotPage> with TickerProviderStateMixin {
  late TabController _mainTabController;

  final List<String> filters = ['Photography', 'Survey', 'Agriculture', 'Available Today'];

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Certified Pilots"),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
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
        bottom: TabBar(
          controller: _mainTabController,
          labelColor: Colors.deepPurple,
          unselectedLabelColor: Colors.grey,
          indicatorColor: Colors.deepPurple,
          tabs: [
            Tab(text: 'Near Me'),
            Tab(text: 'Top Rated'),
            Tab(text: 'Specialists'),
          ],
        ),
      ),
      body: Column(
        children: [
          SizedBox(height: 12),
          _buildFilterChips(),
          SizedBox(height: 8),
          Expanded(
            child: TabBarView(
              controller: _mainTabController,
              children: [
                _buildPilotList(), // Near Me
                _buildPilotList(), // Top Rated
                _buildPilotList(), // Specialists
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xff7057FF),
        shape: CircleBorder(),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => Pilotregistration()));
        },
        child: Icon(Icons.add, color: Colors.white, size: 35),
      ),
    );
  }

  Widget _buildFilterChips() {
    return SizedBox(
      height: 40,
      child: ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: 16),
        scrollDirection: Axis.horizontal,
        itemCount: filters.length,
        itemBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.only(right: 10),
            padding: EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Text(
              filters[index],
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
            ),
          );
        },
      ),
    );
  }

  Widget _buildPilotList() {
    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      itemCount: 4,
      itemBuilder: (context, index) {
        return _buildPilotCard(
          name: index == 0 ? "Arjun Singh" : "Maya Krishnan",
          role: index == 0
              ? "Certified DGCA Pilot\nSpecializes in Wedding Photography"
              : "Agricultural Survey Expert\nAvailable for Crop Monitoring",
          image: "assets/images/pilot${index + 1}.png", // Replace with real image
        );
      },
    );
  }

  Widget _buildPilotCard({required String name, required String role, required String image}) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [BoxShadow(color: Colors.grey.shade300, blurRadius: 5, offset: Offset(0, 3))],
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 26,
            backgroundImage: AssetImage(image),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: 4),
                Text(role, style: TextStyle(fontSize: 12, color: Colors.black87)),
                SizedBox(height: 6),
                Row(
                  children: [
                    Icon(Icons.star, size: 16, color: Colors.orange),
                    SizedBox(width: 4),
                    Text("4.5", style: TextStyle(fontWeight: FontWeight.w600)),
                    SizedBox(width: 6),
                    Text("(86)", style: TextStyle(color: Colors.grey)),
                  ],
                )
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.deepPurple,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
            child: Text("Book Now",style: TextStyle(color: Colors.white),),
          )
        ],
      ),
    );
  }
}
