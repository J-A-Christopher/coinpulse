import 'package:coinpulse/home/analytics.dart';
import 'package:coinpulse/home/dashboard.dart';
import 'package:coinpulse/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import '../utils/colors.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _selectedIndex = 0;
  final List<Widget> _screens = [
    const HomePage(),
    const DashBoard(),
    const Analytics()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: SizedBox(
        height: 70,
        child: GNav(
          selectedIndex: _selectedIndex,
          onTabChange: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          gap: 8,
          backgroundColor: ColorsUsed.secondaryColor,
          color: Colors.white,
          activeColor: Colors.white,
          tabs: const [
            GButton(
              icon: Icons.home,
              text: 'Home',
            ),
            GButton(
              icon: Icons.dashboard,
              text: 'Dashboard',
            ),
            GButton(
              icon: Icons.trending_up,
              text: 'Analytics',
            )
          ],
        ),
      ),
      body: _screens.elementAt(_selectedIndex),
    );
  }
}
