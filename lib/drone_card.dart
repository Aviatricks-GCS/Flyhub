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
      color: Colors.white,
      elevation: 3,
      child: Container(
        width: cardWidth,
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min, //
          children: [
            // Image
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                image,
                height: 80,
                fit: BoxFit.contain,
              ),
            ),
            SizedBox(height: 8),
            // Title
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle( fontSize: 12,fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 3),
            // Price
            Text(
              "$price",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 12,fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 3),
            // Rating
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
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
