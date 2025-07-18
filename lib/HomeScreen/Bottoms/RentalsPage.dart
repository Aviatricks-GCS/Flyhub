import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../CommonClass/ApiClass.dart';
import '../../CommonClass/Utils.dart';

class RentalsPage extends StatefulWidget {
  @override
  State<RentalsPage> createState() => _RentalsPageState();
}

class _RentalsPageState extends State<RentalsPage>
    with TickerProviderStateMixin {
  late TabController _mainTabController;
  final List<String> subFilters = [
    'Today',
    'Professional',
    'With Pilot',
    'Insured',
  ];
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
      var response = await _apiClass.getDroneList("2");
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
            padding: EdgeInsets.symmetric(horizontal: 14,vertical: 10),
            decoration: BoxDecoration(
                color: Color(0xffF7F7F8),
              borderRadius: BorderRadius.circular(16)
            ),
            child: Center(child: Text(subFilters[index],style: GoogleFonts.lexend(fontSize: 12,fontWeight: FontWeight.w500),)),
          );
        },
      ),
    );
  }

  Widget buildRentalCard(Map<String, dynamic> drone) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: CachedNetworkImage(
                    imageUrl: drone['image1'],
                    placeholder: (context, url) => CircularProgressIndicator(),
                    // or a custom widget
                    errorWidget: (context, url, error) => Image.asset(
                      'assets/images/MaskGroup34@2x.png',
                      height: 90,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                    height: 90,
                    width: double.infinity,
                    fit: BoxFit.fill,
                  ),
                ),

                Positioned(
                  top: 8,
                  right: 8,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 4, vertical: 1),
                    decoration: BoxDecoration(
                      color: Colors.green,
                      border: Border.all(color: Colors.white, width: 0.5),
                      borderRadius: BorderRadius.circular(3),
                    ),
                    child: Text(
                      '9.2 km away',
                      style: GoogleFonts.lexend(
                        color: Colors.white,
                        fontSize: 10,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 4),
                Text(
                  drone['model'] ?? 'Drone Name',
                  style: GoogleFonts.lexend(fontWeight: FontWeight.bold),
                ),
                Text(
                  drone['specs'] ?? 'Specifications',
                  style: GoogleFonts.lexend(
                    fontSize: 10,
                    color: Colors.grey[700],
                  ),
                ),
                SizedBox(height: 4),
                Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          '₹${drone['price_per_hour'] ?? '0'}',
                          style: GoogleFonts.lexend(color: Colors.grey[700]),
                        ),
                        Text(
                          '/hour',
                          style: GoogleFonts.lexend(
                            fontSize: 10,
                            color: Colors.deepOrange,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(width: 10),
                    Row(
                      children: [
                        Text(
                          '₹${drone['price_per_day'] ?? '0'}',
                          style: GoogleFonts.lexend(color: Colors.grey[700]),
                        ),
                        Text(
                          '/day',
                          style: GoogleFonts.lexend(
                            fontSize: 10,
                            color: Colors.deepOrange,
                          ),
                        ),
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
                      Text(
                        'Insurance',
                        style: GoogleFonts.lexend(
                          fontSize: 10,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                SizedBox(
                  width: double.infinity,
                  height: 30,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xff7057FF),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    child: Text(
                      'Book Now',
                      style: GoogleFonts.lexend(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ],
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
        leading: Icon(Icons.arrow_back),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        bottom: TabBar(
          controller: _mainTabController,
          labelColor: Color(0xff7057FF),
          unselectedLabelColor: Colors.grey,
          indicatorColor: Color(0xff7057FF),
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
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.68,
                      /*mainAxisSpacing: 1,
                      crossAxisSpacing: 1,*/
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
        backgroundColor: Color(0xff7057FF),
        shape: CircleBorder(),
        onPressed: () {},
        child: Icon(Icons.add, color: Colors.white, size: 35),
      ),
    );
  }
}
