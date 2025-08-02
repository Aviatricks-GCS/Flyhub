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
    final screenWidth = MediaQuery.of(context).size.width;

    // Dynamically scale sizes
    final double cardWidth = screenWidth * 0.42;
    final double imageHeight = screenWidth * 0.2;
    //final double fontSizeTitle = screenWidth * 0.025;
    //final double fontSizePrice = screenWidth * 0.02;
    final double iconSize = screenWidth * 0.04;

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: Colors.white,
      elevation: 3,
      child: Container(
        width: cardWidth,
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Image
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                image,
                height: imageHeight,
                width: double.infinity,
                fit: BoxFit.contain,
              ),
            ),
            SizedBox(height: 8),
            // Title
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 3),
            // Price
            Text(
              price,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.grey[700],
              ),
            ),
            SizedBox(height: 3),
            // Rating
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: List.generate(5, (index) {
                int ratingValue = int.tryParse(rating) ?? 0;
                return Icon(
                  Icons.star,
                  size: iconSize,
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
