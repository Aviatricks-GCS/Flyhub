import 'package:flutter/material.dart';
import 'drone_model.dart';

class DroneCard extends StatelessWidget {
  final DroneModel drone;

  const DroneCard({super.key, required this.drone});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double cardWidth = screenWidth * 0.42; // Adjust based on how many cards you want per row

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 3,
      child: Container(
        width: cardWidth,
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image
            Container(
              height: 100,
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(drone.image),
                  fit: BoxFit.contain,
                ),
              ),
            ),
            SizedBox(height: 10),
            // Name
            Text(
              drone.name,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            ),
            SizedBox(height: 5),
            // Price
            Text(
              "₹ ${drone.price}",
              style: TextStyle(color: Colors.deepPurple),
            ),
            SizedBox(height: 5),
            // Rating
            Row(
              children: List.generate(5, (index) {
                return Icon(
                  Icons.star,
                  size: 16,
                  color: index < drone.rating ? Colors.orange : Colors.grey[300],
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
