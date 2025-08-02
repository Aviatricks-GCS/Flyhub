import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'OrderSuccessPage.dart';

class MyCartPage extends StatefulWidget {
  @override
  State<MyCartPage> createState() => _MyCartPageState();
}

class _MyCartPageState extends State<MyCartPage> {
  final List<Map<String, dynamic>> cartItems = [
    {
      "name": "DJI Mini 3 Pro",
      "price": 25000,
      "rating": 4.5,
      "image": "assets/images/MaskGroup34@2x.png",
    },
    {
      "name": "Mavic Air 2",
      "price": 25000,
      "rating": 4.5,
      "image": "assets/images/MaskGroup34@2x.png",
    },
  ];

  @override
  Widget build(BuildContext context) {
    double totalPrice = cartItems.fold(0, (sum, item) => sum + item["price"]);

    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(onTap:(){
          Navigator.pop(context);
        },
            child: Icon(Icons.arrow_back, color: Colors.black)),
        title: Text("My Cart", style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      backgroundColor: Colors.grey.shade100,
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            _buildAddressSection(),
            SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: cartItems.length,
                itemBuilder: (context, index) {
                  final item = cartItems[index];
                  return _buildCartItem(context, item);
                },
              ),
            ),
            Divider(),
            _buildBottomTotal(totalPrice,context),
          ],
        ),
      ),
    );
  }

  Widget _buildAddressSection() {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              "Deliver to: Raj kumar 600003\nRattan Bazaar, George Town, Chennai, Tamil Nadu...",
              style: TextStyle(fontSize: 13),
            ),
          ),
          TextButton(
            onPressed: () {},
            child: Text("Change"),
            style: TextButton.styleFrom(
              foregroundColor: Colors.purple,
              textStyle: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCartItem(BuildContext context, Map<String, dynamic> item) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Image.asset(
                item["image"],
                width: screenWidth * 0.35,
                height: screenWidth * 0.35,
                fit: BoxFit.contain,
              ),
              SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(item["name"], style: TextStyle(fontWeight: FontWeight.bold)),
                    SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(Icons.star, color: Colors.orange, size: 16),
                        SizedBox(width: 4),
                        Text("${item["rating"]}", style: TextStyle(fontSize: 13)),
                        Text(" (156)", style: TextStyle(fontSize: 12, color: Colors.grey)),
                      ],
                    ),
                    SizedBox(height: 4),
                    Text("₹${item["price"]}", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    Text("🛩 Drone", style: TextStyle(color: Colors.blue)),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          Row(
            children: [
              _buildQtySelector(),
            ],
          ),
          Row(
            children: [

              SizedBox(width: 10),
              Expanded(
                child: Text("Delivery by Jul 7, Mon", style: TextStyle(color: Colors.grey)),
              ),
              Text("Order in ", style: TextStyle(color: Colors.grey)),
              Text("02h 17m 13s", style: TextStyle(color: Colors.red)),
            ],
          ),
          SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildCartButton(Icons.delete_outline, "Remove"),
              _buildCartButton(Icons.bookmark_border, "Save for later"),
              _buildCartButton(Icons.flash_on_outlined, "Buy this now"),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQtySelector() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade600,
        borderRadius: BorderRadius.circular(30),
      ),
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: Row(
        children: [
          Icon(Icons.remove_circle_outline_rounded, size: 20,color: Colors.white,),
          SizedBox(width: 20),
          Text("1", style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white)),
          SizedBox(width: 20),
          Icon(Icons.add_circle_outline_rounded, size: 20,color: Colors.white,),
        ],
      ),
    );
  }

  Widget _buildCartButton(IconData icon, String label) {
    return TextButton.icon(
      onPressed: () {},
      icon: Icon(icon, color: Colors.grey),
      label: Text(label, style: TextStyle(color: Colors.grey)),
    );
  }

  Widget _buildBottomTotal(double totalPrice,BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("₹${totalPrice.toStringAsFixed(0)}", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
          ElevatedButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => OrderSuccessPage()));
            },
            child: Text("PLACE ORDER",style: TextStyle(color: Colors.white),),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.teal,
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
          )
        ],
      ),
    );
  }
}
