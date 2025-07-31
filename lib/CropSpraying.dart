import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../CommonClass/ApiClass.dart';
import '../../CommonClass/Utils.dart';
import 'DroneFullDetailsPage.dart';
import 'HomeScreen/Dynamichome.dart';


class CropSprayingPage extends StatefulWidget {
  @override
  State<CropSprayingPage> createState() => _CropSprayingPageState();
}

class _CropSprayingPageState extends State<CropSprayingPage>
    with TickerProviderStateMixin {
  late TabController _mainTabController;

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


  Widget buildSprayCard(Map<String, dynamic> drone) {
    double screenWidth = MediaQuery.of(context).size.width;

    // Dynamic scaling factors
    double imageHeight = screenWidth * 0.25;
    return GestureDetector(
      onTap: (){
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => DroneFullDetailsPage()),
        );
      },
      child: Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        margin: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
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


                ],
              ),
              Spacer(),
              Container(
                padding: EdgeInsets.fromLTRB(10, 20, 10, 20),
                child: ElevatedButton(
                  onPressed: () {

                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purple,
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [Text("Book Now", style: TextStyle(fontSize: 12,color: Colors.white))]),
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
        title: Text('Crop Spraying', style: GoogleFonts.lexend()),
        leading: GestureDetector(
            onTap: (){
              Navigator.of(context).pop();
            },
            child: Icon(Icons.arrow_back)),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: Column(
        children: [
          SizedBox(height: 10),
          Expanded(
            child: droneList.isEmpty
                ? Center(child: Text("No drones available"))
                : GridView.builder(
              padding: const EdgeInsets.only(top: 8),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 14,
                crossAxisSpacing: 14,
                childAspectRatio: 0.7,
              ),
              itemCount: droneList.length,
              itemBuilder: (context, index) {
                return buildSprayCard(droneList[index]);
              },
            ),
          ),
        ],
      ),

    );
  }
}
