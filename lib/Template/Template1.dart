import 'package:flutter/material.dart';
import 'package:flyhub/FindJobs.dart';
import 'package:flyhub/MaintenancePage.dart';
import 'package:flyhub/Training.dart';

import '../CommonClass/Utils.dart';
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
      padding: EdgeInsets.only(left: 20, right: 20, top: 10),
      crossAxisCount: 4,
      childAspectRatio: 0.7,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      children: widget.items.map<Widget>((item) {
        return CategoryTile(
          icon: item['image'],
          label: item['cname'],
          onTap: () {
            String clickUrl = item['click_url'];
            switch (clickUrl) {
              case "hire_pilots":
                break;
              case "jobs_portal":
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Findjobs()),
                );
                break;
              case "training":
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Training()),
                );
                break;
              case "maintenance":
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Maintenancepage()),
                );
                break;
              default:

                break;
            }
          },
        );
      }).toList(),
    );
  }
}
