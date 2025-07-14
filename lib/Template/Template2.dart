import 'package:flutter/material.dart';

class Template2 extends StatefulWidget {
  final String title;
  final String rightImg;
  final String leftImg;
  final List items;

  Template2({
    required this.title,
    required this.rightImg,
    required this.leftImg,
    required this.items,
  });

  @override
  State<Template2> createState() => _Template2State();
}

class _Template2State extends State<Template2> {
  @override
  Widget build(BuildContext context) {

    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.deepPurple,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8)),
        ),
        child: Row(
          //mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.network(widget.leftImg, width: 10, height: 10),
            SizedBox(width: 8),
            SizedBox(
              width: width * 0.65 ,
              child: Text(
                widget.title,
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white,overflow: TextOverflow.ellipsis),
              ),
            ),
            SizedBox(width: 8),
            Image.network(widget.rightImg, width: 24, height: 24),
          ],
        ),
      ),
    );
  }
}
