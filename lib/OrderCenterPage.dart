import 'package:flutter/material.dart';

import 'OrderSuccessPage.dart';

class OrderCenterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Order center", style: TextStyle(fontWeight: FontWeight.bold)),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          elevation: 3,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                /// Drone Info
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset(
                      'assets/images/MaskGroup34@2x.png', // Replace with your asset image
                      width: 150,
                      height: 150,
                      fit: BoxFit.contain,
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("DJI Mini 3 Pro",
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                          SizedBox(height: 4),
                          Text("₹25,500", style: TextStyle(fontSize: 16, color: Colors.grey[700])),
                          SizedBox(height: 8),
                          Row(
                            children: [
                              Icon(Icons.remove_red_eye, size: 16, color: Colors.grey),
                              SizedBox(width: 4),
                              Text("1"),
                              Spacer(),
                              Icon(Icons.delete_outline, color: Colors.grey),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 24),

                /// Drone Label
                Row(
                  children: [
                    Icon(Icons.local_mall, color: Colors.purple),
                    SizedBox(width: 8),
                    Text("Drone", style: TextStyle(color: Colors.purple)),
                  ],
                ),

                SizedBox(height: 16),

                /// Address
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.location_on, color: Colors.teal),
                    SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("FLYTUTOR TECHNOLOGIES PRIVATE LIMITED",
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          SizedBox(height: 4),
                          Text("Manickampalayam, Koothampoondi,\nTamil Nadu - 637202"),
                        ],
                      ),
                    ),
                    Icon(Icons.chevron_right, color: Colors.grey),
                  ],
                ),

                SizedBox(height: 24),

                /// Payment Card
                Row(
                  children: [
                    Icon(Icons.credit_card, color: Colors.indigo),
                    SizedBox(width: 12),
                    Expanded(
                      child: Text("My visa card\n6246**** **** 9566"),
                    ),
                    Icon(Icons.chevron_right, color: Colors.grey),
                  ],
                ),

                SizedBox(height: 24),

                /// Order Details
                Text("Order Details", style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: 12),
                _orderRow("Price", "₹20,500"),
                _orderRow("Discount", "₹500"),
                Divider(),
                _orderRow("Need to pay", "₹20,000", isBold: true),

                SizedBox(height: 24),

                /// Pay Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      // handle payment action
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => OrderSuccessPage()
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.purple,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      padding: EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: Text("PAY TO BUY", style: TextStyle(color: Colors.white)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _orderRow(String label, String value, {bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: isBold ? TextStyle(fontWeight: FontWeight.bold) : null),
          Text(value, style: isBold ? TextStyle(fontWeight: FontWeight.bold) : null),
        ],
      ),
    );
  }
}
