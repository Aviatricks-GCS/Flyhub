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
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title
          Text(
            featureTitle,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),

          SizedBox(height: 10.0,),
          // Grid
          GridView.count(
            padding: EdgeInsets.symmetric(horizontal: 4),
            crossAxisCount: 2,
            childAspectRatio: 0.85,
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
      ),
    );
  }
}
