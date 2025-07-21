import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        leading: Icon(Icons.arrow_back),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple,
                padding: EdgeInsets.symmetric(horizontal: 12),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
              ),
              child: Text('Edit Profile', style: TextStyle(fontSize: 12)),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20),

            // Profile Info
            CircleAvatar(
              radius: 35,
              backgroundColor: Colors.black,
              child: Text('RK', style: TextStyle(color: Colors.white, fontSize: 22)),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Raj Kumar', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                SizedBox(width: 4),
                Icon(Icons.verified, color: Colors.blue, size: 18),
              ],
            ),
            SizedBox(height: 4),
            Text('DGCA Certified Pilot · Chennai, Tamil Nadu',
                style: TextStyle(fontSize: 12, color: Colors.grey[700])),

            SizedBox(height: 20),

            // Menu Options
            buildMenuItem(Icons.shopping_bag, "My Order"),
            buildMenuItem(Icons.shopping_cart, "My Cart"),
            buildMenuItem(Icons.favorite, "Your Favorite"),
            buildMenuItem(Icons.star, "Reviews"),

            // Language Option
            ListTile(
              leading: Icon(Icons.language),
              title: Text("Language"),
              trailing: Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.purple,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text("English", style: TextStyle(color: Colors.white, fontSize: 12)),
              ),
            ),

            // Adding Information
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(12)),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text("Adding Information",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                    ),
                    Divider(height: 1),
                    buildAddRow("Add Drone (Sell)"),
                    buildAddRow("Add Drone (Rental)"),
                    buildAddRow("Add Jobs"),
                    buildAddRow("Add Service"),
                    buildAddRow("Add Spare Parts"),
                    buildAddRow("Add Certifications"),
                  ],
                ),
              ),
            ),

            SizedBox(height: 20),

            // Account Settings Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(12)),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text("Account Settings",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                    ),
                    Divider(height: 1),
                    buildSettingsRow("Personal Information"),
                    buildSettingsRow("Payment Methods"),
                    buildSettingsRow("Notifications", badge: "2"),
                    buildSettingsRow("Help & Support"),
                    SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.purple,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10))),
                      child: Text("Logout"),
                    ),
                    SizedBox(height: 10),
                  ],
                ),
              ),
            ),

            SizedBox(height: 20),

            // Certifications Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(12)),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text("Certifications",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                    ),
                    Divider(height: 1),
                    buildCertRow("DGCA Drone Pilot License"),
                    buildCertRow("Agricultural Operations"),
                    buildCertRow("Commercial Photography"),
                    buildCertRow("Safety Training", expiry: "Expires Dec 2025"),
                  ],
                ),
              ),
            ),

            SizedBox(height: 20),

            // Help & Support Links
            buildFooterLink(Icons.help_outline, "Help & support"),
            buildFooterLink(Icons.question_answer, "FAQS"),
            buildFooterLink(Icons.description, "Terms and Condition"),
            buildFooterLink(Icons.lock_outline, "Privacy Policy"),
            buildFooterLink(Icons.feedback_outlined, "Send Feedback"),

          ],
        ),
      ),


    );
  }


  Widget buildSettingsRow(String label, {String? badge}) {
    return ListTile(
      title: Text(label),
      trailing: badge != null
          ? Stack(
        alignment: Alignment.center,
        children: [
          Icon(Icons.chevron_right),
          Positioned(
            top: 4,
            right: 16,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(badge, style: TextStyle(color: Colors.white, fontSize: 10)),
            ),
          )
        ],
      )
          : Icon(Icons.chevron_right),
    );
  }

  Widget buildCertRow(String title, {String? expiry}) {
    return ListTile(
      title: Text(title),
      trailing: expiry != null
          ? Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.calendar_month, color: Colors.orange, size: 16),
          SizedBox(width: 4),
          Text(expiry, style: TextStyle(color: Colors.orange, fontSize: 12)),
        ],
      )
          : Icon(Icons.verified, color: Colors.teal),
    );
  }

  Widget buildFooterLink(IconData icon, String title) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      trailing: Icon(Icons.chevron_right),
    );
  }



  Widget buildMenuItem(IconData icon, String title) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      trailing: Icon(Icons.chevron_right),
    );
  }

  Widget buildAddRow(String label) {
    return ListTile(
      title: Text(label),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text("Add", style: TextStyle(color: Colors.purple)),
          SizedBox(width: 5),
          Icon(Icons.qr_code_scanner, color: Colors.grey),
        ],
      ),
    );
  }
}
