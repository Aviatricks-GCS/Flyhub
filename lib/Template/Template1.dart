import 'package:flutter/material.dart';
import 'package:flyhub/DroneServicesPage.dart';
import 'package:flyhub/JobsPage.dart';

import '../CommonClass/Utils.dart';
import '../HomeScreen/Dynamichome.dart';
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
              Utils.bottomtoast(context, clickUrl);

              switch (clickUrl) {

                case "pandiya_check":
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                      builder: (context) => Dynamichome(selectedIndex: 1),
                    ),
                        (Route<dynamic> route) => false,
                  );
                  break;
                case "parts_accessories":
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                      builder: (context) => Dynamichome(selectedIndex: 1),
                    ),
                        (Route<dynamic> route) => false,
                  );
                  break;

                case "hire_pilots":
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => JobsPage()),
                  );
                  break;

                case "drone_services":
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => DroneServicesPage()),
                  );
                  break;





                default:
                // Optional: handle unknown clickUrl
                  break;
              }
            }

        );
      }).toList(),
    );
  }
}
