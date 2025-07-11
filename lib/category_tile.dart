import 'package:flutter/material.dart';

class CategoryTile extends StatelessWidget {
  final String icon;
  final String label;

  const CategoryTile({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          padding: EdgeInsets.symmetric(vertical: 8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.network(
                    icon,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              SizedBox(height: 5),
              SizedBox(
                width: 70,
                child: Text(
                  label,
                  style: TextStyle(fontSize: 10,),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  softWrap: true,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
