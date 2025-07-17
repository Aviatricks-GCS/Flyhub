import 'package:flutter/material.dart';

import 'Bottoms/MarketPage.dart';
import 'Bottoms/PilotPage.dart';
import 'Bottoms/ProfilePage.dart';
import 'Bottoms/RentalsPage.dart';
import 'Bottoms/homescreen.dart';


class Dynamichome extends StatefulWidget {

  final int selectedIndex;

  const Dynamichome({required this.selectedIndex,});


  @override
  _DynamichomeState createState() => _DynamichomeState();
}

class _DynamichomeState extends State<Dynamichome> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    HomeScreen(), // Your existing home content
    MarketPage(), // This will be your market page (from the screenshot)
    PilotPage(),
    RentalsPage(),
    ProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() => _selectedIndex = index);
  }

  @override
  void initState() {
    super.initState();
    indexSelection();
  }

  void indexSelection() {
    setState(() {
      _selectedIndex = widget.selectedIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: _selectedIndex == 0, // Only allow pop if already at index 0
      onPopInvoked: (bool didPop) {
        if (!didPop && _selectedIndex != 0) {
          // If not at index 0 and pop was attempted, navigate to index 0 instead
          setState(() {
            _selectedIndex = 0;
          });
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: _screens[_selectedIndex],

        bottomNavigationBar: BottomNavigationBar(
          elevation: 20,
          backgroundColor: Colors.white,
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.deepPurple,
          unselectedItemColor: Colors.grey,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(
                icon: Icon(Icons.shopping_bag), label: 'Market'),
            BottomNavigationBarItem(icon: Icon(Icons.person_pin), label: 'Pilot'),
            BottomNavigationBarItem(
                icon: Icon(Icons.car_rental), label: 'Rentals'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          ],
        ),


      ),
    );
  }
}


