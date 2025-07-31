import 'package:flutter/material.dart';

class MyDroneListPage extends StatelessWidget {
  final List<Map<String, dynamic>> drones = [
    {
      "type": "Spray",
      "name": "Skyx Kisaan",
      "price": "₹500/hour",
      "status": "Pending",
      "image":
      "https://i.imgur.com/BoN9kdC.png", // Replace with your image URLs
    },
    {
      "type": "Camera",
      "name": "DJI Phantom",
      "price": "₹1200/hour",
      "status": "Approved",
      "image": "https://i.imgur.com/3ZQ3Z2G.png",
    },
    {
      "type": "Racing",
      "name": "StormX R5",
      "price": "₹900/hour",
      "status": "Rejected",
      "image": "https://i.imgur.com/I80W1Q0.png",
    },
  ];

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case "pending":
        return Colors.orange;
      case "approved":
        return Colors.green;
      case "rejected":
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Drone List", style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Icon(Icons.arrow_back, color: Colors.black),
      ),
      backgroundColor: Colors.grey[100],
      body: ListView.builder(
        itemCount: drones.length,
        padding: EdgeInsets.all(16),
        itemBuilder: (context, index) {
          final drone = drones[index];
          return Container(
            margin: EdgeInsets.only(bottom: 16),
            padding: EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 6,
                  offset: Offset(0, 3),
                )
              ],
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Text content
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        drone["type"],
                        style: TextStyle(
                          color: Colors.teal,
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                        ),
                      ),
                      SizedBox(height: 6),
                      Text(
                        "Drone : ${drone["name"]}",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: Colors.black87,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        drone["price"],
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.teal,
                        ),
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Text(
                      "Status : ",
                            style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.w500,
                            ),
                          ),

                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 25, vertical: 8),
                            decoration: BoxDecoration(
                              color: _getStatusColor(drone["status"]),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              drone["status"],
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          SizedBox(width: 10),
                          OutlinedButton.icon(
                            onPressed: () {
                              print("Details for ${drone["name"]}");
                            },
                            icon: Icon(Icons.arrow_forward, size: 14),
                            label: Text(
                              "View Details",
                              style: TextStyle(fontSize: 12),
                            ),
                            style: OutlinedButton.styleFrom(
                              side: BorderSide(color: Colors.deepPurpleAccent),
                              foregroundColor: Colors.deepPurpleAccent,
                              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                // Image + delete icon
                Stack(
                  children: [
                    /*ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(
                        drone["image"],
                        width: 90,
                        height: 80,
                        fit: BoxFit.cover,
                      ),
                    ),*/
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.asset(
                        'assets/images/MaskGroup34@2x.png', // Replace with your actual image asset
                        height: 220,
                        width: 200,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      top: 4,
                      right: 4,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.black54,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(Icons.delete, size: 25, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
