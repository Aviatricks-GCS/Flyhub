import 'package:flutter/material.dart';
import 'package:flyhub/AddDrone.dart';

class RegisterPage extends StatelessWidget {
  final List registerList;
  final String appBar_title;
  final String form_title;

  RegisterPage({
    required this.registerList,
    required this.appBar_title,
    required this.form_title,
  });

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          appBar_title,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [Icon(Icons.favorite_border)],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              form_title,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            SizedBox(height: 12),
            ...registerList.map((item) {
              return InkWell(
                onTap: () {
                  if (item["status"] == "success") {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            Adddrone(clickUrl: item["click_url"]),
                      ),
                    );
                  } else {}
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 6),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: ListTile(
                    title: Text(item['title']),
                    trailing: ElevatedButton.icon(
                      icon: Image.network(
                        item['right_img'],
                        fit: BoxFit.contain,
                      ),
                      label: Text(item['right_text']),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                Adddrone(clickUrl: item['click_url']),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                        shape: StadiumBorder(),
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }
}
