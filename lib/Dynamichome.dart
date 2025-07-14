import 'package:flutter/material.dart';

import 'MarketPage.dart';
import 'PilotPage.dart';
import 'ProfilePage.dart';
import 'RentalsPage.dart';
import 'homescreen.dart';



class dynamichome extends StatefulWidget {
  @override
  _dynamichomeState createState() => _dynamichomeState();
}

class _dynamichomeState extends State<dynamichome> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    HomeScreen(),     // Your existing home content
    MarketPage(),   // This will be your market page (from the screenshot)
    PilotPage(),
    RentalsPage(),
    ProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() => _selectedIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],


      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.deepPurple,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_bag), label: 'Market'),
          BottomNavigationBarItem(icon: Icon(Icons.person_pin), label: 'Pilot'),
          BottomNavigationBarItem(icon: Icon(Icons.car_rental), label: 'Rentals'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),



    );
  }
}


