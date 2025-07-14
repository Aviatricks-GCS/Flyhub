import 'package:flutter/material.dart';

import '../category_tile.dart';

class Template1 extends StatefulWidget {
  final List items;

  Template1({required this.items});

  @override
  State<Template1> createState() => _Template1State();
}

class _Template1State extends State<Template1> {
  @override
  Widget build(BuildContext context) {
    return GridView.count(
      padding: EdgeInsets.only(left: 16,right: 16,top: 10),
      crossAxisCount: 4,
      childAspectRatio: 0.7,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      children: widget.items
          .map<Widget>((c) => CategoryTile(icon: c['image'], label: c['cname']))
          .toList(),
    );
  }
}
