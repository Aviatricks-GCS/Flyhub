import 'package:flutter/material.dart';

import 'OrderCenterPage.dart';

class DroneDetailPage extends StatelessWidget {
  var Drone;


   DroneDetailPage({super.key, required this. Drone});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DJI Mini 3 Pro'),
        leading: const BackButton(),
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite_border),
            onPressed: () {},
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Drone Image
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset(
                'assets/images/MaskGroup34@2x.png', // Replace with your actual image asset
                height: 220,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 12),

            // Drone category
            Row(
              children: const [
                Icon(Icons.shopping_cart_outlined, color: Colors.purple),
                SizedBox(width: 6),
                Text("Drone", style: TextStyle(color: Colors.purple)),
              ],
            ),
            const SizedBox(height: 8),

            // Drone Name
            const Text(
              "DJI Mini 3 Pro",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 6),

            // Price
            const Text(
              "₹25,500",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 12),

            // Description
            const Text(
              "Made in Sweden, Hasselblad cameras are renowned for their iconic ergonomic design, uncompromising image quality, and Swedish craftsmanship. Since 1941.",
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 20),

            // Location
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  const Icon(Icons.location_on, color: Colors.teal),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          "FLYTUTOR TECHNOLOGIES PRIVATE LIMITED",
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                        Text(
                          "Manickampalayam, Koothampoondi,\nTamil Nadu - 637202",
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                  const Icon(Icons.arrow_forward_ios, size: 16),
                ],
              ),
            ),
            const SizedBox(height: 30),

            // Add to Cart Button
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {
                  // Add to cart action
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => OrderCenterPage()
                    ),
                  );
                },
                icon:  Icon(Icons.shopping_cart,color: Colors.white,),
                label:  Text(
                  "ADD TO CART",
                  style: TextStyle(fontSize: 16,color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
