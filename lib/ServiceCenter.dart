import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Servicecenter extends StatefulWidget {
  const Servicecenter({super.key});

  @override
  State<Servicecenter> createState() => _ServicecenterState();
}

class _ServicecenterState extends State<Servicecenter> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(56),
        child: SafeArea(
          child: Material(
            elevation: 3,
            shadowColor: Colors.black.withOpacity(0.4),
            child: Container(
              color: Colors.white,
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back, color: Colors.black),
                    onPressed: () => Navigator.pop(context),
                  ),
                  Text(
                    'Service Centers',
                    style: GoogleFonts.lexend(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 16, horizontal: 8),
            width: MediaQuery.of(context).size.width * 0.45,
            height: MediaQuery.of(context).size.height * 0.1,
            child: ElevatedButton(
              onPressed: () async {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xff7057FF),
                //padding: EdgeInsets.symmetric(vertical: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                "Book Service",
                style: GoogleFonts.lexend(fontSize: 15, color: Colors.white),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 16, horizontal: 8),
            width: MediaQuery.of(context).size.width * 0.45,
            height: MediaQuery.of(context).size.height * 0.1,
            child: ElevatedButton(
              onPressed: () async {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xff28C76F),
                //padding: EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                "Call Shop",
                style: GoogleFonts.lexend(fontSize: 15, color: Colors.white),
              ),
            ),
          ),
        ],
      ),

      body: SingleChildScrollView(
        padding:  EdgeInsets.all(18),
        child: Column(
          children: [
            // Top Card with image
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset(
                'assets/images/MaskGroup34@2x.png',
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.25,
                fit: BoxFit.cover,
              ),
            ),

            SizedBox(height: 16),
            // Owner and Location
             Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Mr. Aravind Kumar",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
            ),

             Align(
              alignment: Alignment.centerLeft,
              child: Text("Owner", style: TextStyle(color: Colors.grey)),
            ),

             SizedBox(height: 8),

            Row(
              children: [
                Text("Ratings  "),
                 Icon(Icons.star, color: Colors.orange, size: 18),
                 SizedBox(width: 4),
                 Text("4.8 (120 reviews)"),

              ],
            ),
             SizedBox(height: 8),

            Row(
              children: [
                Text("Distance  "),
                Icon(Icons.location_on, size: 18),
                Text("3.2 km", style: TextStyle(color: Colors.blue)),
              ],
            ),

            SizedBox(height: 16),

            Column(
              children:  [
                InfoItem(icon: Icons.map, text: "View on Map"),
                InfoItem(
                  icon: Icons.access_time,
                  text: "Open Now Closes at 7 PM",
                ),
                InfoItem(icon: Icons.local_shipping, text: "Pickup Available"),
                InfoItem(icon: Icons.verified_user, text: "Warranty Support"),
              ],
            ),
             SizedBox(height: 16),


             Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Service Type",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ),
             SizedBox(height: 8),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children:  [
                ServiceTypeChip(
                  label: "Battery Replacement",
                  icon: Icons.battery_charging_full,
                ),
                ServiceTypeChip(label: "Propeller Repair", icon: Icons.build),
                ServiceTypeChip(
                  label: "Camera Calibration",
                  icon: Icons.camera,
                ),
                ServiceTypeChip(
                  label: "Software Update",
                  icon: Icons.system_update,
                ),
                ServiceTypeChip(label: "Full Diagnostic", icon: Icons.search),
                ServiceTypeChip(
                  label: "Custom Issue",
                  icon: Icons.miscellaneous_services,
                ),
              ],
            ),
             SizedBox(height: 24),
            // Rating stars
             Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Rate this Shop",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ),
             SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: List.generate(
                5,
                (index) =>
                     Icon(Icons.star_border, size: 32, color: Colors.grey),
              ),
            ),
             SizedBox(height: 16),
            // Review box
             Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Write a review",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ),
             SizedBox(height: 8),
            TextField(
              maxLines: 4,
              decoration: InputDecoration(
                hintText: "Write something...",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
             SizedBox(height: 12),
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey[300],
                ),
                child:  Text(
                  "Post",
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ),
             SizedBox(height: 16),
            // Buttons
          ],
        ),
      ),
    );
  }
}

class InfoItem extends StatelessWidget {
  final IconData icon;
  final String text;

  const InfoItem({super.key, required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Icon(icon, size: 20, color: Colors.black54),
          const SizedBox(width: 12),
          Text(text),
        ],
      ),
    );
  }
}

class ServiceTypeChip extends StatelessWidget {
  final String label;
  final IconData icon;

  const ServiceTypeChip({super.key, required this.label, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(label),
      avatar: Icon(icon, size: 18),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    );
  }
}
