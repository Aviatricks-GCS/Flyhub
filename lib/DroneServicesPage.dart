import 'package:flutter/material.dart';

class DroneServicesPage extends StatelessWidget {
  final List<Map<String, String>> services = [
    {'icon': '🧴', 'label': 'Crop\nSpraying'},
    {'icon': '📐', 'label': 'Land\nSurvey'},
    {'icon': '📷', 'label': 'Photography'},
    {'icon': '🔍', 'label': 'Inspection'},
    {'icon': '🗺️', 'label': 'Mapping'},
    {'icon': '🚚', 'label': 'Delivery'},
    {'icon': '🎥', 'label': 'Videography'},
    {'icon': '🛡️', 'label': 'Security'},
  ];

  final List<Map<String, String>> drones = [
    {
      'name': 'DJI Mini 3 Pro',
      'desc': '4K Camera, 34min Flight',
      'hour': '₹800/hour',
      'day': '₹2,500/day',
      'image': '',
    },
    {
      'name': 'Mavic Air 2',
      'desc': 'Crop Spray, 60min Flight',
      'hour': '₹800/hour',
      'day': '₹2,500/day',
      'image': '',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 1,
        backgroundColor: Colors.white,
        title: Text("Drone Services", style: TextStyle(color: Colors.black)),
        leading: BackButton(color: Colors.black),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Service Icons Grid
            GridView.count(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              crossAxisCount: 4,
              childAspectRatio: 0.85,
              children: services.map((service) {
                return Column(
                  children: [
                    CircleAvatar(
                      radius: 24,
                      backgroundColor: Colors.purple.shade50,
                      child: Text(service['icon']!, style: TextStyle(fontSize: 20, color: Colors.purple)),
                    ),
                    SizedBox(height: 6),
                    Text(
                      service['label']!,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 12, color: Colors.black),
                    ),
                  ],
                );
              }).toList(),
            ),
            const SizedBox(height: 24),

            // Available Nearby Drones
            Text(
              "Available Drone at nearby Location",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 12),

            GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: drones.length,
              padding: const EdgeInsets.only(top: 8),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 14,
                crossAxisSpacing: 14,
                childAspectRatio: 0.7, // adjust for card height/width
              ),
              itemBuilder: (context, index) {
                final drone = drones[index];
                return Card(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  elevation: 1,
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Add back your image if needed
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.asset(
                            'assets/images/MaskGroup34@2x.png',
                            width: double.infinity,
                            height: 100,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                drone['name']!,
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                              decoration: BoxDecoration(
                                color: Colors.green.shade100,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                "9.5 km",
                                style: TextStyle(fontSize: 10, color: Colors.green.shade800),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(drone['desc']!, style: TextStyle(fontSize: 12)),
                        const SizedBox(height: 2),
                        Text(drone['hour']!, style: TextStyle(fontSize: 12)),
                        Text(drone['day']!, style: TextStyle(fontSize: 12, color: Colors.orange)),
                        const SizedBox(height: 4),
                        Text("Insurance ✅", style: TextStyle(fontSize: 12, color: Colors.grey)),
                        Spacer(),
                        Center(
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
                            child: Text("Book Now", style: TextStyle(fontSize: 12)),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),

          ],
        ),
      ),
    );
  }
}
