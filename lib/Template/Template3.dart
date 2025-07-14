import 'package:flutter/material.dart';

import '../drone_card.dart';


class Template3 extends StatelessWidget {
  final String featureTitle;
  final List featuredDrones;

  Template3({
    required this.featureTitle,
    required this.featuredDrones,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title
        Text(
          featureTitle,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),

        // Grid
        GridView.count(
          //padding: EdgeInsets.all(16),
          crossAxisCount: 2,
          childAspectRatio: 0.75,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          children: featuredDrones.map<Widget>((c) {
            return DroneCard(
              title: c['title'],
              price: c['price'],
              image: c['img'],
              rating: c['rating'],
            );
          }).toList(),
        ),
      ],
    );
  }
}
