import 'package:flutter/material.dart';

class DroneCard extends StatelessWidget {
  final String title;
  final String price;
  final String image;
  final String rating;

  DroneCard({
    super.key,
    required this.title,
    required this.price,
    required this.image,
    required this.rating,
  });

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double cardWidth = screenWidth * 0.42;

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 3,
      child: Container(
        width: cardWidth,
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min, // 🔑 Makes height dynamic
          children: [
            // Image
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                image,
                height: 100,
                fit: BoxFit.contain,
              ),
            ),
            SizedBox(height: 10),
            // Title
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            ),
            SizedBox(height: 5),
            // Price
            Text(
              "$price",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.deepPurple),
            ),
            SizedBox(height: 5),
            // Rating
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(5, (index) {
                int ratingValue = int.tryParse(rating) ?? 0;
                return Icon(
                  Icons.star,
                  size: 16,
                  color: index < ratingValue ? Colors.orange : Colors.grey[300],
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
