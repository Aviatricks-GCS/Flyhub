import 'package:flutter/material.dart';

class DroneFullDetailsPage extends StatelessWidget {
  const DroneFullDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Drone Details'),
        centerTitle: false,
        leading: const BackButton(color: Colors.black),
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite_border, color: Colors.black),
            onPressed: () {},
          ),
        ],
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset(
              'assets/images/MaskGroup34@2x.png', // Replace with your actual image asset
              height: 220,
              width: double.infinity,
              fit: BoxFit.cover,
            ), // Replace with actual image
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Mavic Air 2",
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                  Row(
                    children: const [
                      Icon(Icons.star, size: 16, color: Colors.orange),
                      Text(" 4.5", style: TextStyle(fontSize: 14)),
                      Text(" (156)", style: TextStyle(color: Colors.grey)),
                    ],
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "The Syma X5C-1 is a fantastic entry-level quadcopter, perfect for beginners. It’s known for its stability...",
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                  const Divider(height: 24),
                  Row(
                    children: [
                      const CircleAvatar(radius: 25, backgroundImage: AssetImage('assets/profile.jpg')),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text("Prabhakaran P.",
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          Text("Drone Owner  |  Insurance ✅", style: TextStyle(fontSize: 12)),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Mobile Number"),
                      Row(
                        children: [
                          const Text("98765 85472",
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          const SizedBox(width: 8),
                          ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                            ),
                            child: const Text("Call"),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const Text("TYPE", style: TextStyle(color: Colors.grey)),
                  const Text("Agricultural Spray Drone",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 16),
                  const Text("PRICE", style: TextStyle(color: Colors.grey)),
                  const Text("₹800/hour",
                      style: TextStyle(fontSize: 16, color: Colors.black)),
                  const Text("₹2,500/day",
                      style: TextStyle(fontSize: 16, color: Colors.orange)),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Expanded(
                          child: Text(
                            "Kumaramangalam, Tiruchengode, Rasipuram, Tamil Nadu",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Text("View on Map", style: TextStyle(color: Colors.blue)),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text("Specifications",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    children: [
                      _specBox(Icons.flight_takeoff, "Flight Time", "30 mins"),
                      _specBox(Icons.battery_full, "Battery", "500 mah"),
                      _specBox(Icons.water, "Tank", "10 lit"),
                      _specBox(Icons.flash_on, "Charging", "30 mins"),
                      _specBox(Icons.camera_alt, "Camera", "2MP HD"),
                      _specBox(Icons.wifi, "Range", "100 meters"),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        color: const Color(0xFF8A4DFF),
        padding: const EdgeInsets.all(16),
        child: TextButton(
          onPressed: () {},
          child: const Text("Rent Now", style: TextStyle(color: Colors.white, fontSize: 16)),
        ),
      ),
    );
  }

  Widget _specBox(IconData icon, String label, String value) {
    return Container(
      width: 150,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(icon, size: 28, color: Colors.purple),
          const SizedBox(height: 8),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            textDirection: TextDirection.ltr,
            children: [

              Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
              const SizedBox(height: 4),
              Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
            ],
          )

        ],
      ),
    );
  }
}
